## Zetachain Security 101

- [X] what is unique about this as an auditor;
- [X] what is the security model
- [X] where are the dragons and foot guns
- [X] where are devs likely to make assumptions
- [X] what tools can you use in order to help test or analyze, etc'

Auditing ZetaChain presents a unique set of challenges and opportunities that differentiate it from other blockchain platforms.

## Cosmos SDK & Tendermint Integration

ZetaChain's foundation on the Cosmos SDK and Tendermint PBFT consensus engine is notable. While many blockchains utilize these technologies, understanding the intricacies of their integration in ZetaChain's context is crucial. The instant finality feature, for instance, is a departure from blockchains that require multiple confirmations.

## Multi-Role Validators

ZetaChain employs a diversified validator system, comprising Basic Validators, Observers, and TSS signers. This layered approach to validation adds complexity, requiring a deeper understanding of each role's function and potential vulnerabilities.

## External Chain Interactions

The Observer role in ZetaChain, which monitors external chain events, is a unique feature. Evaluating the security implications of these interactions, especially when it comes to cross-chain communications, is essential.

## Distributed Key Mechanism

ZetaChain's approach to holding ECDSA/EdDSA keys across multiple signers, ensuring no single point can act on behalf of the entire chain, is a distinct security feature that requires careful assessment.

## Economic Safety Mechanisms

The platform's use of bonded stakes combined with positive/negative incentives to ensure the economic safety of transactions is a nuanced area that demands a thorough understanding of game theory and economic models.

## Decentralized Nature

While decentralization is a feature of many blockchains, ZetaChain's emphasis on eliminating single points of failure, especially in its TSS Signers, presents a unique challenge in ensuring that decentralization does not compromise security.


# ZetaChain Security Model

### Overview

ZetaChain is a high-performance blockchain platform based on the Cosmos SDK and Tendermint PBFT consensus engine. The architecture is anchored by a decentralized network of nodes known as validators. These validators, equipped with ZetaCore and ZetaClient components, are responsible for producing the blockchain, observing events on external chains, and signing outbound transactions.

**High-Level Architecture**

- **Validators**
  - Serve as the backbone of the ZetaChain network.
  - Three roles: Basic Validators, Observers, and TSS signers.
  - Earn fees and rewards for processing transactions and ensuring network security.

- **ZetaCore**
  - Manages blockchain production.
  - Maintains the replicated state machine.

- **ZetaClient**
  - Observes events on external chains.
  - Handles the signing of outbound transactions.
  

### Detailed Components


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

**TSS Signers**

- Hold standard ECDSA/EdDSA keys for interacting with external chains.
- Keys are distributed in a way that a supermajority is needed to sign on behalf of ZetaChain.
- Ensure that no single entity can sign messages on behalf of ZetaChain to external chains.
- Bonded stakes, coupled with positive/negative incentives, ensure economic safety.

### Security Implications

Given the decentralized nature of ZetaChain, it is vital to maintain a robust security model. Validators play a critical role in ensuring the integrity and security of the network. With varying roles and responsibilities, it's paramount that each validator type is equipped to handle potential threats. Observers, in particular, require a high degree of trustworthiness due to their interaction with external chains. The TSS Signers, with their distributed key mechanism, act as a safeguard against single points of failure and malicious activities.

## Dragons

- State Machine Concept: In Cosmos SDK, understanding how a blockchain's state machine operates is fundamental. However, this concept can be a bit perplexing for newcomers. Misunderstandings or misuse can lead to unexpected errors or vulnerabilities.
- IBC (Inter-Blockchain Communication) Protocol: IBC allows for communication between different blockchains. However, if not implemented correctly or misunderstood, it can lead to token loss or erroneous transactions.

## Foot guns

- Gas Fees and Gas Mechanics: In Cosmos SDK, it's crucial to properly set up transaction fees and gas calculations. If misconfigured, it can expose the network to abuse or result in users paying exorbitant transaction fees.
- Module Permissions: The modular nature of Cosmos SDK requires proper configuration of access permissions to specific modules. Misconfigurations here could allow malicious actors to exploit these permissions.
- Validator Configuration: Misconfigurations of validator nodes can jeopardize the security of the network. Specifically, not safeguarding validator keys poses a significant risk.

## Tips to improve secure coding in Golang

- Avoid using panics, especially in methods like BeginBlock and EndBlock or other consensus related functions.
- Make extensive use of unit tests as well as fuzz tests for invariants in the system.
- Be extra careful when converting between types like uint and int, especially for functions related to accounting.
- Keep all software up to date (especially CosmosSDK)
- Use ValidateBasic to verify all fields for incoming Messages.
- Design: make sure the right types are used for the concepts they represent. e.g. if you use a signed int to represent a Block Height, what happens if that value is negative?
- Code in a “checks-effects-interactions” pattern. (there are guides on this for solidity but it applies to Cosmos). Make sure that error conditions do not result in side-effects (e.g. transferring balances, minting new coins, etc.)

# Developer Assumption

## State Consistency

Developers might assume that the state will always be consistent. However, bugs, software crashes, or attacks could lead to state inconsistencies.

##  Transaction Finality

Cosmos, with its Tendermint consensus, provides immediate finality. Developers might assume that once a transaction is committed, it's final. However, network issues or forks can challenge this assumption.

##  Gas and Fees 

Developers might assume that gas costs and fees are consistent. However, these can change based on network congestion, validators' minimum accepted fee, and other factors.

##  Module Interactions

When using the Cosmos SDK's modular architecture, developers might assume that modules will always interact seamlessly. However, incorrect module configurations or updates can break these interactions.

##  IBC Protocol 

For chains connected via the Inter-Blockchain Communication (IBC) protocol, developers might assume that packets will always be relayed promptly. Delays can happen, especially during network congestion.

##  Delegations and Staking

Developers might assume that the delegation and staking mechanisms are foolproof. However, there are nuances like jailed validators, unbonding periods, and slashing conditions that can affect staking operations.

##  Permissioning 

Developers might assume that the built-in role-based access control (RBAC) or other permissioning systems are exhaustive. Yet, edge cases or misconfigurations can lead to permissioning issues.

##  Upgradeability

Developers might assume that software upgrades using the upgrade module will always go smoothly. However, incorrect migration scripts or data incompatibilities can lead to issues.

##  Governance Proposals

Developers might assume that governance proposals, once passed, will execute perfectly. In reality, the execution of a proposal might have unforeseen consequences on the chain's operation.

##  Cross-chain Interactions

With the growing popularity of cross-chain platforms, developers might assume that interactions between Cosmos and other chains (e.g., Ethereum, Polkadot) are seamless. However, bridges and peg zones can have their own complexities and vulnerabilities.

# Tools

## CodeQL

https://github.com/crypto-com/cosmos-sdk-codeql/tree/main

## Gosec

https://github.com/cosmos/gosec

## ErrCheck

https://github.com/kisielk/errcheck

## StaticCheck

https://staticcheck.dev/

## Semgrep

https://github.com/trailofbits/semgrep-rules

## Golangci-lint

https://github.com/golangci/golangci-lint

## Go Exploit

https://vulncheck.com/blog/go-exploit

