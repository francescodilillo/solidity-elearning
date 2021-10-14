// author:      Francesco Di Lillo
// last edit:   14 October 2021
// purpose:     Smart contract to simulate the coin minting and distribution

pragma solidity >=0.7.0 < 0.9.0;

// the contract allows only the creator to create new coins
// anybody can send coins to each other as long as they provide ETH address and amount

contract Coin {
    
    address public minter;                      // to mint new coins
    mapping(address => uint) public balances;   // keeping balances
    
    event sent(address from, address to, uint amount);
    
    // this only runs when we deploy the contract    
    constructor() {
        
        minter = msg.sender;                    // the person calling the contract for the first time is the minter
        
    }
    
    // Purpose: make new coins and send them to an address, only the owner can call it
    function mint(address receiver, uint amount) public{
        
        require(msg.sender == minter);
        balances[receiver] += amount;
        
    }
    
    error insufficientBalance(uint amountRequested, uint amountAvailable);
    
    // Purpose: sending any amount of coins to an existing address
    function send(address receiver, uint amount) public {
        
        if(balances[msg.sender] >= amount) {
            balances[msg.sender] -= amount;
            balances[receiver] += amount;
            emit sent(msg.sender, receiver, amount);
        } else {
            revert insufficientBalance(amount, balances[msg.sender]);
        }
        
        
    }

}