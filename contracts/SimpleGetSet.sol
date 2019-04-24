pragma solidity ^0.5.0;

contract SimpleGetSet {
  address public owner;
  bytes32 public lastName;

  modifier isOwner() {
    if (msg.sender == owner) _;
  }

  constructor() public {
    owner = msg.sender;
  }

  function setLastName(bytes32 _lastName) public {
     lastName = _lastName;
  }

  function getLastName() public view returns (bytes32 ){
     return lastName;
  }
  
  function getYear() public pure returns (uint ){
     return 2019;
  }
}
