pragma solidity ^0.5.0;
import './SafeMath.sol';

contract Splitter {
    
    using SafeMath for uint; 

    mapping (address => uint) public balances;

    event LogSplitter(address indexed sender, address indexed bob, address indexed carol, uint amount);
    event LogWithdraw(address who, uint amount, bool success);

    constructor() public {
    }

    //Split ETH from Alice
    function splitEth(address _bob, address _carol) public payable returns (bool success){
        require(_bob != address(0) , "Bob's accounts can not be empty.");
        require(_carol != address(0), "Carol's accounts can not be empty.");

        require(msg.value > 0,"Ether is required");

        //Split
        uint half = msg.value / 2;

        // add half Bob & Carol
        balances[_bob] = balances[_bob].add(half);
        balances[_carol] = balances[_carol].add(half);

        //remainder for sender.
        balances[msg.sender] = balances[_carol].add(msg.value % 2) ;

        emit LogSplitter(msg.sender, _bob, _carol, msg.value);
        return true;
    }

    // The Solidity Withdrawal Pattern. Blog's Rob Hitchens
    function withdrawFunds(uint amount) public returns(bool success) { 
        // guards up front  
        require(balances[msg.sender] >= amount,"balance insufficient"); 
        // transfer
        balances[msg.sender] -= amount;        
        emit LogWithdraw(msg.sender, amount, true);
        msg.sender.transfer(amount);
        return true;
    }

   

}
