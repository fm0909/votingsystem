// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

interface ITreasury {
    function sendAssets(uint amount, address receiver) external;
}

contract VotingSystem {
    uint quorumRequirement;
    uint passingThreshold;
    uint proposalId;
    ITreasury public treasury;

    struct Proposal {
        string name;
        uint numberOfVotes;
        uint yesVotes;
        uint noVotes;
        uint abstainVotes;
        uint deadline;
        uint amount;
        address receiver;
        bool executed;
    }

    constructor(
        uint _quorumRequirement,
        uint _passingThreshold,
        address _treasury
    ) {
        quorumRequirement = _quorumRequirement;
        passingThreshold = _passingThreshold;
        treasury = ITreasury(_treasury);
    }

    // list of proposals
    mapping(uint => Proposal) public proposals;
    mapping(uint => address) public hasVoted;

    function createProposal(
        string memory name,
        uint deadline,
        uint amount,
        address receiver
    ) external {
        proposals[proposalId] = Proposal(
            name,
            0,
            0,
            0,
            0,
            deadline,
            amount,
            receiver,
            false
        );
        proposalId++;
    }

    function vote(uint _proposalId, uint _vote) external {
        require(_proposalId < proposalId, "Proposal does not exist");
        require(hasVoted[_proposalId] != msg.sender, "You have already voted");
        require(
            block.timestamp < proposals[_proposalId].deadline,
            "Deadline has passed"
        );
        require(_vote == 1 || _vote == 2 || _vote == 3, "Invalid vote");
        hasVoted[_proposalId] = msg.sender;
        proposals[_proposalId].numberOfVotes++;
        if (_vote == 1) {
            proposals[_proposalId].yesVotes++;
        } else if (_vote == 2) {
            proposals[_proposalId].noVotes++;
        } else if (_vote == 3) {
            proposals[_proposalId].abstainVotes++;
        }
    }

    function executeProposal(uint _proposalId) external {
        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(block.timestamp > proposal.deadline, "Deadline has not passed");
        require(
            proposal.yesVotes > passingThreshold &&
                proposal.numberOfVotes > quorumRequirement,
            "Proposal failed"
        );

        proposal.executed = true;
        treasury.sendAssets(proposal.amount, proposal.receiver);
    }

    function updateSettings(
        uint _quorumRequirement,
        uint _passingThreshold
    ) external {
        quorumRequirement = _quorumRequirement;
        passingThreshold = _passingThreshold;
    }
}
