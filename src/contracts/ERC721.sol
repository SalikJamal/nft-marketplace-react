// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


/*

    Building out the minting function:
    1. THe NFT that we mint should point to an address
    2. Keep track of the tokenIds (tokenId will be of every single NFT)
    3. Keep track of tokenAddress to tokenIds
    4. Keep track of how many tokens an address has?
    5. Create event that emits a transfer log, to keep track of contract address, where it is being minted to, and the id.
    
    Mapping in Solidity creates a hash table of key pair values

    Exercise:
    1. Write a function called _mint that twakes two arguments, an address called to and an integer tokenId
    2. Add internal visiblity to the signature
    3. Set the tokenOwner of the tokenId to the address argument "to"
    4. Increase the owner token count by 1 each time the function is called 

    BONUS - Create two requirements:
    5. Require that the mint address isn't 0
    6. Require that the token has not already been minted 

*/


contract ERC721 {

    // Mapping from tokenId to the owner
    mapping(uint => address) private tokenOwners;

    // Mapping from owner to number of owned tokens
    mapping(address => uint) private ownedTokensCount;

    event Transfer(address indexed _from, address indexed _to, uint indexed tokenId);

    function _mint(address _to, uint _tokenId) internal {
        
        require(_to != address(0), "ERC721: Minting to the zero address"); // Requires that the address isn't invalid
        require(!_tokenExists(_tokenId), "ERC721: Token already minted"); // Requires that the token doesn't already exist

        tokenOwners[_tokenId] = _to; // Adding a new address with a tokenId when minting
        ownedTokensCount[_to] += 1; // Keeping track of tokens being minted to each address, and adding 1 to it every time it mints

        emit Transfer(address(0), _to, _tokenId); // Emit the Transfer event when transfering token to address

    }

    function _tokenExists(uint _tokenId) internal view returns(bool) {
        
        address owner = tokenOwners[_tokenId]; // Setting the address of nft owner to check the mapping of the address from tokenOwner at the tokenId
        return owner != address(0); // Return truthiness that address is not zero
    }


}