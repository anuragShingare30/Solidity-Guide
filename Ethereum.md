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


### BASIC FUNCTIONS TO WRITE SIMPLE SC.

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
