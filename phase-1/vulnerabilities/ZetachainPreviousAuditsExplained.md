## Zetachain Previous Cosmos Audits Explained 
- Two previous audits of the ``zetacore`` and ``zetaclient`` were performed by Zellic and Halborn.
- The Halborn audit was recently removed from being online. I had some notes from previously reading it and tried to reconstruct it to the best of my ability.
- Below is an explanation of all the Cosmos SDK and client vulnerabilities discovered from the previous two audits in sufficient detail to understand them. 

#### Zellic 3.1: Any ZetaSent events are processed regardless of what contract emits them (critical)
- [Ethermint](https://docs.ethermint.zone/) is an EVM implementation within the Cosmos SDK ecosystem. This particular implementation is essentially the only one used by projects. Zetachain uses Ethermint for the zEVM.
- To send funds from the zEVM to another chain, a ``ZetaSent`` event is emitted by the EVM by the Connector contract. 
- The event ``orginator`` was not validated or checked in this case. The contract should have checked that the sender was the Connector contract. 
- Because this was not validated, an atacker could send this event to trigger the bridging functionality from an arbitrary contract. This allowed for arbitrary creation of events to other blockchains without actually locking the funds.

#### Zellic 3.2: Bonded validators can trigger reverts for successful transactions (critical) 
- Zetachain messages (essentially Cosmos SDK functions) for adding and removing transactions to be signed by the TSS address. 
- These are the ``MsgAddToOutTxTracker`` and ``MsgRemoveFromOutTxTracker`` messages. Only bonded validators are allowed to submit these. This is a dangerous primitive to give. 
- Since they can *add* and *remove* they can *swap* transactions in and out to get them voted on. A flow for explotation is shown below: 
    1. Transfer some ETH from Goerli back to Goerli. The two chains do not matter as long as they are both EVM chains.
    2. The event will be processsed by the voting and the TSS address will sign the request to go back to the EVM chain. The funds have been delivered. 
    3. Remove the transaction using the ``MsgRemoveFromOutTxTracker`` message. At this point, Zetachain is waiting on a response (voting) that the transaction succeeded on the EVM chain. 
    4. Call ``MsgAddToOutTxTracker`` to add a transaction that had previously failed with the original nonce. 
    5. The voting process will believe that the ``removed transaction`` failed or reverted because of this. 
    6. The TSS address calls the ``onZetaRevert`` function of the contract to give a refund. 
Since the transaction is sent and a refund is provided, this results in a *double spend*.


#### Zellic 3.3: Sending ZETA to a Bitcoin network results in BTC being sent instead (critical)
- There are three different transaction types:
    1. CoinType_Zeta - The zetchain itself
    2. CoinType_Gas - Bitcoin, Dogecoin and others
    3. CoinType_ERC20 - USDT, USDC
- The TSS address is a made up of a collection of validators who own small amounts of the key. Collectively, they can sign a transaction like a multi-sig address once something is voted on. This is the ``zetaclient`` process. It determines the voting and TSS signing process. 
- When deciding to sign a ``CoinType_Gas`` transaction (bitcion, Dogecoin, etc.), the program assumed that only Bitcoin coins were being sent to the blockchain. The bitcoin signer would see the transaction sent to the Bitcoin address and sign it. 
- However, the coin type was not verified at all. As a result, an attacker could send a little amount of ZETA to a bitcoin blockchain, which would result in the Bitcoin being sent to the users address. 
- A tiny fraction of Zeta (1/1e10) could be used to receive one BTC in return as a result.


### Zellic 3.4 Race condition in Bitcoin client leads to double spend (critical)
- The bitcoin client is used both for watching Zetachain cross-chain transactions as well as relaying transaction transctions to and from the Bitcoin chain. There is a bunch of functionality happening all at once. 
- There are four main processes running in different threads: 
    1. ``isSendOutTxProcessed``: Whether the transaction in question was submitted for relaying
    2. ``startSendScheduler``: Gets all pending cross chain transcations (CCTX) to see if they have been submitted. 
    3. ``TryProcessOutTx``: Signs and broadcasts CCTXs then adds them to a tracker on Zetachain. 
    4. ``observeOutTx``: Queries for all transactions in the crosschain module and adds to them to processed queue. 
- Since these all run in different threads without any locking or communication, they are very *racy* by nature. 
- If funky ordering happens here, then it's possible that a transaction gets sent **twice**. This leads to a double spend from just a normal workflow. 
- TODO...


#### Zellic 3.5/Halborn: Not waiting for minimum number of block confirmations results in double spend (critical)
- Blockchains sometimes have soft forks that occur from different parts of the network. By default, the deepest fork is taken to be the real one. This is called a blockchain *reorg*. 
- The Zetachain was waiting for a single block confirmation before the transaction was considered valid. 
- If a reorg occurred then a transaction could happen on fork A observed by the relayer then a reorg could occur, removing the transaction. 
- This results in the user having the Bitcoin (instead of the TSS address) and the user having funds within the Zetachain ecosystem. Essentially, it creates a *double spend*. 


#### Zellic 3.6: Multiple events in the same transaction causes loss of funds and chain halting
- When transfering funds out of the zEVM onto another blockchain the ``ZetaConnectorZEVM`` contract emits events for the Zetachain Cosmos SDK module to handle. 
- To store this information, the event is internally hashed. Then, when the event is voted on, it is easy to check what is exactly being voted on. 
- As a result, *two events* in the same block with the *same parameters* will have the **same hash**. This results in two transactions being processed as a single one. This could happen accidently in the course of action or on purpose. 
- If a user sends 5000Zeta to themselves twice, they should receive 10000Zeta. However, they will only receive 5000Zeta because of the hash collision. 
- Additionally, the *nonce* will be incremented twice even though a single transaction will be processed. Since the Ethereum receiving side enforces the *ordering* of these nonces, there will be a gap in processed transaction nonces. Since transactions cannot be processed, it results in a halting of the bridge. 

#### Zellic 3.7: Missing authentication when adding node keys (critical) 
- The function ``SetNodeKeys`` is used for supplying a public key used for TSS signing. Since the TSS address holds all of the funds as a distributed entity, it's important that this is kept secure.
- There is no verification or authentication on addition of the public key. This is a classic access control issue.
- If an attacker adds their own TSS public key, they could potentially control enough signatures to pass the threshold and sign the transactions. Or, the TSS address will not work, resulting in a denial of service. 


#### Zellic 3.8: Missing nil check when parsing client event (high) 
- The ``zetaclient`` is a Go binary that listens for incoming transactions to handle incoming and outgoing events, sign transactions and more. 
- When processing an outgoing transaction, the function ``GetChainFromChainId()`` is called. If not found, then ``nil`` is returned. 
- ``zetaclient`` calls ``Int64`` on the output of this without checking for ``nil``. An attacker is able to force this to occur by giving an invalid chain ID. 
- This would lead to an invalid conversion and a panic within the client. Since the client is incredibly important to the relaying and signing between different chains, this would halt the bridging. 


#### Zellic 3.9: Case-sensitive address check allows for double signing
- The function ``IsDuplicateSigner()`` is used to check if an address is already within a group of signers. This is used within the ``MsgCreateTSSVoter`` message used for voting on a new TSS key.
- The validation loops over a list of addresses and confirms that the current ``msg.sender`` is not one of them. If so, the votes counts. 
```
func isDuplicateSigner(creator string, signers []string) bool{
    for _,v range signers {
        if creator === v{
            return true 
        }
    }
    return false
}
```
- Within Cosmos SDK chains, addresses are alphanumeric. Both an all capitalized and all lowercase address are valid. 
- The validation above does not consider this, leading to a user being able to vote *twice*. If an attacker controlled multiple validators, this could drastically change the voting process. 

#### Zellic 3.10: No panic handler in Zetaclient may halt cross-chain communication
- The ``zetaclient`` is a crucial part of the ecosystem. Although zetachain will function fine on its own, all bridging and cross-chain functionality would be broken. 
- Having this client be resilient to crashes is important as a result. There were no protections against Go panics recovering at the time of this audit. 
- If a crash occurred, it would prevent all transactions from both the EVM and Bitcoin signers to go through. 
- One way a crash was found was sending in invalid Bitcoin address. Upon calling ``btcutil.DecodeAddress()`` with an invalid address, a crash would occur. 


#### Zellic 3.11: Ethermint Ante handler bypass (high) 
- The ``antehandler`` is the first part of the walled-garden of the Cosmos SDK messages. It performs validations such as signature validation, gas fee checks and more. To learn more on how this works, go to [docs](https://docs.cosmos.network/v0.45/modules/auth/03_antehandlers.html). 
- The Ethermint application modified the standard antehandler for their EVM purposes. However, when doing this, they failed to understand the security implications. The antehandler is only verified for the entire transaction and not any other messages nested inside of it. In particular, the antehandler was not checked on *nested* messages via ``MsgExec``. Additionally, a special extension flag made it possible to bypass the gas verification as well. For more information on these two vulnerabilities, please check out this [blog](https://jumpcrypto.com/writing/bypassing-ethermint-ante-handlers/).
- The version of Zetachain was using a vulnerable version of the Ethermint antehandler described above. The auditors used this to bypass the gas verification to breaking infinite loops to halt the blockchain.

#### Zellic 3.12: Unbonded validators prevent the TSS vote from passing
- Voting for a new TSS address is done via the ``MsgCreateTSSVoter`` call. When verifying *who* can vote, it checks to ensure that only *bonded* validators can vote. 
- When checking for the number of validators for the vote to pass, it checks the *total* amount of validators and not just *bonded* validators. This results in it counting unbonded and unbonding validators. 
- Since the amount of validators cannot be reached, the voting will never pass, since it requires a full consensus. 


#### Halborn: Zeta Supply does not track assets correctly (critical) 
- In the [whitepaper](https://www.zetachain.com/whitepaper.pdf), specific mention is made to keeping the *supply* of Zeta at a consistent amount. This is because the only native token on Zetachain is the ZETA token. If this could be inflated on one blockchain then used on another, then the consequences would be significant. 
- The system uses a *mint and burn* model for keeping track of Zeta between chains. Keeping these perfectly in check is important. 
- Possible to inflate amount of total Zeta via simple calls. By transfering funds from one EVM to another, one transfering chain does not *burn* the tokens. Having too many tokens in circulation would break the Uniswap pools used for trading and other security assumptions. 

#### Halborn: Lack of mechanism to limit the supply of zeta (high) 
- In the [whitepaper](https://www.zetachain.com/whitepaper.pdf), specific mention is made to keeping the *supply* of Zeta at a consistent amount. This is because the only native token on Zetachain is the ZETA token. If this could be inflated on one blockchain then used on another, then the consequences would be significant. 
- If an implementation flaw is found that causes this issue, then there is no way for the other blockchains to know. According to the whitepaper, a chainlink keeper should post the total amount on every chain to ensure that the *supply* stays valid at all times. 
- The chainlink keeper was not (and has not still) been implemented. So vulnerabilities could effect the supply of Zeta to wreck havoc on the ecosystem. 

#### Halborn: Integers Overflows Cause Havoc (high)
- Go is suspectible to number related vulnerabilities like integer overflows, underflows, sign changes and truncation. Multiple occurrences of overflows cause issues in the ecosystem. 
- A large parameter (TODO) within the gas cost estimation process that is voted on leads to an overflow. Because of a comparison always failing from this, the gas cost goes up by 20% over and over again until it is unpayable. 
- Bitcoin transaction nonces can overflow. This leads to the transactions going unprocessed. 
- With very large block heights, a crash will occur within the querying (GRPC) of blockchain state. 

#### Halborn: Sybil attack risk due to use of median gas votes for setting gas price (medium)
- The gas price of networks is determined by the validators. In particular, they check various locations to vote on the gas price. 
- The voting process takes the *median* gas price. The *median* is the center of the list and NOT the average. 
- This results in massive changes in gas price. For instance, if the sent in prices are 1,2,3,200,300, the price would be 3. However, if a new vote came in, the price could rise to 200. 
- Since the average is not being used and validator power is not considered, this is vulnerable to sybil attacks as well. An attacker with control over multiple low power validators could deeper influence the vote by adding in large gas prices. 

#### Halborn: Iteration over maps - non-determinims (medium) 
- Consensus is the agreement of a state in a blockchain. It is important for the good being ran within a blockchain to be *deterministic* so that the same point can always be reached. 
- In Go, iterating over maps is known to be different on different versions of Go. Additionally, in newer versions, this is [intentionally randomized](https://stackoverflow.com/questions/9619479/go-what-determines-the-iteration-order-for-map-keys). 
- If the ordering of iterating over a map will change the state of a blockchain, then it's a source of *non-determinism*. This would result in a chain halt as the validators could not come to a conclusion on the state of the blockchain.

#### Halborn: Error condition for key signing is unchecked
- The function ``TestKeysign()`` was used for signature verification is some places. 
- The return value of this was not always checked. 
- As a result, an invalid signature would get flagged as invalid but execution would continue anyway. 


- Resources for this: 
    - Zellic: https://drive.google.com/file/d/1TjLkNn9MobjGTupukJBxnpxr0DKvj_6V/view
    - Halborn: https://drive.google.com/file/d/1F7RHWukeEcjUrA5P2BS3AYsttjYvQaw8/view?usp=sharing&utm_source=immunefi
