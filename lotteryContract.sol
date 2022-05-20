// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Lottery {
    address payable[] public players;
    address payable winner;
    address public manager;

    constructor() {
        manager = msg.sender;
    }

    function enterPlayer() public payable {
        require(
            msg.value >= 2 ether,
            "insufficient funds to enter the lottery"
        );
        players.push(payable(msg.sender));
    }

    function random() private view returns (uint256) {
        uint256 randomNumber;
        randomNumber = uint256(
            keccak256(
                abi.encodePacked(block.difficulty, block.timestamp, players)
            )
        );
        return randomNumber;
    }

    // function random() private view returns (uint256) {
    //     return
    //         uint256(
    //             keccak256(
    //                 abi.encodePacked(block.difficulty, block.timestamp, players)
    //             )
    //         );
    // }

    function selectwinner() public returns (address) {
        require(manager == msg.sender, "you are not the owner");
        require(players.length >= 3, "not enough players to play lottery");
        winner = payable(players[random() % players.length]);
        winner.transfer(address(this).balance);
        players = new address payable[](0);
        return address(winner);
    }
}
