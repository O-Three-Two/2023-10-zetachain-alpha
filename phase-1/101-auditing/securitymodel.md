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
