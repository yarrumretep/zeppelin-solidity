pragma solidity ^0.4.11;

import './BasicToken.sol';
import './ERC23.sol';

/**
 * @title Standard ERC23 token
 *
 * @dev Implementation of the ERC23 standard token.
 * @dev https://github.com/ethereum/EIPs/issues/223
 * @dev Based on code by Dexaran: https://github.com/Dexaran/ERC23-tokens/tree/Custom-Fallback/token/ERC223
 */
contract StandardERC23Token is ERC23, BasicToken {

  //
  // overridden to call transfer(to, value, fallback, data)
  //
  function transfer(address _to, uint256 _value) returns (bool) {
    transfer(_to, _value, "onTokenReceived(address,uint256,bytes)", new bytes(0));
  }

  function transfer(address to, uint value, string fallback, bytes data) returns (bool ok) {
    uint destinationCodeLength;

    assembly {
      destinationCodeLength:= extcodesize(to)
    }

    balances[msg.sender] = balances[msg.sender].sub(value);
    balances[to] = balances[to].add(value);
    if(destinationCodeLength > 0) {
      assert(to.call.value(0)(bytes4(sha3(fallback)), msg.sender, value, data));
    }
    Transfer(msg.sender, to, value);
    return true;
  }

}
