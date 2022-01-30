pragma solidity >=0.8.0 <0.9.0;

//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NFTixBooth is ERC721URIStorage {
    bool public saleIsActive = false;

    constructor() ERC721("NFTix", "NFTX") {}

    function openSale() public {
        saleIsActive = true;
    }

    function closeSale() public {
        saleIsActive = false;
    }
}
