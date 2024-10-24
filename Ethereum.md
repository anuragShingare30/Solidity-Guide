# Solidity Programming Language Guide 😎


### SIMPLE STRUCTURE FOR SOLIDITY SMART CONTRACT.

- Here we will see the simple layout and structure to write the solidity smart contracts.

```js
pragma solidity ^0.8.0;

contract MyFirstContract {
    // functions
    ...
    // variables
    ...
    // arrays
}

```


### VARIABLES IN SOLIDITY.

- Variables in sol is similar to javascript. Except address.

```js
uint8 , uint16, uint128, uint256;

string public str = "Hello world";

bool public correct = true/false;
```


### STRINGS AND BYTES.

- Strings are actually arbitrary long bytes in UTF-8 representation. Strings do not have a length property.

- When we are using 'string' as a parameter in our function define **memory** to allocate the memory to our string.

```js
string public myString = "Hello world";

function getMyString(string memory _myString) public {
    myString = _myString;
}
```


- Bytes have the length property.

```js
bytes public myBytes = "Hello";

// myBytes = 0x72375375bc758734784c834874
```


### BASIC FUNCTIONS TO WRITE SIMPLE S.C .

1. Here we will discuss the basic functions to write simple smart contracts.

```js
uint256 result;

function addition(uint256 a, uint256 b) public returns(uint256){
    return result=a+b;  
}
```

2. When we are just returning an variable inside an function we will use 'view' keyword.

```js
function get() public view returns (uint256){
    return result;
}
```



### FUNCTION VISIBILITY.

1. **Public** : Can be used internally and externally.
- Our metamask wallet and other smart contracts can call this type of function.

```js
function addition() public {
    result+=10;
}
```

2. **Private** : Can be used within contract.

```js
uint256 result = 0;

function addition() private {
    result+=10;
}
```

3. **Internal** : Can be used within the contract and other inheriting contract.
- Our metamask cannot used the internal function.
- But, inheriting contracts can used this function.


```js

contract Children {

    uint256 public result = 0;
    function addition(uint256 num) internal {
        result+=num;
    }
}

contract Parent is Children {
    
    uint256 x;
    // Here we have use the function from child contract.
    // Inheriting.
    function checkSum(uint256 x) internal {
        add(x);
    }
}
```

4. **External** : Can only be accessed from external contracts or accounts.
- We cannot used this function internally inside an other function.
- Our metamask wallet can accessed this type of function.

```js
function add(uint256 num) external {
    result += num;
}
```

- The 'public' function uses more ethereum gas fees than 'external' function.



#### NOTE : The default behavior to error out if the maximum/minimum value is reached. But you can still enforce this behavior. With an 'unchecked' block. Let's see an example.

```js

uint256 num; // by default it is 0

// Error
function Test1() public {
    num--;
}

// 115758729374974893749972177129737
function Test2() public {
    unchecked{
        num--;
    }
}
```

### CONSTRUCTOR FUNCTION 

- It is a special function that is called only once during contract deployment.
- It is automatically called during Smart Contract deployment. And it can never be called again after that.

```js
constructor(uint256 _myaddress) {
    owner = _myaddress;
    
    owner = msg.sender;
}
```


### PAYABLE MODIFIER

- The payable modifier tells solidity that the function is expecting eth to receive.

```js

string public myMessage;
function getMessage(string memory _myMessage) public payable {
    myMessage = _myMessage;
}

```


### msg OBJECT

- The msg-object contains information about the current message with the smart contract. 
- It's a global variable that can be accessed in every function.

```js
string public myMessage = "Hello World";

function updateString(string memory myMessage) public payable {
    if(msg.value == 1 ether) {
        myMessage = myMessage;
    } 
    else{
        payable(msg.sender).transfer(msg.value);
    }
}
```

- **msg.sender** is the address of the person who deployed the Smart Contract.  
- **msg.value** is used to get the amount of ETH sent along with a transaction to a smart contract.



### RECEIVE FUNCTION

- **Low-Level interaction** 
- This is the function that is executed on plain Ether transfers.
- The receive function is executed on a call to the contract with empty calldata.   
- The receive function can only rely on 2300 gas being available.


```js
uint public value;
string public message;

receive() external payable { 
    value = msg.value;
    message = "recieved";
}
```


