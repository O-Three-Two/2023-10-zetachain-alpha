__Steal Funds__
- Double voucher submission
- Time Out 
  - Submit after timeout window
  - Force drop tx
- Spoofing 
  - sender
  - chain id  
  - funds 
  - receiver 
- Block reorganizations
  - [x] Waiting for confirmations
- Bad cryptography 
  - [ ] Voting used on many things
  - markle tree verification problems
  - cryptographic signatures
  - nonce issues
  - Hash collisions 
  - Relay attacks
- Chain ID confusion 
  - [x] chains can only be added by admins
- Transaction ordering
  - [x] Cosmos is a FIFO queue
- Event/log truncation
- Event status mishandling 
  - Illegal state transitions (i.e. inbound to reverted_failure)
- Denomation issues 
  - [ ] only settable by admin 
  - Cross-chain mishandling still possible
- Asset inflation
  - Increasing amount of tokens being sent
- Precision issues
- Bad book keeping
  - Double counting 
  - Missing state updates
- Price manipulation on assets
- Coin type confusion on relayers
  - Zeta to gas
  - ERC20 to Zeta
  - Illegal use of 'cmd' coin
- Supply issues
  - Mint too many
  - Burn too much 
