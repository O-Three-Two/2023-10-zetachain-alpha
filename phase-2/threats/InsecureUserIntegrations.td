__Insecure User Integrations__
- Cross Chain Messaging
    - Missing System contract check 
        - [x] Pre-built modifiers
    - Missing Connector contract check
        - [x] Pre-built modifiers
    - No revert function 
    - Reverting onRevert function
    - Chain difference issues 
    - Using wrong caller
- Omnichain
    - Missing System contract check 
        - [x] Pre-built modifiers
    - Invalid bytecode on zEVM 
    - ZRC20 handling confusion
        - [x] Only changable/settable by admin
    - Missing native coin integration
    - Changing TSS address
        - [ ] Not a common occurence
    - Reverting handler
    - Arbitrary action controller 
    - Missing input validation
    - Token decimal issues 
    - Silent failures on the system
- Hardcoded Values
    - TSS address
    - ZRC20 Addresses
- Chain ID validation
- Manipulated Zeta prices on gas