### FALLBACK FUNCTION (Handling ether transaction)

- **Low-Level interaction**
- When Call-data field is filled, then we can call fallback function.
- If a payable fallback function is also used in place of a receive function, it can only rely on 2300 gas being available.
- The fallback function always receives data, but in order to also receive Ether it must be marked payable.
- If Ether is sent to the contract without any data or with data that doesn't match any existing function signatures, the fallback function is triggered


```js
uint public value;
string public message;

receive() external payable { 
    value = msg.value;
    message = "recieved";
}

fallback() external payable { 
    value = msg.value;
    message = "fallback";
} 
```

- **receive()** is a function that gets priority over **fallback()** when a calldata is empty.
- But **fallback** gets precedence over **receive** when calldata does not fit a valid function signature.  



#### SENDING ETHER TO SPECIFIC ADDRESS

- To send ETH on specific address we can use **transfer function**


```js
address payable toAddress;
toAddress.transfer(amountToSend);
```

- To receive an ETH on specific address, the address variable should also be an **payable**


#### NOTE : The **address(this)** expression refers to the contract's own address within its code.
#### **address(this).balance** returns the balance of the smart contract.




### MAPPING TYPES (mapping(KeyType => ValueType))

- Mapping types use the syntax **mapping(KeyType => ValueType)**
- The **KeyType** can be any built-in value type, bytes, string, or any contract or enum type.
- **ValueType** can be any type, including mappings, arrays and structs.

- It is an key and value datatype that does not have lenght or storage property.


```js
mapping (address => uint) public Balance;

function sendMoney() public payable {
    Balance[msg.sender] += msg.value;
}

function withDrawMoney(address to, uint amount) public payable {
    Balance[msg.sender] -= msg.value;
    to.transfer(amount);
}
```


- Understand the mapping as **key:value** pair.
- In mapping the datatypes has its default value initially.
- **mappings** do not have a length or a concept of a key or value being set.



### STRUCTS

- Solidity provides a way to define new types in the form of structs.
- Solidity uses structs to define new datatypes and group several variables together.
- A struct is a way to generate a new DataType, by basically grouping several simple Data Types together.

```js

// Defining struct
struct PaymentReceipt {
    address from;
    uint amount;
}

// THIS IS ONE METHOD TO ACCESS MAPS.
mapping (address => PaymentReceipt) public Balance;

function getPaymentHistory() public payable {
    Balance[msg.sender].amount = msg.value;
}


// ANOTHER WAY TO USE STRUCT.

PaymentReceipt public payment;
payment.from = msg.sender;
payment.amount = msg.value;

```


### NESTING MAPS IN STRUCT.

- Now, we will nest an map in an struct, so that it will become more easy and powerful to use struct with mappings.

```js
struct Transaction {
    uint amount;
    uint timestamp;
}

struct Payment {
    uint totalBalance;
    uint totalDeposit;
    mapping(uint => Transaction) deposits;
}

mapping (address => Payment) public Balance;

function deposit() public payable {
    Balance[msg.sender].totalBalance += msg.value;

    Balance[msg.sender].deposits[Balance[msg.sender].totalDeposit].amount = msg.value;
    Balance[msg.sender].deposits[Balance[msg.sender].totalDeposit].timestamp = block.timestamp;
    Balance[msg.sender].totalDeposit++;
}

function checkBalance(address _address) public view returns (uint){
    return Balance[msg.sender].totalBalance;
}
```

- By using **struct** inside an **mappings**, will be easier to handle the transaction.




### ARRAYS IN SOLIDITY.

- Just like an array in JS, arrays is solidity work exactly same.

```js
contract SampleArray {
    
    uint[] public dynamicArray;
    string[] public StringArray;

    function setValue(uint value) public {
        dynamicArray.push(value);
    }

    function getValue(uint index) public view returns (uint){
        return dynamicArray[index];
    }

    function deleteElement() public {
        dynamicArray.pop();
    }

    function sizeOfArray() public view  returns (uint){
        return dynamicArray.length;
    }
}
```
- An array can be of any data type (uint, string, struct, enum).





### ARRAY AND STRUCT (ARRAY AND JS OBJECT).

- An array can be of any data type (including **struct**) stored at specific index.

