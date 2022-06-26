// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './ERC721Metadata.sol';
import './ERC721Enumerable.sol';


contract ERC721Connector is ERC71Metadata, ERC721Enumerable {

    // We deploy connector right away
    // We want to carry the metadata info over
    constructor(string memory name, string memory symbol) ERC71Metadata(name, symbol) {}

}