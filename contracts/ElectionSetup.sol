// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "./verifier.sol";
import "./Voting.sol";

contract SetupStage {
    uint256 private currentRoot;
    uint256 private electionID;
    address private owner;
    uint[] registrations;
    mapping(uint256 => bool) public usedNullifiers;
    Groth16Verifier private verifier;

    constructor() {
        owner = msg.sender;
    }

    function registerToVote(uint256 commitment) public {
        registrations.push(commitment);
    }

    function startVotingStage() public {
        require(msg.sender == owner, "Permission denied");
        address newVotingStage = address(new VotingStage());
    }
}
