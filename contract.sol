// SPDX-License-Identifier: GPL-3.0-or-above

pragma solidity ^0.8.0;

contract lottery {
    address public manager;
    address[] public players;

    function Lottery() public {
        manager = msg.sender;
    }

    function enterplayer() public payable {
        require(msg.value > 0.01 ether);
        players.push(msg.sender);
    }

    function random() private view returns (uint256) {
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.difficulty, block.timestamp, players)
                )
            );
    }

    function getbalance() public view returns (uint256) {
        return address(this).balance;
    }

    function pickwinner() public view {
        uint256 index = random() % players.length;
        players[index].transfer(getbalance());
    }
}
