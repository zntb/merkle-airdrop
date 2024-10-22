// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";

contract ClaimAirdrop is Script {
    address private constant CLAIMING_ADDRESS = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;
    uint256 private constant AMOUNT_TO_COLLECT = (25 * 1e18); // 25.000000

    bytes32 private constant PROOF_ONE = 0xd1445c931158119b00449ffcac3c947d028c0c359c34a6646d95962b3b55c6ad;
    bytes32 private constant PROOF_TWO = 0x46f4c7c1c21e8a90c03949beda51d2d02d1ec75b55dd97a999d3edbafa5a1e2f;
    bytes32[] private proof = [PROOF_ONE, PROOF_TWO];

    function claimAirdrop(address airdrop) public {
        vm.startBroadcast();

        MerkleAirdrop(airdrop).claim(CLAIMING_ADDRESS, AMOUNT_TO_COLLECT, proof, v, r, s);
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("MerkleAirdrop", block.chainid);
        claimAirdrop(mostRecentlyDeployed);
    }
}
