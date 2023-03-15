pragma solidity ^0.4.17;

contract Lottery{
    address public manager;
    address[] public players;

    constructor() public {
        manager = msg.sender;
    }

    modifier onlyManager(){
        require(msg.sender == manager);
        _;
    }

    function enter() public payable {
        require(msg.value > 1 ether, "1 Ether is required to Bet.");
        players.push(msg.sender);

    }

    function pickWinner() public onlyManager{        
        uint256 index = random() % players.length;
        address sender = players[index];
        sender.transfer(address(this).balance);
        players = new address[](0);
    }

    function getPlayers() public view returns (address[]){
        return players;
    }

    function random() private view returns(uint256) {
        return uint(keccak256(abi.encode(block.difficulty, now, players)));
    }
}
