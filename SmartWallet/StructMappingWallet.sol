// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StructMappingWallet {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint totalDeposit;
        mapping (uint => Transaction) deposit;
        uint totalWithDrawl;
        mapping (uint => Transaction) withdrawl;
    }

    mapping (address => Balance) public balanceReceived;


    function checkBalance(address _address) public view returns(uint){
        return balanceReceived[_address].totalBalance;
    }



    function depositMoney() public payable {
        balanceReceived[msg.sender].totalBalance += msg.value;
        
        balanceReceived[msg.sender].deposit[balanceReceived[msg.sender].totalDeposit].amount = msg.value;
        balanceReceived[msg.sender].deposit[balanceReceived[msg.sender].totalDeposit].timestamp = block.timestamp;
        balanceReceived[msg.sender].totalDeposit++;
    }

    function withdrawMoney(address payable  _to, uint amountToSend) public payable{
        balanceReceived[msg.sender].totalBalance -= amountToSend;

        balanceReceived[msg.sender].withdrawl[balanceReceived[msg.sender].totalWithDrawl].amount = msg.value;
        balanceReceived[msg.sender].withdrawl[balanceReceived[msg.sender].totalWithDrawl].timestamp = block.timestamp;
        balanceReceived[msg.sender].totalWithDrawl++;

        _to.transfer(amountToSend);
    }

}