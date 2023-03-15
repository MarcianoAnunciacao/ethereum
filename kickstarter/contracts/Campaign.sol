pragma solidity ^0.8.18;
// SPDX-License-Identifier: MIT
contract Campaign {
    struct Request {
        string description;
        uint value;
        address recipient;
        bool complete;
    }

    Request[] public requests;
    address public manager;
    uint minimunContribution;
    address [] public approvers;

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

        approvers.push(msg.sender);
    }

    function createRequest(string memory _description, uint _value, address _recipient) public restricted{
        requests.push( Request({
            description: _description,
            value: _value,
            recipient: _recipient,
            complete: false
        }));
    }


}
