// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./NftOnchain.sol";

contract NftOnchainFactory {
    
   NftOnchainFactory[] NftOnchainFactoryClones;



    function createNftOnchainFactory() external returns (NftOnchainFactory newNft_, uint256 length_) {

        newNft_ = new NftOnchainFactory();

        nftOnchainFactoryClones.push(newNft_);

        length_ = nftOnchainFactoryClones.length;
    }

    function getNftOnchainFactoryClones() external view returns(NftOnchainFactory[] memory) {
        return nftOnchainFactoryClones;
    }
}