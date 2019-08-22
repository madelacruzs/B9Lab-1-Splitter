pragma solidity ^0.5.0;

contract Ownable {
  
  address public owner;

  constructor(address initialOwner) public{
    owner = initialOwner;
  }

  modifier onlyOwner() {
    require(msg.sender == owner, "Error, only owner");
    _;
  }
}