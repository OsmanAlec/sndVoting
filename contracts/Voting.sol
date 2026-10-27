// SPDX-License-Identifier: MIT
pragma solidity ^0.8.34;

import "./verifier.sol";

contract VotingStage {
    uint256 private currentRoot;
    uint256 private electionID;
    uint[] registrations;
    mapping(uint256 => bool) public usedNullifiers;
    Groth16Verifier private verifier;

    constructor() {}

    function registerToVote(uint256 commitment) public {
        registrations.push(commitment);
    }

    function vote(proof, root, nullifier, choice) public {
        require(!usedNullifiers[nullifier], "already voted");
        require(root == currentRoot, "unknown root");
        require(
            verifier.verifyProof(proof, [root, nullifier, electionID, choice])
        );
        usedNullifiers[nullifier] = true;
    }
}
