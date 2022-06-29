// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import './ERC721.sol';
import "../interfaces/IERC721Enumerable.sol";


contract ERC721Enumerable is IERC721Enumerable, ERC721 {

    uint[] private allTokens;

    // Mapping from tokenId to position in allTokens array
    mapping(uint => uint) private allTokensIndex;

    // Mapping of owner to list of all owner token ids
    mapping(address => uint[]) private ownedTokens;

    // Mapping from tokenId to index of the owner tokens list
    mapping(uint => uint) private ownedTokensIndex;

    constructor() {
        _registerInterface(bytes4(
            keccak256("totalSupply(bytes4)") ^ 
            keccak256("tokenByIndex(bytes4)") ^ 
            keccak256("tokenOfOwnerByIndex(bytes4)")
        ));
    }

    /// @notice Count NFTs tracked by this contract
    /// @return uint A count of valid NFTs tracked by 
    /// this contract, where each one of them has an 
    /// assigned and queryable owner not equal to the 
    /// zero address
    function totalSupply() public override view returns(uint) {
        return allTokens.length;
    }

    /// @notice Mint the NFT
    /// @param _to The address of the user to mint this NFT to
    /// @param _tokenId The token identifier for an NFT
    function _mint(address _to, uint _tokenId) internal override(ERC721) {
        super._mint(_to, _tokenId);
        addTokensToAllTokenEnumeration(_tokenId);
        addTokensToOwnerEnumeration(_to, _tokenId);
    }

    /// @notice Adds new tokens to the ownedTokens and ownedTokensIndex to 
    /// keep track of an address's owned tokens.
    /// @param _tokenId The token identifier for an NFT
    /// @param _to The address of the user to track the tokens
    function addTokensToOwnerEnumeration(address _to, uint _tokenId) private {
        ownedTokens[_to].push(_tokenId);
        ownedTokensIndex[_tokenId] = ownedTokens[_to].length;
    }

    /// @notice Adds new tokens to the allTokens and allTokensIndex 
    /// to keep track
    /// @param _tokenId The token identifier for an NFT
    function addTokensToAllTokenEnumeration(uint _tokenId) private {
        allTokensIndex[_tokenId] = allTokens.length;
        allTokens.push(_tokenId);
    }

    /// @notice Enumerate valid NFTs
    /// @dev Throws if _index >= totalSupply()
    /// @param _index The index of the token
    /// @return uint The token identifier for the NFT
    function tokenByIndex(uint _index) external override view returns (uint) {
        require(_index <= totalSupply(), "Global index is out of bounds!");
        return allTokens[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if _index >= balanceOf(_owner) or if _owner is the zero address, 
    /// representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index The index of the token
    /// @return uint The token identifier for the indexed NFT assigned to owner
    function tokenOfOwnerByIndex(address _owner, uint _index) external override view returns (uint) {
        require(_index <= balanceOf(_owner), "Owner index is out of bounds!");
        require(_owner != address(0), "Owner is invalid!");
        return ownedTokens[_owner][_index];
    }

}