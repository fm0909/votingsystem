// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import "../src/VotingSystem.sol";

contract DeployVotingSystem is Script {
    uint256 public constant QUORUM_REQUIREMENT = 5;
    uint256 public constant PASSING_THRESHOLD = 3;

    function run() external returns (VotingSystem) {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        VotingSystem votingSystem = new VotingSystem(
            QUORUM_REQUIREMENT,
            PASSING_THRESHOLD,
            0xcf8c6c81dF8A08A099bcD82107572d9759315D1C // Replace with the actual Treasury address
        );

        vm.stopBroadcast();
        console.log("VotingSystem deployed at:", address(votingSystem));
        return votingSystem;
    }
}