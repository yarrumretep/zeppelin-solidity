'use strict';

const assertJump = require('./helpers/assertJump');
var StandardTokenWithCallMock = artifacts.require('./helpers/StandardTokenWithCallMock.sol');
var ApprovalReceiverMock = artifacts.require('./helpers/ApprovalReceiverMock.sol');

function awaitEvent(event, handler) {
  return new Promise((resolve, reject) => {
    function wrappedHandler(...args) {
      Promise.resolve(handler(...args)).then(resolve).catch(reject);
    }

    event.watch(wrappedHandler);
  });
}

contract('StandardTokenWithCall', function(accounts) {
  let token;
  let receiver;

  beforeEach(async function() {
    token = await StandardTokenWithCallMock.new(accounts[0], 100);
    receiver = await ApprovalReceiverMock.new();
  });

  it('should approve and call', async function () {
    var event = null;
    var filter = receiver.ApprovalReceived({}, {});

    await token.approveAndCall(receiver.address, 50, '0x123456');
    await awaitEvent(filter, (err, e) => {
      event = e;
    })
    assert.isOk(event);
    assert.equal(event.args.from, accounts[0]);
    assert.equal(event.args.value, 50);
    assert.equal(event.args.tokenContract, token.address);
    assert.equal(event.args.extra, '0x123456');
  })
})
