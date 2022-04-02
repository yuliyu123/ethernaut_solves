// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// 你能够低于所需price的值获取商店里商品吗？
// 可能会有帮助：
// 1. Shop可能会被Buyer使用；
// 2. 明白view函数的限制。

// finish:
// 1. 合约可以被任意其他合约操纵可见数据
// 2. 基于外部的和不受信任的合约逻辑去改变状态不是安全的做法

interface Buyer {
  function price() external view returns (uint);
}

contract Shop {
  uint public price = 100;
  bool public isSold;

  function buy() public {
    Buyer _buyer = Buyer(msg.sender);

    if (_buyer.price() >= price && !isSold) {
      isSold = true;
      price = _buyer.price();
    }
  }
}
