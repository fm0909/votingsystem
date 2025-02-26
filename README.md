## Voting System

Locally create a `.env` file and have the RPC ready (in this example, we used Avalanche Fuji Testnet). You need to make sure you have some test tokens. 

Include private key in local `.env` file (be careful, do not upload it, otherwise the wallet is basically open).

**Load the enviroment variables**

```
source .env
```

**Deploy the contract**

first deploy `Treasury.sol`, then `VotingSystem.sol`

```
forge create src/Treasury.sol:Treasury --private-key $PRIVATE_KEY --rpc-url $FUJI_RPC --broadcast

```

Then it should return some results like the following 

```
Deployer: your_current_addr
Deployed to: deployed_Treasury_addr
Transaction hash: your_hash
```

Then deploy the other contract (==not sure==)

```
forge create src/Treasury.sol:Treasury --private-key $PRIVATE_KEY --rpc-url $FUJI_RPC --broadcast --constructor-args deployed_Treasury_addr
```

Then both contracts should be on-chain (Avalanche Fuji Testnet) now. May need to ask LLM how to add this testnet to Metamask.

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
- **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
- **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
- **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
