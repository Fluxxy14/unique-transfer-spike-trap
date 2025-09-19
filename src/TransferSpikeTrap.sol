// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/// @title Transfer Spike Trap Token
/// @notice ERC20 token with anti-whale transfer spike trap.
contract TransferSpikeTrap is ERC20, Ownable {
    uint256 public maxTxAmount; // max allowed transfer
    mapping(address => bool) public isExempt; // addresses that bypass trap

    event TrapTriggered(address indexed from, address indexed to, uint256 amount);

    constructor(uint256 _supply, uint256 _maxTxAmount)
        ERC20("TransferSpikeTrap", "TST")
        Ownable(msg.sender)
    {
        _mint(msg.sender, _supply);
        maxTxAmount = _maxTxAmount;
        isExempt[msg.sender] = true;
    }

    /// @notice update max transaction amount
    function setMaxTxAmount(uint256 _newLimit) external onlyOwner {
        maxTxAmount = _newLimit;
    }

    /// @notice exempt address from trap (e.g. DEX, owner)
    function setExempt(address account, bool exempt) external onlyOwner {
        isExempt[account] = exempt;
    }

    /// @dev override ERC20 hook to apply trap
    function _update(address from, address to, uint256 value) internal override {
        if (!isExempt[from] && !isExempt[to]) {
            require(value <= maxTxAmount, "Trap triggered: tx too large");
            emit TrapTriggered(from, to, value);
        }
        super._update(from, to, value);
    }
}
