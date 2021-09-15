// author:      Francesco Di Lillo
// last edit:   15 September 2021
// purpose:     Smart contract to simulate the distribution of funds among investors. First step towards a DeFi app


pragma solidity  >=0.7.0 <0.9.0;

contract defiBank {
    
    address payable [] investors;
    mapping(address => uint) funds;
    
    function payInvestor (address payable wallet, uint amount) public {
        
        investors.push(wallet);                 // add address to list of investors wallet
        funds[wallet] = amount;
        
    }
    
    function getInvestors() public view returns(address payable[] memory){
        
        return investors;
        
    }
    
    
}