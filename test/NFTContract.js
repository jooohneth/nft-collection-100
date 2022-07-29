const {expect} = require("chai");
const {ethers} = require("hardhat");

describe("NFTContract", function(){
    it("should deploy and return correct name and symbol", async function(){

        const NFTContract = await ethers.getContractFactory("NFTContract");
        const nftContract = await NFTContract.deploy();
        await nftContract.deployed();
        const name = await nftContract.name();
        const symbol = await nftContract.symbol();
        expect(name).to.equal("MyNFT");
        expect(symbol).to.equal("MNFT");
        
    });
})