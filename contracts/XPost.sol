// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.19;

import "hardhat/console.sol";

contract XPost {
    uint256 totalPosts;
    uint256 private seed;

    event NewPost(address indexed from, uint256 timestamp, string message);

    struct Post {
        address sender;
        string message;
        uint256 timestamp;
    }

    Post[] posts;

    mapping(address => uint256) public lastPostedAt;

    constructor() payable {
        seed = (block.timestamp + block.prevrandao) % 100;
    }

    function createPost(string memory _message) public {
        require(lastPostedAt[msg.sender] + 30 seconds < block.timestamp, "Must wait 30 seconds before waving again.");

        lastPostedAt[msg.sender] = block.timestamp;
        
        totalPosts += 1;

        posts.push(Post(msg.sender, _message, block.timestamp));

        seed = (block.prevrandao + block.timestamp + seed) % 100;

        if (seed <= 50) {
            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "The contract does not have sufficient funds to pay the premium."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Unable to send prize.");
        }

        emit NewPost(msg.sender, block.timestamp, _message);
    }

    function getAllPosts() public view returns (Post[] memory) {
        return posts;
    }

    function getTotalPosts() public view returns (uint256) {
        return totalPosts;
    }
}
