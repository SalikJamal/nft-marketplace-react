// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './ERC721.sol';


contract ERC721Enumerable is ERC721 {

    uint[] private allTokens;

    // Mapping from tokenId to position in allTokens array
    mapping(uint => uint) private allTokensIndex;

    // Mapping of owner to list of all owner token ids
    mapping(address => uint[]) private ownedTokens;

    // Mapping from tokenId to index of the owner tokens list
    mapping(uint => uint) private ownedTokensIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns(uint) {
        return allTokens.length;
    }

    function _mint(address _to, uint _tokenId) internal override(ERC721) {
        super._mint(_to, _tokenId);
        addTokensToAllTokenEnumeration(_tokenId);
    }

    function addTokensToAllTokenEnumeration(uint _tokenId) private {
        allTokensIndex[_tokenId] = allTokens.length;
        allTokens.push(_tokenId);
    }

}