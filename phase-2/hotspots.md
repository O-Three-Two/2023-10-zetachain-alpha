 - Event Handling: 
    - There are many times where events need to be observed. 
    - Inbound, outbound signing, outbound receipt, revert on outbound signing and revert observed
    - All of these are immensely important to handling correctly *all* the time and in every case. 
    - If any of these can have the event spoofed (like Zellic 3.1 finding), have unintended values controlled, then major loss of funds will occur. 
    - Improper observance of event could lead to old or improper events being submitted (Zellic 3.5)
    - Additionally, breaking the event handler on the  is just as good as stopping the blockchain. The relayer is a critical user in this eco-system.
    - Since so much of the security relies on events being observed correctly, this felt like a fruitful avenue of attack.
- Coin/currency logic on Zetaclient and Zetachain: 
    - There are many types of assets floating around:
        - Zeta
        - Bitcoin/dogecoin
        - zERC20/ERC20 tokens
        - Cmd coins (admin commands) 
    - Proper validation of the coin types is required. Otherwise, the cheaper asset of Zeta could be used for Bitcoin (Zellic 3.3).
    - Since there are four different coin types with differrent clients, this feels fruitful to us.
    - Gas handling. The *relayers* should never loss money from sending the transactions. Ensuring this logic is valid is important for the protocol.
- TSS and Voting: 
    - The *occurence* of an event comes down to *voting* on whether this occurred or not. 
    - If it's possible to break the voting process then arbitrary events could be smuggled in. Sybil attacks, poor weighting logic and others are major threats. 
    - The ability to make transactions to other blockchains, such as Ethereum and Bitcoin, is done via a *TSS* signer. This means that a single key owns all of the assets. However, this is *distributed* among the various observers.
    - If the key is compromised or the group signing process is flawed, the creation of transactions that never were voted on could occur. 
- Race conditions: 
    - The *observing* and *processing* of events happens between many different threads. 
    - This code has *some* mutex's (mutal exclusion locks between threads), but is inheritly racey. 
    - Tracking whether an observed transaction has been signed is different than the thread that actually does the signing. As pointed out in ``Zellic 3.4``, this is a real threat that could lead to double spends. 
    - Finding situations where double signing, double voting and other things occur via race conditions feels fruitful.
