let rlp = require('rlp')

let targetAddress = function(instanceAddress,nonce) {
    let bufferAddress = Buffer.from(instanceAddress.slice(2),'hex');
    let data = rlp.encode([bufferAddress,nonce])
    return '0x' + web3.utils.sha3(data).slice(26);
}

console.log("lost addr: ", targetAddress("0x7C974B5b1f7A9780dD350F3Feb8901bD216f39FC", 1));
