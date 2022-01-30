pragma solidity >=0.8.0 <0.9.0;

//SPDX-License-Identifier: MIT

contract YourContract {
    bool public saleIsActive = false;

    constructor() {}

    function openSale() public {
        saleIsActive = true;
    }

    function closeSale() public {
        saleIsActive = false;
    }
}
