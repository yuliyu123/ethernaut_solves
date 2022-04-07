openzeppelin proxy:
代理合约是逻辑合约的存储层。当使用代理合约进行合约升级的时候会将逻辑合约委托给代理合约，包括存储空间。
因此可通过修改逻辑合约的storage slots来修改proxy合约的storage，反过来也可以。


delegatecall:
https://medium.com/@appsbylamby/ethernaut-24-puzzle-wallet-walkthrough-mastering-the-proxy-pattern-cc830dc364ce
