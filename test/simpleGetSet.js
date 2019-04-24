const SimpleGetSet = artifacts.require("SimpleGetSet");
var ethers = require("ethers");

// console.log(ethers.utils.formatBytes32String("DE LA CRUZ"));

contract("SimpleGetSet", accounts => {
  it("Set Last Name", async () => {
    const instanceSimpleGetSet = await SimpleGetSet.deployed();
    await instanceSimpleGetSet.setLastName(
      ethers.utils.formatBytes32String("DE LA CRUZ")
    );

    let year = await instanceSimpleGetSet.getYear();
    assert.equal(year.toNumber(), 2019, "Year is not correct!");
  });

  it("Get Last Name", async () => {
    const instanceSimpleGetSet = await SimpleGetSet.deployed();
    let lastName = await instanceSimpleGetSet.getLastName();
    let sLastName = ethers.utils.parseBytes32String(lastName);
    assert.equal(
      sLastName,
      "DE LA CRUZ",
      sLastName + " is not the correct last name"
    );
  });
});
