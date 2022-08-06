//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTContract is ERC721, ERC721URIStorage{

    using Counters for Counters.Counter;
    Counters.Counter private tokenIds;

    uint private constant MAX_SUPPLY = 100;
    uint private constant MINT_PRICE = 0.01 ether;
    uint private constant MAX_AMOUNT_PER_TRANSACTION = 5;
    string private constant TOKEN_URI = "ipfs://QmYEhCEARig7Ur1Qkf5YwJtTZmfjTyXWbcDTzi5axqjLaU";
    address public owner;

    constructor() ERC721("King Street Analytics", "KSA"){
        owner = msg.sender;
    }

    function mint(uint amount) external payable {
        require(tokenIds.current() < MAX_SUPPLY, "No NFTs left!");
        require(amount <= MAX_AMOUNT_PER_TRANSACTION, "Not allowed to mint more than 5 NFTs per transaction!");
        require(msg.value == MINT_PRICE * amount, "Not enough ETH!");

        for(uint i = 0; i < amount; i++){

            uint tokenID = tokenIds.current();
            tokenIds.increment();
            _safeMint(msg.sender, tokenID);
            _setTokenURI(tokenID, TOKEN_URI);

        }
    }

    function withdraw() external {
        require(msg.sender == owner, "Not owner!");
        payable(msg.sender).transfer(address(this).balance);
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