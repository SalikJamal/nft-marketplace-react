// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './ERC721/ERC721Connector.sol';


contract DarkPhantom is ERC721Connector {

    // Array to store our NFTs
    string[] public darkPhantomz;
    mapping(string => bool) darkPhantomExists;

    // First Exercise - Initialize this contract to inherit
    // Name and symbol from ERC721Metadat so that
    // The name is DarkPhantom and the symbol is DPhantomz

    constructor() ERC721Connector("DarkPhantom", "DPhantomz") {}

    function mint(string memory _darkPhantom) public {
        
        require(!darkPhantomExists[_darkPhantom], "Error: DarkPhantom already exists");

        // This is deprecated - uint id = darkPhantomz.push(_darkPhantom);
        // .push no longer returns the length but a reference to the added element
        darkPhantomz.push(_darkPhantom);
        uint id = darkPhantomz.length - 1;

        _mint(msg.sender, id);
        darkPhantomExists[_darkPhantom] = true;

    }

}