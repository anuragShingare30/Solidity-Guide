// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Calculator {

    uint256 result;

    function addition(uint256 a, uint256 b) public returns (uint256){
        return result=a+b;
    }

    function subtraction(uint256 a, uint256 b) public returns (uint256){
        return result=a-b;
    }

    function multiplication(uint256 a, uint256 b) public returns (uint256){
        return result=a+b;
    }

    function get() public view returns (uint256){
        return result;
    }
}