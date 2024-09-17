// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";


interface INftOnchain is IERC721, IERC721Metadata {
    function nextTokenID() external view returns (uint256);
    function svg() external view returns (string memory);
    function svgToImageURI(string memory _svg) external pure returns (string memory);
    function formatTokenURI(string memory imageURI) external pure returns (string memory);
    function mint(address to) external;
    function safeTransferFrom(address from, address to, uint256 tokenId) external;

}