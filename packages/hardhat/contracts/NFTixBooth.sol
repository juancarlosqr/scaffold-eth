pragma solidity >=0.8.0 <0.9.0;

//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// https://gist.github.com/ryancharris/ed5c4f161f2ab049adf41a7f3eed2229
import "./Base64.sol";

// Final repo: https://github.com/ryancharris/nftix-demo-ui

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

        string[3] memory svg;
        svg[
            0
        ] = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><text y="50">';
        svg[1] = Strings.toString(currentId.current());
        svg[2] = "</text></svg>";

        string memory image = string(abi.encodePacked(svg[0], svg[1], svg[2]));

        string memory encodedImage = Base64.encode(bytes(image));

        console.log("encodedImage", encodedImage);
        // data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAxMDAgMTAwIj48dGV4dCB5PSI1MCI+MTwvdGV4dD48L3N2Zz4=

        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{ "name": "NFTix #',
                        Strings.toString(currentId.current()),
                        '", "description": "A NFT-powered ticketing system", ',
                        '"traits": [{ "trait_type": "Checked In", "value": "false" }, { "trait_type": "Purchased", "value": "true" }], ',
                        '"image": "data:image/svg+xml;base64,',
                        encodedImage,
                        '" }'
                    )
                )
            )
        );

        string memory tokenURI = string(
            abi.encodePacked("data:application/json;base64,", json)
        );

        _safeMint(msg.sender, currentId.current());
        _setTokenURI(currentId.current(), tokenURI);
        console.log("tokenURI", tokenURI);

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
