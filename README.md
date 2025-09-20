# TransferSpikeTrap 🪤

A smart contract "trap" deployed on Sepolia Testnet that restricts suspicious wallet transactions.

## Live demo (Sepolia)
- Contract address: 0x16CaE024638e1109707Aa02857EE4D9f1D223Df2  
- Deployment TX: 0x6570684dbb3d2616f42694a1e71c9eeddf7e873c5a2d427ecc905c56934b8531  
- Etherscan: https://sepolia.etherscan.io/address/0x16CaE024638e1109707Aa02857EE4D9f1D223Df2#code

## What it does
Blocks transfers that are too small (< 0.01 ETH) or too large (> 5 ETH). Safe transfers between 0.01 and 5 ETH succeed(This allows for prevention of micro spam txns to stop wallet drainers from
removing a large amount of money in quick chain of events adding a line of defence)

## Files
- `src/TransferSpikeTrap.sol` — contract source
- `script/DeployTrap.s.sol` — Foundry deploy script
- `test/` — test files
- `foundry.toml` — project config

## How to reproduce
1. Install Foundry: `curl -L https://foundry.paradigm.xyz | bash && foundryup`
2. Build: `forge build`
3. Deploy: `forge script script/DeployTrap.s.sol --rpc-url $SEPOLIA_RPC_URL --broadcast`

## Contact
GitHub: https://github.com/Fluxxy14
