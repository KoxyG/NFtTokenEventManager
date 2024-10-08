
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";



contract NftOnchain is ERC721URIStorage {

    //events
    event Minted(string tokenURI);
    string public svg; 




    constructor() ERC721("EVENT NFT", "ENFT") {
       
    }

    uint256 public nextTokenID;


    function svgToImageURI(
        string memory _svg
    ) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(_svg));
        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }

    function formatTokenURI(
        string memory imageURI
    ) public pure returns (string memory) {
        return
            string(
                abi.encodePacked(
                    "data:application/json;base64,",
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name": "EVENT NFT", "description": "NFT On Chain", "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }


     function mint(string memory _svg) public {
        string memory imageURI = svgToImageURI(_svg);
        string memory tokenURI = formatTokenURI(imageURI);

        _safeMint(msg.sender, nextTokenID);
        _setTokenURI(nextTokenID, tokenURI);
        nextTokenID++;
       

        emit Minted(tokenURI);
     }


}
