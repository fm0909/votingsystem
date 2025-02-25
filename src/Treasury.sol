// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "./Proposals.sol";

contract Treasury {
    address public votingSystem;
    uint public treasuryBalance;

    constructor(address _votingSystem) {
        votingSystem = _votingSystem;
    }

    function sendAssets(uint amount, address receiver) external {
        require(
            msg.sender == votingSystem,
            "Only voting system can send assets"
        );
        require(receiver != address(0), "Invalid receiver address");
        require(amount > 0, "Invalid amount");

        require(address(this).balance >= amount, "Insufficient balance");
        treasuryBalance -= amount;
        (bool success, ) = receiver.call{value: amount}("");
        require(success, "Transfer failed");
    }

    receive() external payable {}
}
