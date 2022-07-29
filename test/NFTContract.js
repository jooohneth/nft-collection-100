const {expect} = require("chai");
const {ethers} = require("hardhat");

let nftContract;

describe("NFTContract", function(){
    it("should deploy and return correct name, symbol and owner", async function(){

        const NFTContract = await ethers.getContractFactory("NFTContract");
        nftContract = await NFTContract.deploy();
        const [owner] = await ethers.getSigners();

        await nftContract.deployed();

        const name = await nftContract.name();
        const symbol = await nftContract.symbol();
        const _owner = await nftContract.owner();

        expect(name).to.equal("King Street Analytics");
        expect(symbol).to.equal("KSA");
        expect(_owner).to.equal(owner.address);
    
    });
})