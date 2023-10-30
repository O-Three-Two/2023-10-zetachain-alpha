# ZetaChain Security Model

ZetaChain is a Proof of Stake (PoS) blockchain, which can connect to any external blockchain or layer in a decentralized, trustless, permissionless way - without a single point of failure.

The ZetaChain architecture consists of validators, observers, and signers.

**Validators**

- Utilizes the Tendermint consensus protocol, a Byzantine Fault Tolerant algorithm.
- Votes on block proposals with voting power proportional to their staked ZETA coins.
- Must remain online continuously for block production.
- Identified by their unique consensus public key.
- Rewarded with block rewards and transaction fees for their service.

**Observers**

- Essential for ZetaChain consensus.
- Monitor external chains for relevant transactions/events/states.
- Comprised of sequencers and verifiers.
- Sequencers: Detect relevant external transactions/events/states and relay this information to verifiers.
- Verifiers: Verify the data and vote on ZetaChain for consensus.
- At least one honest sequencer is required for network liveness.

**Decentralized Transaction Signing: In a distributed fashion, mutating states on external blockchains is authenticated & secured by leaderless Threshold Signature Scheme (TSS)**
- Zetachain's TSS is forked from [Binance](https://github.com/bnb-chain/tss-lib)
- Hold standard ECDSA/EdDSA keys for interacting with external chains.
- Keys are distributed in a way that a supermajority is needed to sign on behalf of ZetaChain.
- Ensure that no single entity can sign messages on behalf of ZetaChain to external chains.
- Bonded stakes, coupled with positive/negative incentives, ensure economic safety.
- The decentralized transaction signing process initiates smart contract actions in a way that does not reveal any secrets to participating nodes. This is what makes non-smart chain connectivity possible.
