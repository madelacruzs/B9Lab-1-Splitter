const SimpleGetSet = artifacts.require("SimpleGetSet");
const Splitter = artifacts.require("Splitter");

module.exports = function(deployer) {
  deployer.deploy(SimpleGetSet);
  deployer.deploy(Splitter);
};
