// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// THIS IS AN SIMPLE WALLET TO DEPOSIT, WITHDRAW AND TO SEND ETHER TO DIIFERENT ADDRESS.

contract SmartWallet {
    uint public balance;


    function deposit() public payable {
        balance += msg.value;
    }

    function totalBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withDrawALL() public payable {
        address payable toAddress = payable(msg.sender);
        toAddress.transfer(totalBalance());
        // balance -= totalBalance();
    }

    function withDrawToAddress(address payable other,uint amount) public payable {

        other.transfer(amount);
        // if(msg.value >= amount){
        //     other.transfer(amount);
        // }
    }
}