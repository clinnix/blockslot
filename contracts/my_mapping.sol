// SPDX-License-Identifier: MIT
pragma solidity =0.8.26;

contract MyMapping {
    mapping(address => uint256) private balance; // storage slot 0

    function setValues() public {
        balance[address(0x01)] = 9;
        balance[address(0x03)] = 10;
    }

    function getStorageSlot(address _key) public pure returns (bytes32 slot) {
        uint256 balanceMappingSlot;

        assembly {
            // `.slot` returns the state variable (balance) location within the storage slots.
            // In our case, 0
            balanceMappingSlot := balance.slot
        }

        slot = keccak256(abi.encode(_key, balanceMappingSlot));
    }

    function getValue(address _key) public view returns (uint256 value) {
        // Call helper function to get 
        bytes32 slot = getStorageSlot(_key);

        assembly {
            // Loads the value stored in the slot
            value := sload(slot)
        }
    }
}

