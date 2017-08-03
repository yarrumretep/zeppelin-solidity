pragma solidity ^0.4.11;


import '../../contracts/token/StandardTokenWithCall.sol';


// mock class using StandardTokenWithCall
contract StandardTokenWithCallMock is StandardTokenWithCall {

  function StandardTokenWithCallMock(address initialAccount, uint256 initialBalance) {
    balances[initialAccount] = initialBalance;
    totalSupply = initialBalance;
  }

}
