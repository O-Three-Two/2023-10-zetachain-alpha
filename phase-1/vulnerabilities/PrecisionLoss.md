## Rounding 
- Similar to Solidity, rounding on token amounts and other important values needs to be taken seriously.
- ``sdk.Dec`` has problems with math operations and is commonly used throughout the Cosmos SDK.
- Performing multiplication before division is essential to keeping values proper and not losing precision.
- Ensure that the rounding (either bankers rounding up or down) benefits the module at all times.
- https://github.com/umee-network/umee/issues/545
