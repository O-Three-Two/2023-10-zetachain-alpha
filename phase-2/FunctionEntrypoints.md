## Entrypoints 
- The flow is not completely linear. There are portions of this within smart contract code, observer code, zEVM code and zetachain modules themselves. 
- This is a list of important entrypoints for functionality within the codebase. 

### Ethereum Compatiable 
- Connector ``onReceive`` function:
    - Handler for TSS signer on crosschain call to complete the CCM.
    - https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/evm/ZetaConnector.eth.sol#L52
- Connector ``onRevert`` function: 
    - Handler for TSS signer on crosschain to revert state on original chain who sent the CCM.
    - https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/evm/ZetaConnector.eth.sol#L77C17-L77C17
- ``send`` function:
    - Function to call for CCM from application smart contract.
    - https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/evm/ZetaConnector.eth.sol#L31
- ERC20 sending between chains: 
    - There's a smart contract that holds ERC20 assets on behalf of zetachain. Then, sends them to other chains on behalf of the user.
    - withdraw: https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/evm/ERC20Custody.sol#L193
    - deposit: https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/evm/ERC20Custody.sol#L165

### zEVM
- SystemContract ``depositAndCall``: 
    - Performs ZRC20 deposit functionality. 
    - Calls ``onCrossChainCall`` within the application smart contract.
    - https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/zevm/SystemContract.sol#L67C9-L67C9
- ZRC20 ``deposit``:
    - The *minting* of assets for the user. The other assets are stored cross chain. 
    - https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/zevm/ZRC20.sol#L225
- ZRC20 ``withdraw``:
    - The *burning* of assets for the user. This triggers an event to send the funds to the other chain.
    - https://github.com/zeta-chain/protocol-contracts/blob/accb3cba156943beedc8a09a5a5c36e4bbcfffff/contracts/zevm/ZRC20.sol#L256

### Observer 
- Gas Token (Bitcoin, dogecoin, etc.) inbound transaction listener:
    - Listening for incoming transactions from the blockchain
    - Votes on the event that occurred to Zetachain.
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/bitcoin_client.go#L286
- EVM listener for inbound transactions: 
    - ``zetasent`` events: 
        - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/evm_client.go#L764
    - ERC20 sent events to ``ERC20Custody`` contract:
        - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/evm_client.go#L806
    - Direct sends to TSS address: 
        - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/evm_client.go#L848C10-L848C10
    - https://github.com/zeta-chain/node/blob/
    e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/evm_client.go#L714
- Outbound Zetachain transaction listener: 
    - Same for all chain types. 
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/zetacore_observer.go#L106
- Gas Token (Bitcoin, dogecoin, etc.) outbound transaction completion: 
    - Looks for completed transaction from the TSS address. 
    - Votes on occurance to Zetachain.
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/bitcoin_client.go#L934
- Ethereum outbound transaction completion: 
    - Looks for completed transaction from the TSS address. 
    - Votes on occurance to Zetachain.
    - Handles reverts voting as well.
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/zetaclient/evm_client.go#L539


### Zetachain 
- Inbound transaction voting: 
    - Observers vote on incoming events. 
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/x/crosschain/keeper/keeper_cross_chain_tx_vote_inbound_tx.go#L58
- Outbound transaction voting: 
    - Observers vote on whether an event to the outbound chain occurred or not. 
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/x/crosschain/keeper/keeper_cross_chain_tx_vote_outbound_tx.go#L61
- Gas price voting: 
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/x/crosschain/keeper/keeper_gas_price.go#L125
- Other events: 
    - Within a given cosmos module SDK path (``x/<HERE>/keeper``) look for functions with the ``msg *types.********`` in them.
    - Most of the time (although inconsistent) these are named as ``keeper_XXXXXX.go`` or ``msg_server_XXXXX``. 
    - Other functionality includes ZRC20 deployment, observer information and more between the four modules. 
    - These are all listed in the Zetachain [docs](https://www.zetachain.com/docs/architecture/overview/) under ``/architecture/modules/``. 
- Deploy zEVM ZRC20 token: 
    - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/x/fungible/keeper/msg_server_deploy_fungible_coin_zrc20.go#L34
- EVM hooks: 
    - Upon finishing execution, there is code that is executed by the EVM module. 
    - Checking for paused ZRC20 module: 
        - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/x/fungible/keeper/evm_hooks.go#L30
    - Event processing: 
        - https://github.com/zeta-chain/node/blob/e8161c57d512c5fa5cef3ba952631f0e92a7cce1/x/crosschain/keeper/evm_hooks.go#L47
