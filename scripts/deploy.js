const {ethers} = require("hardhat");

async function main() {

  const NFTContract = await ethers.getContractFactory("NFTContract");
  const nftContract = await NFTContract.deploy();

  await nftContract.deployed();

  console.log("Contract deployed to: ", nftContract.address);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});