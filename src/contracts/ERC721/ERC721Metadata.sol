// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../interfaces/ERC721/IERC721Metadata.sol";
import "../ERC165/ERC165.sol";


contract ERC71Metadata is IERC721Metadata, ERC165 {

    string private _name;
    string private _symbol;

    constructor(string memory named, string memory symbolified) {
        _name = named;
        _symbol = symbolified;
        _registerInterface(bytes4(
            keccak256("name(bytes4)") ^ 
            keccak256("symbol(bytes4)")
        ));
    }

    
    function name() external override view returns(string memory) {
        return _name;
    }

    function symbol() external override view returns(string memory) {
        return _symbol;
    }

}