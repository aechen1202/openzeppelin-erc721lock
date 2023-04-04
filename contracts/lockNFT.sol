// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./token/ERC721/ERC721.sol";
import "./token/ERC721/ERC721.sol";
import "./security/Pausable.sol";
import "./access/Ownable.sol";
import "./utils/Counters.sol";

contract lockNFT is ERC721, Pausable, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    uint256 MAX_SUPPLY=9;
    string baseURI = "ipfs://Qmdhe87uRvnpbxKEkWTGkpgdFP3RS4bQBLCJWp8vqkQmqp/";
    string metaExtension = ".json";
    uint256 PRICE_AFTER_FREE_LIMIT = 0.001 ether;
    mapping(address => uint256) private _packedAddressData;
    mapping(uint256 => bool) private _lockedNFTs;


    constructor() ERC721("2023 Happy Lunar New Year", "2023LunarNewYear-Rabbit") {}

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721)
        returns (string memory)
    {
        require(_exists(tokenId),"uri query for nonexistent token");
        return string(abi.encodePacked(baseURI,Strings.toString(tokenId),metaExtension));
    }

    function mint() public payable {
        uint256 tokenId = _tokenIdCounter.current();
        require(tokenId<=MAX_SUPPLY,"Minted out");
         _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }
}