pragma solidity ^0.5.0;

contract Ownable {
  
  address public owner;

  constructor(address sender) public{
    owner = sender;
  }

  modifier onlyOwner() {
    require(msg.sender == owner);
    _;
  }
}