## Zetachain Development 101

### What is unique about Zetachain

Zetachain stands out from other L1's due to the fact that its specifically designed from scratch to effectively support on-chain contracts, facilitating ease of use in a multi-chain environment. Their approach method is heavily centered around decentralization and trustlessness, enabling operation across numerous chains without the reliance on centralized trust.

While the concept of an omni-chain or multi-chain approach isn't new, and others have attempted it through methods like message passing, these solutions often depend on trusted verifiers or other centralized entities. 

In contrast, Zetachain is being built to be as decentralized as possible. A notable difference with conventional layer one blockchains is their tendency to retain users and developers within their own limited ecosystems, usually discouraging external integration.

Contrarily, Zetachain's model is intended to break these boundaries; they not only permit but actively encourage developers to use their platform as a springboard to reach and connect with other chains. 

Zetachain's goal is to provide a omni chain experience for both developers and users who navigate the multi-chain landscape, enabling more seamless connectivity and interactions across different blockchain networks.

#### H-h-hold on, whats an Omni-chain? How is that different than bridge/multi chain?

You can think of it like a bridge is an example of a multi chain application? It works **between two** different chains.

On the other hand, Omnichain, means applications and dApps that work across multiple chains **simultaneously**. 

Typically, with multi chain apps, the developer might be deploying the same application to multiple chains or similar application, it's almost like they're copy pasting from one place to the next. It's just a series of connected applications. 

Whereas an omni chain application is designed from the ground up to work across multiple chains. So what happens is you deploy your application logic in one place, and interact with assets across multiple chains. 

This magic happens with **Omnichain Smart Contracts**. They are used to orchestrate assets/data on all chains, including non-smart contract solutions like Bitcoin and Dogecoin, on top of its messaging capabilities.

That's what makes it not only different, but unique compared to pure messaging solutions like LayerZero and Axelar.


#### The Omni-chain approach.

The biggest (and obvious) benefit here is that it eliminates the need for things like wrapped assets, bridges, streamlining cross chain assets and data transfers. But how?

Zetachain has abstracted most of the complication of this in a way to make it easier for users and easier for developers who don't have to worry about wrapping assets and bridging and that kind of work.

All of that happens thanks to the ZRC20 token, which is an abstraction of a token or a native asset on an external chain.

#### ZRC20

The omnichain smart contract platform from ZetaChain includes the [ZRC-20](https://www.zetachain.com/docs/developers/omnichain/zrc-20/) token standard is based on ERC-20.

You can think of it like an abstraction of a token or native asset on an external chain.

In a broad sense, ZRC-20 tokens are an expansion of the common ERC-20 tokens present in the Ethereum ecosystem. 

However, the ZRC-20 tokens have the additional capability of managing assets on all chains connected to ZetaChain. 

**Any** **fungible** token may be represented on ZetaChain as a ZRC-20 and managed as if it were any other fungible token, including Bitcoin, Dogecoin, ERC-20 counterparts on other chains, gas assets on other chains, and so on (like an ERC-20)


### How do you build on Zetachain?

#### Cross chain messaging (for existing applications)

This would happen with cross chain messaging. 

You have a contract that uses Zetacain API and you use it to deploy contract(contracts) on to two or more connected chains. 

What you get out of this is you can trigger a cross chain message, send from one chain to another, that allows you to transfer any kind of arbitrary data. 

You can also transfer value, NFT's and whatever you want. So it's a very general but incredibly useful tool to connects already existing applications or existing daps. So you can augment your single chain dApp to become multi chain.

You can find some examples [here](https://www.zetachain.com/docs/developers/cross-chain-messaging/overview/)

#### Omni chain contracts (for new applications)

This would happen with omnichain contract. But what's a Omnichain contract?

It's a contract that you deploy onto Zetachain, instead of deploying it to different chains, you deploy it once.  

It could be any contract that is currently deployed on Ethereum, but with very minimal changes. 

It essentially has the superpowers to manage assets on different chains. When a user sends tokens on Ethereum to specific address, they also provide some data about which contract to call on Zetachain. Then these tokens get essentially transferred to this contract and it can process these tokens. 

So tokens are transferred on Ethereum, but the ZRC20 representation of these tokens is passed on to the contract on Zetachain. And as mentioned earlier, the ZRC20 standard is an extension of the ERC 20 which extends it in a way that allows contracts to withdraw tokens.

So when you're sending ETH on Ethereum, to this address, a contract can swap these tokens on Zetachain to Matic and these meta tokens can be withdrawn on polygon to any address.

Omni chain smart contracts allow for manipulation of native foreign assets, such as Bitcoin, through a single chain Ethereum compatible platform.

Omni chain smart contracts allow for native assets to be orchestrated as if they were on one chain from many chains, including Bitcoin.

You can find some examples [here](https://github.com/zeta-chain/example-contracts)


#### Why would you use omni chain contracts?

Any evm smart contract, you were thinking about making multi chain could be omni chain contract? 

By deploying and interacting with the the main logic in one location, it makes the operations much easier. 

You're managing one application instead of managing five applications, right? 

Also allows you to kind of streamline the user experience a little bit, the user may not need to jump between four or five different chains in order to do something.

#### Summary

So, in a summary omni chain smart contracts are different from cross chain messaging in that they allow for transferring arbitrary data and value between multiple connected chains, while cross chain messaging is limited to transferring data and value within a single chain.

#### Use cases

##### Cross-chain swaps

TBD

##### Cross-chain accounts

TBD


