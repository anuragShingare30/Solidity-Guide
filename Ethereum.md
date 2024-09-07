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


#### msg OBJECT

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