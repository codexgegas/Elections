// SPDX-License-Identifier: MIT

pragma solidity ^0.5.16;

contract Election {
	// Model a Candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}
	// Store accounts that have voted
	mapping(address => bool) public voters;
	// Store a Candidate
	// Fetch Candidate
	mapping(uint => Candidate) public candidates;
	// Store Candidates Count
	uint public candidatesCount;

	event votedEvent (
        uint indexed _candidateId
    );
	
//Election 
	constructor() public {
		addCandidates("Candidate 1");
		addCandidates("Candidate 2");
	}
//addCandidates
	function addCandidates (string memory _name) private {
		candidatesCount ++;
		candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
	}

	function vote (uint _candidateId) public {
        // require that they haven't voted before
        require(!voters[msg.sender]);

        // require a valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        // record that voter has voted
        voters[msg.sender] = true;

        // update candidate vote Count
        candidates[_candidateId].voteCount ++;

        emit votedEvent(_candidateId);
    }


}
