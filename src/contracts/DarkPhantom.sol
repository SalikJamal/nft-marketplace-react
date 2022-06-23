// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './ERC721Connector.sol';


contract DarkPhantom is ERC721Connector{

    // First Exercise - Initialize this contract to inherit
    // Name and symbol from ERC721Metadat so that
    // The name is DarkPhantom and the symbol is DPhantomz

    constructor() ERC721Connector("DarkPhantom", "DPhantomz") {}

}