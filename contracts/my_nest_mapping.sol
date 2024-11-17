// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MyNestedMapping{

    mapping(address => mapping(uint256 => uint256)) public balance;

    constructor(){
        balance[address(0xb0b)][1111] = 5;
    }

    function getStorageSlot(address _key1, uint256 _key2) public pure returns (bytes32 slot){
        uint256 balanceMappingSlot;
        assembly {
            balanceMappingSlot := balance.slot
        }
        bytes32 initialHash = keccak256(abi.encode(_key1, balanceMappingSlot));
        slot = keccak256(abi.encode(_key2, initialHash));
    }

    function getValue(bytes32 _slot) public view returns (uint256 value){
        assembly {
            value := sload(_slot)
        }
    }
}
