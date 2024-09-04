// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Address {
    address public myAddress;

    function getAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    function getAddressBalance() public view returns(uint256){
        return myAddress.balance;
    }
}


contract MsgSender {
    address public someAddress;

    function getMsgSender() public {
        someAddress = msg.sender;
    }
}


contract ViewPureFunc {
    uint256 public num = 10;

    constructor(uint256 _num){
        num = _num;
    }

    function getViewFunc() public view  returns(uint256){
        return num;
    }

    function getPureFunc(uint256 a, uint256 b) public pure returns(uint256){
        return a+b;
    }

    function getNUm(uint256 _num) public returns(uint256){
        num = _num;
        return num;
    }
}