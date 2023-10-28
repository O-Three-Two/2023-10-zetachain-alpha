
### How is Zetachain different?

Zetachain stands out from other L1's due to the fact that its specifically designed from scratch to effectively support on-chain contracts, facilitating ease of use in a multi-chain environment. Their approach method is heavily centered around decentralization and trustlessness, enabling operation across numerous chains without the reliance on centralized trust.

While the concept of an omni-chain or multi-chain approach isn't new, and others have attempted it through methods like message passing, these solutions often depend on trusted verifiers or other centralized entities. In contrast, Zetachain is being built to be as decentralized as possible. A notable difference with conventional layer one blockchains is their tendency to retain users and developers within their own limited ecosystems, usually discouraging external integration.

Contrarily, Zetachain's model is intended to break these boundaries; they not only permit but actively encourage developers to use their platform as a springboard to reach and connect with other chains. Zetachain's goal is to provide a superior experience for both developers and users who navigate the multi-chain landscape, enabling more seamless connectivity and interactions across different blockchain networks.

### What's the concept of Omni chain and how does it actually differentiate from a bridge/multi chain?

I think a like a bridge is an example of like a multi chain application, right? It works between two different chains. 

Omnichain, kind of means applications and daps that work across multiple chains simultaneously. Typically, with multi chain apps, the developer might be deploying the same application to multiple chains or similar application, it's almost like they're copy pasting from one place to the next. It's just a series of connected applications. 

Whereas an omni chain application is designed from the ground up to work across multiple chains. So you can kind of deploy your application logic in one place, and interact with assets across multiple chains. That's kind of at a very high level, the idea for Omni chain daps.


### How does the Omni chain approach eliminate the need for things like wrapped assets, bridges, you know, streamlining cross chain assets, data transfers?

Zetachain has abstracted most of the complication of this in a way to make it easier for users and easier for developers who don't have to worry about wrapping assets and bridging and that kind of work

The really the novel thing Zetachain does is the ZRC20 token which is kind of an abstraction of a token or native asset on an external chain. 

It allows the developer to interact with that like it would be any ERC20 token.  So if you imagine building a let's say a simple swap application that swapping let's say wrapped Bitcoin for ETH. 

You could build that on ETH right on one EVM blockchain with Zetachain, you would interact with native ETH and native BTC and you would do that just like they were ERC 20 tokens.

But Zetachain is actually handling that native asset externally for you. 

So it makes it a lot simpler for developers to build these things. Meaning there are still cross chain assets and movement involved, but Zetachain manages a lot of that in a more secure, simplified manner.

@dev-101 @vladbochok Imo a huge benefit is that devs don't really have to think about the one way peg or think about converting these things over. Because using this ERC 20 abstraction, they can manage those assets natively without having to worry about that conversion process. It's practically one way peg.

#### ZRC20 example

bytes032: imo this approach strives to solve the issue with fragmented liquidity on different pools on different chains

Imagine you have USDC pool on ETH, USDC pool on BSC, with ZRC20 instead of having to balance individual pools you can just take native USDC on ETH, native USDC on BSC and bounce those two against each other, where any, really any balancing is done by kind of balancing them across chains, instead of doing it multiple times on each individual chain.


### How to implement the Omni chain functionality into existing smart contracts?


bytes032: If you have an application, it's running, why would you bother coming in and looking at making it omnichain?


I think any, any application, you were thinking about making multi chain could be omnichain? And by deploying and interacting with the the main logic in one location, it makes the operations much easier. You're managing one application instead of managing five applications, right? 

And it also allows you to kind of streamline the user experience a little bit, the user may not need to jump between four or five different chains in order to do something. So that's really why they move to omni chain approach


TODO: They support message passing. What is message passing?