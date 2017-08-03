pragma solidity ^0.4.11;

contract ERC23DefaultReceiver {
  function onTokenReceived(address sender, uint value, bytes data) returns (bool ok);
}
