// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Treasury {
    address public votingSystem;
    uint public treasuryBalance;

    function sendAssets(uint amount, address receiver) external {
        require(receiver != address(0), "Invalid receiver address");
        require(amount > 0, "Invalid amount");

        require(address(this).balance >= amount, "Insufficient balance");
        treasuryBalance -= amount;
        (bool success, ) = receiver.call{value: amount}("");
        require(success, "Transfer failed");
    }

    receive() external payable {}
}
