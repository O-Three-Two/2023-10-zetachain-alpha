*Provides interopability between EVM and non EVM*

@bytes032 note: Looks like if the market accepts this proposition its something that would look like TCP/IP?


### How to implement the Omni chain functionality into existing smart contracts?


bytes032: If you have an application, it's running, why would you bother coming in and looking at making it omnichain?


I think any, any application, you were thinking about making multi chain could be omnichain? And by deploying and interacting with the the main logic in one location, it makes the operations much easier. You're managing one application instead of managing five applications, right? 

And it also allows you to kind of streamline the user experience a little bit, the user may not need to jump between four or five different chains in order to do something. So that's really why they move to omni chain approach


TODO: They support message passing. What is message passing?


### Audit 101 @defsec

Imo the one way peg makes it much easier to monitor and lock down? They also have plenty of caps. 


#### Observer signer nodes

They have observer signer nodes that are out there, they're watching what's happening on all external chains. 

When a authorised action takes place, they see it, they reach consensus that, you know, Bob did, in fact, send you know, each of you that he wants to transfer across chain to, let's say, polygon. 

And then once they all reach consensus on that, they all sign an agreement using a TS TSS distributed key where essentially all of the observer signers are sharing a private key that has been broken up into multiple sections, no individual party can recreate that key. 

But it allows them to operate on external chain with external address? Just like they would if it was a single wallet, which gives a lot of flexibility and how they interact. 

But that relying on that TSS model is where a lot of that security comes from, as well as having the multiple groups who are observing these events and reaching consensus versus having one trusted party or one trusted verifier.


#### Conclusion

Existing apps - messaging
New apps - omnichain contracts



### "Unique"? features related to Zetachain

- Contracts can be called by ANY? chain, e.g. move bitcoin, ada, eth
- The zetacain function is a universal gas asset (you dont pay any other chain assets) - 1 wallet, 1 gas token, any dapp, any network
- Bridge native assets in a single pool, e.g. DAI from Ethereum or USDC from Arbitrum can exist in a single pool
- Single deployment?
- Algo stablecoin using Bitcoin as collateral, with potential for higher interest rates and larger market size. ? :DDD


### Common

- [Zetachain vs Axelar vs LayerZero](https://www.reddit.com/r/zetablockchain/comments/12tk65g/messaging_layerzero_axelar_a_key_difference/)