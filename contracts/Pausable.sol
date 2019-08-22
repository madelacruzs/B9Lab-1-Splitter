pragma solidity ^0.5.0;
import './Ownable.sol';

contract Pausable is Ownable {
  event Pause(address account);
  event Unpause(address account);
  bool public _paused;

  constructor(bool paused, address initialOwner) Ownable (initialOwner) public {
        _paused = paused;
  }

  modifier whenNotPaused() {
    require(!_paused, "Error require not paused");
    _;
  }
  modifier whenPaused() {
    require(_paused, "Error require paused");
    _;
  }
  function pause() public onlyOwner whenNotPaused {
    _paused = true;
    emit Pause(msg.sender);
  }

  function unpause() public onlyOwner whenPaused {
    _paused = false;
    emit Unpause(msg.sender);
  }
}