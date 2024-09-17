// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "../NFTGatedEventManager.sol";

contract NFTGatedFactory {
    
    NFTGatedEventManager[] nFTGatedEventManagerClones;



    function createNFTGatedEventManager() external returns (NFTGatedEventManager newEvent_, uint256 length_) {

        newEvent_ = new NFTGatedEventManager();

        nFTGatedEventManagerClones.push(newEvent_);

        length_ = nFTGatedEventManagerClones.length;
    }

    function getnFTGatedEventManagerClones() external view returns(NFTGatedEventManager[] memory) {
        return nFTGatedEventManagerClones;
    }
}