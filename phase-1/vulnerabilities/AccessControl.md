### Access Control 
- Operations have a specific user who should be able to perform them. This could be an administrator. Or, it could be that the user should only be able to perform an action on themselves and no one else. 
- These issues exist in all applications: web2 and web3. Confirming that the proper entity is performing the state changing action is important.
- Zetachain example: 
    - The ``SetNodeKeys`` function can control the address of the TSS public key. Setting this could result in a complete DoS or a user controlled key. 
    - This should be restricted by voting or administrative access. 
- In Astroport, there was a message for sensitive configuration parameters for an AMM. This was not backed by access control, allowing anybody to change the settings: 
    - https://github.com/astroport-fi/astroport-audits/blob/main/halborn/Astroport_fi_AMM_Protocol_CosmWasm_Smart_Contract_Security_Audit.pdf
- Other examples: 
    - User can reset circuit breaker on unintended modules: https://hackerone.com/reports/2120609
    - Enzyme Finance Missing Privilege Check Bugfix Review: https://medium.com/immunefi/enzyme-finance-missing-privilege-check-bugfix-review-ddb5e87b8058
