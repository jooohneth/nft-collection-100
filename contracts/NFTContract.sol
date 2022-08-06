//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

//importing openzeppeling libraries
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTContract is ERC721, ERC721URIStorage{

    //Creating counter to keep track of the number of NFTs minted
    using Counters for Counters.Counter;
    Counters.Counter private tokenIds;

    //Declaring constant variables
    uint private constant MAX_SUPPLY = 100;
    uint private constant MINT_PRICE = 0.01 ether;
    uint private constant MAX_AMOUNT_PER_TRANSACTION = 5;
    string private constant TOKEN_URI = "ipfs://QmYEhCEARig7Ur1Qkf5YwJtTZmfjTyXWbcDTzi5axqjLaU";

    address public owner;

    //Setting the name and symbol of the NFT and setting the owner on contract deployment
    constructor() ERC721("King Street Analytics", "KSA"){
        owner = msg.sender;
    }

    //Mint function
    function mint(uint amount) public payable {
        //Basic requirnments for mint to execute
        require(tokenIds.current() < MAX_SUPPLY, "No NFTs left!");
        require(amount <= MAX_AMOUNT_PER_TRANSACTION, "Not allowed to mint more than 5 NFTs per transaction!");
        require(msg.value == MINT_PRICE * amount, "Not enough ETH!");

        //For loop to mint multiple amounts of NFTs provided by the user
        for(uint i = 0; i < amount; i++){

            uint tokenID = tokenIds.current();
            tokenIds.increment();
            //_safeMint function inherited from ERC721 contract
            _safeMint(msg.sender, tokenID);
            //Setting token URI for each minted NFT
            _setTokenURI(tokenID, TOKEN_URI);

        }
    }

    //Method overloading, called when minting one NFT
    function mint() external payable {
        mint(1);
    }

    //Withdraw function, sends the owner of the contract the amount of money collected from the mints
    function withdraw() external {
        //Only lets the owner to execute the function
        require(msg.sender == owner, "Not owner!");
        
        (bool success, ) = (msg.sender).call{value: address(this).balance}("");
        require(success, "Tx failed!");
    }

    //These functions need to be overridden for Solidity

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

}