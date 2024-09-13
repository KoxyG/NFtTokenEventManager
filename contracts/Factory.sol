// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./NFTGatedEventManager.sol";

contract MultisigFactory {
    NFTGatedEventManager[] nFTGatedEventManagerClones;
    event NFTGatedEventManagerCreated(address indexed newManager, address indexed creator);


    function createMultisigWallet(uint256 _quorum, address[] memory _validSigners) external returns (MultiSig newMulsig_, uint256 length_) {

        newEvent_ = new NFTGatedEventManager();

        nFTGatedEventManagerClones.push(newEvent_);

        length_ = nFTGatedEventManagerClones.length;

        emit NFTGatedEventManagerCreated(address(newManager_), msg.sender);
    }

    function getnFTGatedEventManagerClones() external view returns(nFTGatedEventManager[] memory) {
        return nFTGatedEventManagerClonesClones;
    }
}