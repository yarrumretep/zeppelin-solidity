pragma solidity ^0.4.11;


import '../../contracts/token/ApprovalReceiver.sol';
import '../../contracts/token/ERC20.sol';

// mock class using StandardTokenWithCall
contract ApprovalReceiverMock is ApprovalReceiver {

  event ApprovalReceived(address from, uint value, address tokenContract, bytes extra);

  function receiveApproval(address from, uint value, address tokenContract, bytes extraData) returns (bool) {
    assert(ERC20(tokenContract).transferFrom(from, this, value));
    ApprovalReceived(from, value, tokenContract, extraData);
    return true;
  }

}
