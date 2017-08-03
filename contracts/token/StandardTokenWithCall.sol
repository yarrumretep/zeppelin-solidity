pragma solidity ^0.4.11;

import './StandardToken.sol';
import './ApprovalReceiver.sol';

contract StandardTokenWithCall is StandardToken {

  function approveAndCall(address _spender, uint256 _value, bytes _extraData) returns (bool success) {
    assert(approve(_spender, _value));
    return ApprovalReceiver(_spender).receiveApproval(msg.sender, _value, this, _extraData);
  }

}
