// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;
    uint256 private seed;

    event newWave(address indexed from, uint256 timestamp, string message);
    
    struct Wave {
        address waver; //Address of the user who waved
        string message; //message sent by the user
        uint256 timestamp; //time when the user waved
    }

    Wave[] waves;

    mapping(address => uint256) public lastWavedAt;

    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart");

        seed = (block.difficulty + block.timestamp + seed) % 100;
    }

    function wave(string memory _message) public {

        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15 minutes"
        );

        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s waved w/ message %s", msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp));

        emit newWave(msg.sender, block.timestamp, _message);

        seed = (block.difficulty + block.timestamp + seed) % 100;
        
        console.log("Random # generated: %d", seed);
        
        if(seed <= 50){
          console.log("%s won!", msg.sender);

          uint256 prizeAmount = 0.0001 ether;
          require(
            prizeAmount <= address(this).balance, 
            "Trying to withdraw more money than what the contract has"
          );
          (bool success, ) = (msg.sender).call{value: prizeAmount}("");
          require(success, "Failure to withdraw money from contract.");
        }

    }

    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d total waves!", totalWaves);
        return totalWaves;
    }

    function waveCheck() public view {
        if(totalWaves > 1){
            console.log("People love you");
        }
        else{
            console.log("No one loves you");
        }
    }

}