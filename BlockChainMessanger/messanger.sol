// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// IN THIS PROJECT WE ARE WRITING SIMPLE SMART CONTRACT THAT STORE OUR MESSAGE AND COUNT THE NUMBER OF TIME WE CHANGE THE MESSAGE.

contract BlockChainMessanger {
    string private message;
    uint256 public cnt;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function getMessage(string memory _message) public {
        if (msg.sender == owner) {
            message = _message;
            cnt++;
        }
    }

    function displayMessage() public view returns (string memory) {
        return message;
    }
}