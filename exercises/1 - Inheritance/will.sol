// author:      Francesco Di Lillo
// last edit:   20 September 2021
// purpose:     Smart contract to simulate the distribution of the inheritance once the deceased variable flips to true. WIP


pragma solidity  >=0.7.0 <0.9.0;

contract Will {
    
    address owner;
    uint fortune;
    bool deceased;
    
    constructor () payable public {             // payable lets us to transfer ETH
        
        owner = msg.sender;                     // msg = message, whoever is calling the function is the owner
        fortune = msg.value;                    // value shows how much ETH has been sent
        deceased = false;                       // we are assuming that the person is not deceased once we start
        
    }

    // Modifiers can be used to extend functionalities

    modifier onlyOwner {
        
        require(msg.sender == owner);
        _;                                      // shift to the actual function after the modifier
        
    }
 
    modifier mustBeDeceased {
        
        require(deceased == true);
        _;                                      // shift to the actual function after the modifier
        
    }
    
    
    // list of family wallets
    address payable [] familyWallets;
    
    // map through inheritance
    mapping(address => uint) inheritance;
    
    function setInheritance (address payable wallet, uint amount) public onlyOwner {
        
        familyWallets.push(wallet);                 // add address to family wallet
        inheritance[wallet] = amount;
        
    }

    // Pay each family member based on their wallet
    function payout() private mustBeDeceased{

        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
        }

    }

    function hasDeceased() public onlyOwner{
    
        deceased = true;
        payout();

    }
    
}