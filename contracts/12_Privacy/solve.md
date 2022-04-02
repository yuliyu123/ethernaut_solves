<!-- solve:
 Read contract storage. -->
 <!-- 所有的合约变量会存储在链上，都可读。 -->
 
const dataEntry = await web3.eth.getStorageAt(instance, 5);
//console.log("data entry " + dataEntry)
const key = '0x' + dataEntry.substring(2, 34);

// Unlock.
await contract.unlock(key);


gas优化：
1. memory变量不会存储在链上, 而是在内存中。
2. 合约内部变量存储在slot上，大于32字节每个变量存储一个slot; 小于的话会压缩空间。每个slot都会消耗gas, 因此尽量减少slot的使用.
3. SSTORE <> SLOAD are very gas intensive opcodes.
4. constant不会存储在链上
