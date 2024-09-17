// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../NFtOnChain.sol";

contract NftOnchainFactory {
    NftOnchain[] public nftOnchainClones;

    function createNftOnchain(string memory svg) external returns (NftOnchain newNft, uint256 length) {
        newNft = new NftOnchain(svg);
        nftOnchainClones.push(newNft);
        length = nftOnchainClones.length;
    }

    function getNftOnchainClones() external view returns(NftOnchain[] memory) {
        return nftOnchainClones;
    }
}