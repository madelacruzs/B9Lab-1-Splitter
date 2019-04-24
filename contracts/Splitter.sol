pragma solidity ^0.5.0;

contract Splitter {
    address public owner;
    mapping (address => uint) balances;
    // uint balance;

    event LogSplitter(address indexed sender, address indexed bob, address indexed carol, uint amount);
    event LogWithdraw(address who, uint amount, bool success);

    //Only Owner modifier
    modifier onlyOwner() {
        if (msg.sender == owner) _;
    }

    constructor() public {
        owner = msg.sender;
    }

    //Split ETH from Alice
    function splitEth(address _bob, address _carol) public payable returns (bool success){
        require(_bob != address(0) && _carol != address(0), "Bob and Carol's accounts can not be empty");
        require(msg.value > 0,"Ether is required");

        //Split
        uint half = msg.value / 2;

        balances[_bob] += half;
        balances[_carol] += half;

        emit LogSplitter(msg.sender,_bob, _carol, msg.value);
        return true;
    }

    // Balance of the Smart Contract
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    //Get Balance By Address
    function getBalanceByAddress(address _user) public view returns (uint) {
        return balances[_user];
    }

    //withdraw of the Smart Contract
    // function withDraw() public onlyOwner returns(bool success) {
    //     uint amount = address(this).balance;
    //     require(amount > 0, "No balance available");
    //     msg.sender.transfer(address(this).balance);
    //     return true;
    // }

    // The Solidity Withdrawal Pattern. Blog's Rob Hitchens
    function withdrawFunds(uint amount) public returns(bool success) { 
        // guards up front  
        require(balances[msg.sender] >= amount,"balance insufficient"); 
        // transfer
        balances[msg.sender] -= amount;         

         if(!transferFounds(amount, msg.sender)) {
            //Fail: return your original balance
            balances[msg.sender] += amount;
            emit LogWithdraw(msg.sender, 0,false);
            return false;
        }else{
            //Success   
             emit LogWithdraw(msg.sender, amount,true);
             return true;
        }
    }

    function transferFounds(uint amount, address payable to) private returns(bool success) {
        to.transfer(amount);            
        return true;
    }

}
