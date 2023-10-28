### Bridge Integration 
- Cosmos SDK is a world of application blockchains. To go between these, a protocol called Inter-blockchain communication (IBC) is used. This is not used by Zetachain though, since we're going between native tokens and EVM chains. 
- Most bridges function in a specific way: 
    - On chain A, *store* the native asset trying to be transferred. On chain B, *mint* a representation of the asset from chain A. 
    - On chain B, *burn* the wrapped asset trying to be transferred. On chain A, *send* the native asset back to the user. 
- There are many edge cases to handle here that make it complicated. 

#### Timeouts 
- What happens if a call *fails*? Most bridges have functionality to *refund* the user in the case of this happening. 
- When the *error* detection is bad, then it can lead to double spend vulnerabilities. 
- If a timeout occurs on a transaction, can the *original* transaction allowed to be sent again after the timeout? 
- Is it possible to make a transaction look like it failed when it really didn't? 
- https://jumpcrypto.com/writing/huckleberry-ibc-event-hallucinations/
- https://github.com/Stride-Labs/stride/pull/818

#### Relayer
- The relayer is the user who sends events from one blockchain to another. In the context of Zetachain, the 'observer' plays this role but also has the capability to *sign* outgoing transactions and *vote* on incoming ones. 
- When the relayer has a vulnerability in it, then this can be just as bad as the real blockchain. We can trick the client into thinking something occurred when it really did not.
- If the relayer can be knocked offline by a crash, resource exhaustion or another issue, then the bridge will come to a complete halt. Error handling to prevent crashing is important here.
- Trick the relayer to *sign* transactions that it shouldn't. In Zetachain, a user sending ZETA to the bitcoin network assumed it was Bitcoin and sent the user Bitcoin instead. 
- Trick the relayer to include or drop events that occurred. 

#### Supply Growth 
- Using the lock+mint and burn+send method is great. However, it's important to keep the assets 1 to 1 between the blockchain. 
- *Inflation* of the wrapped token on the chain would result in too many funds being sent to the user. 
- *Deflation* would result in funds be impossible to withdraw. 

#### Input Validation 
- Coming up with an untamperable and source of truth between both blockchains is difficult. Rigoriously checking the inputs is cruicial. 
- If a user sends a token with the same name and same symbol as a token to a different chain, it should not be valid. It should be based upon the address. 
    - https://twitter.com/PlasmaPower0/status/1582176532985880576
- Every input being provided by the user should not verified to ensure there is no trickery occuring. 
- https://rekt.news/thorchain-rekt/
- https://medium.com/immunefi/aurora-improper-input-sanitization-bugfix-review-a9376dac046f