```js

struct StudentReport{
    string name;
    uint mark1;
    string HomeAdd;
}

StudentReport[] public ReportArray;

function fillReport(string _name, uint _mark1, string homeAddress) public {
    StudentReport memory ReportCard = StudentReport({
        name : _name,
        mark1 : _mark1,
        HomeAdd : homeAddress
    });

    ReportArray.push(ReportCard);
}

function getReportCard() public view returns(StudentReport[] memory){
    return (ReportArray)
}

```


### EXCEPTION HANDLING IN SOLIDITY.

1. **require() Statements** 

- **require(condition,"Error Occurred!!!")**
- It read as if condition is false it will throw an error exception with log statement.
- And, if it is true it will execute the remaining code.

```js

mapping (address => uint) public Balance;

function deposit() public payable {
    Balance[msg.sender] += msg.value;
}

function withDrawMoney(address payable to, uint amount) public payable {

    require(amount <= Balance[msg.sender], "Not enough funds!!!");
    Balance[msg.sender] -= amount;
    to.transfer(amount);
}

```

- **require()** statement works exactly opposit to if-else statements.


2. **assert() statements** (DON'T KNOW WHEN TO USE???)

- Assert is used to check invariants
- Those are states our contract or variables should never reach, ever.

```js

mapping (address => uint8) public Balance;

function deposit() public payable {
    assert(msg.value == uint8(msg.value));
    Balance[msg.sender] += uint8(msg.value);
    assert(Balance[msg.sender] >= uint8(msg.value));
}

function withDrawMoney(address payable to, uint8 amount) public payable {
        
    require(amount <= Balance[msg.sender], "Not enough funds!!!");
    assert(Balance[msg.sender] >= Balance[msg.sender] - amount);
    Balance[msg.sender] -= amount;
    to.transfer(amount);
}

```


3. **try/catch statements**

```js

contract ExampleTryCatch {

    // THIS FUNCTION WILL ALWAYS FAIL TO EXECUTE.
    function tryCatch() public pure {
        require(false,"Error Occurred!!!");
    }
}

contract ErrorHandling {
    event ErrorLogging(string reason); 
    event ErrorLoggingCode(uint errorcode);

    function handlingError() public {
        ExampleTryCatch test = new  ExampleTryCatch();

        try test.tryCatch(){
            // do something
        }
        catch Error(string memory reason){
            emit ErrorLogging(reason);
        }
        // Panic is for assert (optional)
        catch Panic(uint errorcode){
            emit ErrorLoggingCode(errorcode);
        }
    }
}

```


### LOW-LEVEL SOLIDITY CALLS (INTERACTING WITH TWO SMART CONTRACT).

- Low-Level solidity call refers to **recieve the funds from other smart contracts.**



```js
contract ContractOne {

    mapping (address => uint) public Balance;

    function deposit() public payable {
        Balance[msg.sender] += msg.value;
    }

    function checkBalance() public view returns (uint){
        return address(this).balance;
    }

    // 2. REQUIRES FALL-BACK FUNCTION TO RECIEVE THE FUNDS FROM DIFFERENT SMART CONTRACTS.
    receive() external payable { 
        deposit();
    }
}


contract ContractTwo {
    receive() external payable { }

    function DepositInContractOne(address to, uint amount) public {

        // 1. 
        ContractOne one = ContractOne(to);
        one.deposit{value:amount, gas:100000}();

        // 2. REQUIRES FALL-BACK FUNCTION.
        (bool send,) = to.call{value:amount, gas:100000}("");
        require(send);
    }
}

```

- Here, we have two methods to recieve funds from low-level calls.

1. WITHOUT FALL-BACK FUNCTION

```js
ContractOne one = ContractOne(to);
one.deposit{value:amount, gas:100000}();
```

2. WITH FALL-BACK FUNCTION

```js
(bool send,) = to.call{value:amount, gas:100000}("");
require(send);
```



### EVENTS

- This provide logging facility of Ethereum.
- Events are a way to access this logging facility

```js
// SAMPLE SMART CONTRACT TO UNDERSTAND THE EVENTS.
contract Events {
    mapping(address => uint) public Balance;

    events(address _from, address _to, uint _amount);

    constructor(){
        Balance[msg.sender] = 100;
    }

    function sendTokens(address _to, uint _amount) public payable{
        require(Balance[msg.sender] >= _amount, "No Enough MOney");
        Balance[msg.sender] -= _amount;
        Balance[_to] += _amount;

        emit(msg.sender, _to, _amount);
    }
}

// THE LOGS WILL BE DISPLAYED ON THE 'logs' FIELD IN OUTPUT.
```


### MODIEFIERS, INHERITANCE AND IMPORTS IN SOLIDITY.

- Let's see a simple smart contract and how we can use the modifiers, inheritance and imports in our smart contracts.

```js
// InheritedContract.sol
contract InheritedContract{

    mapping (address => uint) public Account;
    address owner;

    constructor(){
        owner = msg.sender;
        Account[owner] = 100;
    }

    modifier isOwner(){
        require(msg.sender == owner, "You are not allowed");
        // placeholder input
        _;  
    }
}


// InheritedContract.sol

import "InheritedContract.sol";
contract InheritedContract is InheritedContract {

    event History(address _from, address _to, uint _amnt);

    function createNewToken() public isOwner{
        Account[owner]++;
    }

    function burnToken() public isOwner{
        Account[owner]--;
    }

    function sendToken(address _to,uint _amount) public payable {
        require(Account[msg.sender] >= _amount);
        Account[msg.sender] -= _amount;
        Account[_to] += _amount;

        emit History(msg.sender, _to, _amount);

    }
}

```


#### MODIFIERS

- Right now we have several similar require statements.
- To avoid code duplication and make it easier to change this from a single place, we can use modifiers


```js
modifiers onlyOwner(){
    require(msg.sender == owner, "You are not allowed");
    _;
}

function sendTokens() public onlyOwner{
    // some code...
}
```

#### INHERITANCE

- By inheritance we can make two or more smart contracts.
- And, we can use the function of second inherited smart contract.

```js
contract Owned {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}


contract Sample is Owned{
    // sample code...
}

```


#### IMPORTS

- Now, we export smart contract from one file to another using importing.

```js
// Ownerable.sol

contract Owned {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not allowed");
        _;
    }
}

// SAMPLE SMART CONTRACT
import "./Owned.sol";

contract SampleSmartContract is Owned {
    // some code...
}

```

- We can inherit the smart contract from one file to another file.




### CONTRACT TO CONTRACT INTERACTION

- Sometimes we are required different smart contract to handle some conditions necessary to our DApps.
- Just like in (ReactJs -> Componenets) we have smart contract to handle conditions.

```js

contract ContractA {
    uint data;

    function setData(uint _data) public {
        data = _data;
    }
    function getData() public view returns(uint){
        return data;
    }
}



interface IContractA {
    function setData(uint _data) external;
    function getData() external view returns (uint);
}

contract ContractB {
    IContractA public contractA;

    constructor(address _smartcontractAddress) {
        contractA = IContractA(_smartcontractAddress);
    }
    
    function setDataInContractA(uint _data) external  {
        contractA.setData(_data);
    }
}

```


### WITHDRAW MONEY FROM SMART CONTRACT

- After minting an nft's the price will be stored in smart contract and not in owners balance.
- To withdraw money,


```js
function withDrawMoney(address _address) external payable {
    uint balance = address(this).balance;
    payable(_address).transfer(balance);
}
```

- **address(this)** will return the current smart contract address.


### INTRODUCTION TO WEB3.JS

- **Web3.js** is a JavaScript-library that lets us interact with a blockchain node via its RPC interface or Websockets.
- Here, there are **JavaScript functions** to interact with a blockchain node.


#### WEB3 PROVIDERS (WEBSOCKETS PROVIDERS).

- Web3.js is not sending the requests directly, it abstracts it away into these providers (EIP-6963, EIP-1193).
- Here, we can have example of metamask which automatically connects with website.
- Similarly, for **Web3 Providers** lastly it is connecting to the blockchain node.



### ABI(Application Binary Interface) ARRAY.

- It is used to interact with smart contracts.
- **ABI ARRAY** provides web3js, what functions are present in smart contract.
- The **ABI Array** contains all functions, inputs, as well as all variables and their types from a smart contract

```js
// THIS IS THE SIMPLE EXAMPLE OF ABI ARRAY.
let abiArray = [
	{
		"inputs": [],
        // name : variables, functions,
		"name": "setData",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
]
```


### INTERACTION WITH SMART CONTRACT (web3.eth)

- We can use **Web3** libraries to interact with our smart contract.
- **web3.eth** provide us different methods/functions to interact with smart contract


```js
// TO GET THE ACCOUNTS
(async () => {
  const accounts = await web3.eth.getAccounts();
  console.log(accounts);
  console.log(accounts.lenght);
})()
```

- To interact with smart contract we have,

```js

// SAMPLE SMART CONTRACT
contract setData {
    uint public data = 100;

    function setData(uint _data) public {
        data = _data;
    }
    function getData() public view returns(uint){
        return (data);
    }
}


// JS CODE TO INTERACT WITH SMART CONTRACT
(async ()=>{

    // TO GET ALL ACCOUNTS
    let accounts = await web3.eth.getAccounts();

    let SmartContractAddress = "";
    let abiArray = [
	{
		"inputs": [],
		"name": "myInt",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
];

    let contract = new web3.eth.Contract(abiArray,contractAddress);
    
    // TO UPDATE ANY STATE VARIABLE
    async function setData(newData){
        await contract.methods.setData(newData).send({from : accounts[0]});
    }

    // TO DISPLAY/READ DATA
    let result = await contract.methods.getData().call();
    console.log(result);

})();

```

- From above code we can interact with smart contracts.

1. **new web3.eth.Contract()  ->  myContract.methods.myMethod().call()**  To call an variable

2. **new web3.eth.Contract() -> myContract.methods.myMethod({from:account[0]}).send()**  To update variable or function with params.



### WORKING OF IPFS(InterPlanetary File Storage) and CID(Content Identifier).

- IPFS is a decentralized P2P distributed file storing protocol.
- Storing data on blockchain is way expensive. So, the company store their data on **centralized server and cloud providers**
- In IPFS, files and other data are stored in a network of nodes.
- When a file is added to IPFS, it is split into smaller blocks, hashed using hash algorithm (SHA-256).
- This hash is called as **CID(Content Identifier).** 
- Everytime re-uploading file a new CID is generated.
- To retrieve data, a user requests it using the hash. 
- IPFS locates the nodes storing the corresponding blocks and downloads them.


#### Location Addressing vs Content Addressing

1. Traditional web uses location-based addressing, where content is accessed by its location on a server (URL).

2. IPFS uses content-based addressing, where content is accessed by a hash of its content. This ensures that as long as the content remains the same, its address does not change.


#### PINNING SERVICE TO PINNED A NODE.

- If file is not in used in node using garbage collection process, file will be deleted.
- To prevent from garbage collection process we will use pinning service. 


### TYPES OF WEB3 STORAGE.

- **On-chain storage** refers to the practice of storing data directly on the blockchain, leveraging its inherent security features but at the cost of speed and expense. 

- **off-chain decentralized storage** involves storing data across a network of decentralized nodes or servers.

- **Off-chain private storage solutions** encompass traditional cloud-based and legacy data storage options designed for secure and controlled access.



### NFT METADATA

- NFT metadata is the sum of all data that describes an NFT, typically including its name, traits, trait rarity, link to the hosted image, total supply, transaction history, and other essential data.

- **NFT MetaData** contains all description for our NFT including image, image_url, description, attributes.

```json
// NFT-MetaData-Template

{
    "name":"Cryptodunks #101",
    "description":"",
    "image":"ipfs://QmXtHPbZoUNkUwGcZTcqD8TLRtozdxpjReMroioMPEvkSC/0.png",
    "attributes":[
        {
            "trait_type":"language",
            "value":"JavaScript"
        },
        {
            "trait_type":"OS",
            "value":"Windows"
        },
        {
            "trait_type":"Token",
            "value":"ERC-721"
        }
    ]
}

```

###

1. public mint function
2. mint multiple nfts
3. add uri function
4. view nfts on opensea
5. withdraw function
6. allowlist minting function
7. minting window to enable and disable
8. MAX LIMIT PER WALLET



### INSTALLING TRUFFLE AND INITIALLIZING THE PROJECT

- npm install -g truffle (globally)

- mkdir project_name
- truffle init
- npm init -y
- echo "node_modules" > .gitignore
- npm i --save @openzeppelin/contracts
- truffle compile 