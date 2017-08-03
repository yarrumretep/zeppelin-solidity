pragma solidity ^0.4.11;

import "./ERC20Basic.sol";

contract ERC23 is ERC20Basic {
  function transfer(address to, uint value, string fallback, bytes data) returns (bool ok);
}
