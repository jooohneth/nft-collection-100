//SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTContract is ERC721, ERC721URIStorage{

    using Counters for Counters.Counter;
    Counters.Counter private tokedIds;

    uint private constant MAX_SUPPLY = 100;
    uint private constant MINT_PRICE = 0.01 ether;
    uint private constant MAX_AMOUNT_PER_TRANSACTION = 5;

    address private owner;

    constructor() ERC721("MyNFT", "MNFT"){
        owner = msg.sender;
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