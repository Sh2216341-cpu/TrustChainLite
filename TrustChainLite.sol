// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TrustChainLite {

    struct Team {
        string name;
        uint score;
    }

    address public organizer;
    mapping(uint => Team) public teams;
    mapping(address => bool) public judges;
    uint public teamCount;

    constructor() {
        organizer = msg.sender;
    }

    modifier onlyOrganizer() {
        require(msg.sender == organizer, "Not organizer");
        _;
    }

    modifier onlyJudge() {
        require(judges[msg.sender], "Not judge");
        _;
    }

    function addJudge(address _judge) public onlyOrganizer {
        judges[_judge] = true;
    }

    function registerTeam(string memory _name) public {
        teams[teamCount] = Team(_name, 0);
        teamCount++;
    }

    function submitScore(uint _teamId, uint _score) public onlyJudge {
        teams[_teamId].score += _score;
    }

    function getTeam(uint _id) public view returns(string memory, uint) {
        return (teams[_id].name, teams[_id].score);
    }
}
