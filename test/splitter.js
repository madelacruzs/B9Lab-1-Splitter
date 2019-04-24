const Splitter = artifacts.require("Splitter");
var ethers = require("ethers");
var utils = require("ethers").utils;

// console.log(ethers.utils.formatBytes32String("DE LA CRUZ"));
var alice, bob, carol;
var instanceSplitter;

contract("Splitter", accounts => {
  alice = accounts[0];
  bob = accounts[1];
  carol = accounts[2];
  const sendAmount = utils.parseEther("5.0");

  //members should be set
  it("Should be able to split amount amount two members", async () => {
    instanceSplitter = await Splitter.deployed();
    let result = await instanceSplitter.splitEth(bob, carol, {
      from: alice,
      value: sendAmount
    });

    assert.equal(
      result.receipt.status,
      true,
      "splitMembers did not return true"
    );
  });

  it("Get Balance by Address (BOB)", async () => {
    let weiAmountResult = await instanceSplitter.getBalanceByAddress(bob);
    let etherHalf = sendAmount / 2;
    let etherResult = weiAmountResult; //utils.formatEther(weiAmountResult.toString());
    assert.equal(etherResult, etherHalf, "Balance is not splitted for Bob.");
  });

  it("Get Balance by Address (Carol)", async () => {
    let weiAmountResult = await instanceSplitter.getBalanceByAddress(carol);
    let etherHalf = sendAmount / 2;
    let etherResult = weiAmountResult;
    assert.equal(etherResult, etherHalf, "Balance is not splitted for Carol.");
  });

  it("Get Balance in Smart Contract ", async () => {
    let weiAmountResult = await instanceSplitter.getBalance();
    let etherResult = utils.formatEther(weiAmountResult.toString());
    //Balance Smart Contract Equal to Value Splitter
    console.log("Balance in Smart Contract: " + etherResult);
  });

  // console.log(alice);
});
