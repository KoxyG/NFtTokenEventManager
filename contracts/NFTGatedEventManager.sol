// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

// write me an event manager smart contract, 
//that people can create event on the smart contract, 
//for users to register for a particular event, they need to own a particular nft,
// without that they cannot register for that event,
// only that nft can permit them to register for that event .
// This should be called an nft gated event manager

import "./Interface/nft.sol";

contract NFTGatedEventManager  {
 
    // struct to hold event details
    struct Event {
        string name;
        uint256 date;
        uint256 capacity;
        address nftContract;
        uint256 registeredCount;
        mapping(address => bool) registeredAttendees;
    }
    mapping(uint256 => Event) public events;


    uint256 public eventId;
    address public nftContract;


    //blockchain events 
    event EventCreated(uint256 indexed eventId, string name, uint256 date, uint256 capacity, address nftContract);
    event UserRegistered(uint256 indexed eventId, address indexed user);


    
    function createEvent(string memory _name, uint256 _date, uint256 _capacity, address _nftContract) external {
        require(_date > block.timestamp, "Event date must be in the future");
        require(_capacity > 0, "Capacity must be greater than zero");
        require(_nftContract != address(0), "Invalid NFT contract address");

        INftOnchain nftContract_ = INftOnchain(_nftContract);
        uint256 requiredTokenId = nftContract_.nextTokenID() - 1;
        require(nftContract_.ownerOf(requiredTokenId) == msg.sender, "You don't own the latest NFT");

        eventId++;
        Event storage newEvent = events[eventId];
        newEvent.name = _name;
        newEvent.date = _date;
        newEvent.capacity = _capacity;
        newEvent.nftContract = _nftContract;
        newEvent.registeredCount = 0;
        
        // Transfer the NFT to this contract
        nftContract_.safeTransferFrom(msg.sender, address(this), requiredTokenId);

        emit EventCreated(eventId, _name, _date, _capacity, _nftContract);
    }



    function registerForEvent(uint256 _eventId) external {
        Event storage eventToRegister = events[_eventId];
        require(eventToRegister.date > block.timestamp, "Event has already occurred");
        require(eventToRegister.registeredCount < eventToRegister.capacity, "Event is full");
        require(!eventToRegister.registeredAttendees[msg.sender], "You are already registered");

        // Get the current token ID and mint a new NFT for the registrant
        INftOnchain nftContract_ = INftOnchain(eventToRegister.nftContract);
        uint256 currentTokenId = nftContract_.nextTokenID();
        nftContract_.mint(msg.sender);

      
        eventToRegister.registeredAttendees[msg.sender] = true;
        eventToRegister.registeredCount++;

        emit UserRegistered(_eventId, msg.sender);
    }

    function getEventDetails(uint256 _eventId) external view returns (string memory, uint256, uint256, address, uint256) {
        Event storage eventDetails = events[_eventId];
        return (eventDetails.name, eventDetails.date, eventDetails.capacity, eventDetails.nftContract, eventDetails.registeredCount);
    }
    

}