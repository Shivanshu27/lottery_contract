// SPDX-License-Identifier: GPL-3.0-or-above

pragma solidity ^0.8.0;

contract lottery {
    address public manager;
    address[] public players;

    constructor() {
        manager = msg.sender;
    }

    // receive() external payable {
    //     require (msg.value== 1 ether, "you need to pay 1 ether to enter lottery");
    //     players.push(payable(msg.sender));
    // }

    function enterplayer() public payable {
        require(
            msg.value == 1 ether,
            "you need to pay 1 ether to enter lottery"
        );
        players.push(payable(msg.sender));
    }

    function totalplayers() public view returns (uint256) {
        return players.length;
    }

    function getbalance() public view returns (uint256) {
        return address(this).balance;
    }

    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.difficulty, block.timestamp, players)
                )
            );
    }

    function selectwinner() public {
        require(manager == msg.sender, "you are not the manager");
        require(totalplayers() >= 3, "not enough players to run lottery");
        uint256 index;
        index = random() % totalplayers();
        address payable winner;
        winner = payable(players[index]);
        winner.transfer(getbalance());
        players = new address[](0);
    }
}
