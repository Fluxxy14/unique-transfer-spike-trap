// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TransferSpikeTrap {
    uint256 public minAmount;
    uint256 public maxAmount;

    constructor() {
        // safe band between 0.01 ETH and 5 ETH
        minAmount = 0.01 ether;
        maxAmount = 5 ether;
    }

    event SafeTransfer(address indexed from, address indexed to, uint256 amount);

    function transfer(address payable _to, uint256 _amount) external payable {
        require(_amount >= minAmount, " Transfer too small");
        require(_amount <= maxAmount, " Transfer too large");

        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Transfer failed");

        emit SafeTransfer(msg.sender, _to, _amount);
    }

    receive() external payable {}
}

