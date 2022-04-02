await contract.contribute({from: player, value: web3.utils.toWei('0.0001', 'ether')})
await web3.eth.sendTransaction({from: player, to: contract.address, value: web3.utils.toWei('0.001', 'ether')})
await contract.owner()