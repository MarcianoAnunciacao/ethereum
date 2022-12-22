pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;

    constructor() public {
        manager = msg.sender;
    }

    function enter() public payable {
        require(msg.value > 1 ether, "1 Ether is required to Bet.");
        players.push(msg.sender);

    }
}