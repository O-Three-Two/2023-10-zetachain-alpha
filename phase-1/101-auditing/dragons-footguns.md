## Dragons

- State Machine Concept: In Cosmos SDK, understanding how a blockchain's state machine operates is fundamental. However, this concept can be a bit perplexing for newcomers. Misunderstandings or misuse can lead to unexpected errors or vulnerabilities.
- IBC (Inter-Blockchain Communication) Protocol: IBC allows for communication between different blockchains. However, if not implemented correctly or misunderstood, it can lead to token loss or erroneous transactions.

## Foot guns

- Gas Fees and Gas Mechanics: In Cosmos SDK, it's crucial to properly set up transaction fees and gas calculations. If misconfigured, it can expose the network to abuse or result in users paying exorbitant transaction fees.
- Module Permissions: The modular nature of Cosmos SDK requires proper configuration of access permissions to specific modules. Misconfigurations here could allow malicious actors to exploit these permissions.
- Validator Configuration: Misconfigurations of validator nodes can jeopardize the security of the network. Specifically, not safeguarding validator keys poses a significant risk.

## Tips to improve secure coding in Golang

- Avoid using panics, especially in methods like BeginBlock and EndBlock or other consensus related functions
- Make extensive use of unit tests as well as fuzz tests for invariants in the system
- Be extra careful when converting between types like uint and int, especially for functions related to accounting
- Keep all software up to date (especially CosmosSDK)
- Use ValidateBasic to verify all fields for incoming Messages
- Design: make sure the right types are used for the concepts they represent. e.g. if you use a signed int to represent a Block Height, what happens if that value is negative?
- Code in a “checks-effects-interactions” pattern. (there are guides on this for solidity but it applies to Cosmos). Make sure that error conditions do not result in side-effects (e.g. transferring balances, minting new coins, etc.)
