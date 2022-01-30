pragma solidity >=0.8.0 <0.9.0;

//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTixBooth is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private currentId;

    bool public saleIsActive = false;
    uint256 public totalTickets = 10;
    uint256 public availableTickets = 10;

    mapping(address => uint256[]) public holderTokenIDs;

    constructor() ERC721("NFTix", "NFTX") {
        currentId.increment();
        console.log("NFTixBooth created", currentId.current());
    }

    function mint() public {
        require(availableTickets > 0, "No more tickets available");

        _safeMint(msg.sender, currentId.current());
        currentId.increment();
        // availableTickets = availableTickets - 1;
        availableTickets--;
    }

    function availableTicketsCount() public view returns (uint256) {
        return availableTickets;
    }

    function totalTicketsCount() public view returns (uint256) {
        return totalTickets;
    }

    function openSale() public {
        saleIsActive = true;
    }

    function closeSale() public {
        saleIsActive = false;
    }
}
