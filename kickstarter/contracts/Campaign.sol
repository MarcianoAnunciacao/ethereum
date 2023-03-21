pragma solidity ^0.8.18;
// SPDX-License-Identifier: MIT

import "hardhat/console.sol";

contract Campaign {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
        uint approvalCount;
        mapping(address => bool) approvals;
    }

    Request[] public requests;
    address public manager;
    uint minimunContribution;
    mapping(address => bool) public approvers;
    uint numRequests;

    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    constructor (uint minimun){
        manager = msg.sender;
        minimunContribution = minimun;
    }

    function contribute() public payable {
        require(msg.value > minimunContribution);

        approvers[msg.sender] = true;
    }

    function createRequest(string memory _description, uint _value, address _recipient) public payable restricted{
        console.log("Enter");
        require(approvers[msg.sender]);
        console.log("Pass");
        Request storage request = requests[numRequests++];
        request.description = _description;
        request.value = _value;
        request.recipient = _recipient;
        request.complete = false;
        request.approvalCount = 0;        
    }

    function aprroveRequest(uint index) public {
        Request storage request = requests[index];

        require(approvers[msg.sender]);
        require(request.approvals[msg.sender]);

        request.approvals[msg.sender] = true;
        request.approvalCount++;        
    }
}
