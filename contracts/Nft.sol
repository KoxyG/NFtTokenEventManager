// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";


contract NFTContract is  ERC721URIStorage {
 
    constructor() ERC721("KOXYNFT", "nft") {}

    uint256  nextTokenID;

    function MintNewNFT (string memory uri) public  {
        _safeMint(msg.sender, nextTokenID);
        _setTokenURI(nextTokenID, uri);
        nextTokenID++;
    }




    }