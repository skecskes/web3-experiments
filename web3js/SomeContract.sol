//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract SomeContract {
    uint public myUint = 10;
    function setUint(uint _myUint) public {
        myUint = _myUint;
    }
}