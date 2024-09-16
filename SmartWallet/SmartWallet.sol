// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Consumer {

    function checkBalance() public view returns (uint){
        return address(this).balance;
    }

    function deposit() public {}
}

contract SmartWallet {

    address payable owner;
    // THIS WILL DECIDE HOW MUCH AN ACCOUNT CAN SEND FUNDS
    mapping (address => uint) public Balance;
    // THIS DECIDE AN ACCOUNTS IS ALLOWED TO SEND FUNDS OR NOT.
    mapping (address => bool) public isAllowed;

    mapping(address => bool) public guardiens;
    address payable  nextOwner;
    uint public guardienscount;
    uint public constant setGuardiensCount = 3;

    function checkBalance() public payable returns (uint){
        return address(this).balance;
    }

    // HERE GUARDIENS WILL SET THE NEW OWNER AS OUR OWNER IS NOT PRESENT
    function setNewOwners(address payable newOwner) public {
        require(guardiens[msg.sender], "You are not the guardiens!!!");
        if(nextOwner != newOwner){
            nextOwner = newOwner;
            guardienscount = 0;
        }

        guardienscount++;

        if(guardienscount >= setGuardiensCount){
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }
    
    function setGuardiens(address payable _guardien, bool _isGuardien) public payable{
        require(msg.sender == owner, "You are not an guardien!!!"); 
        guardiens[_guardien] = _isGuardien;
    }

    // GIVE ALLOWANCE TO OTHER PEOPLE.
    function setAllownace(address _for, uint _amount) public {
        require(msg.sender == owner, "You are not allowed to send funds for this smart contract!!!");
        Balance[_for] = _amount;
        
        if(_amount > 0){
            isAllowed[_for] = true;
        }
        else{
            isAllowed[_for] = false;
        }
    }
    function denySending(address _from) public {
        require(msg.sender == owner, "You are not allowed to send funds for this smart contract!!!");
        isAllowed[_from] = false;
    }
    

    // TRANSFER  MONEY ON EOA WITH PRIVATE KEY AND CONTRACT BASED ACCOUNT.
    function transfer(address payable _to, uint _amount, bytes memory _payload) public returns (bytes memory){

        require(_amount <= checkBalance(), "you dont have enough money to send funds.");
        if(msg.sender != owner){
            require(_amount >= Balance[msg.sender], "You are not allowed to send this much funds!!!");
            require(isAllowed[msg.sender] == false, "You are not allowed to send funds through this smart contracts!!!");
            Balance[msg.sender] -= _amount;
        }

        (bool isSend, bytes memory returnData) = _to.call{value:_amount}(_payload);
        require(isSend, "Failed to transfer funds!!!");
        return returnData;
        
    }

    // RECEIVE MONEY FROM FALLBACK FUNCTION.
    receive() external payable { }
}



