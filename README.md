# Basic ERC165 Demo

A minimal demo project showing how to implement **ERC165** (Standard Interface Detection) in [Vyper](https://vyperlang.org/). ERC165 lets contracts and clients discover which interfaces a contract supports at runtime.

## What is ERC165?

[EIP-165](https://eips.ethereum.org/EIPS/eip-165) defines a standard way to query whether a contract implements a given interface. A contract that supports ERC165 exposes:

- **`supportsInterface(bytes4 interfaceId) -> bool`** — returns `true` if the contract implements the interface identified by `interfaceId`, otherwise `false`.

Interface IDs are the XOR of the function selectors of the interface. This allows callers to check support for ERC20, ERC721, custom interfaces, etc., before calling.

## Project structure

```
basic-erc165/
├── contracts/
│   ├── Basic.vy              # Contract implementing ERC165 and FooBar
│   └── interfaces/
│       └── FooBar.vyi        # Example interface (calculate, test1)
├── tests/
│   └── test_basic.py         # Tests for supportsInterface
├── pyproject.toml
└── README.md
```

## Implementation overview

### 1. Interface: `FooBar.vyi`

Defines a simple interface with two functions:

- `calculate() -> uint256`
- `test1(address _target)`

### 2. Contract: `Basic.vy`

- **Implements** the `FooBar` interface via `implementa: FooBar`.
- **ERC165 support**:
  - `_SUPPORTED_INTERFACES`: constant array of `bytes4` interface IDs:
    - `0x01ffc9a7` — ERC165’s own interface ID (the selector of `supportsInterface(bytes4)`).
    - `0x6e7f1a90` — Interface ID for FooBar (derived from its function selectors).
  - `supportsInterface(bytes4 _interface_id) -> bool`: returns whether `_interface_id` is in `_SUPPORTED_INTERFACES`.

So the contract both implements ERC165 and advertises that it supports the FooBar interface.

## Running the tests

Requirements: Python 3.13+, [uv](https://docs.astral.sh/uv/) (or use your existing Python/venv and install deps from `pyproject.toml`).

```bash
# Install dependencies (with uv)
uv sync

# Run tests
uv run pytest tests/ -v
```

Tests verify that:

- The contract reports support for the FooBar interface ID (`0x6e7f1a90`).
- The contract reports support for the ERC165 interface ID (`0x01ffc9a7`).
- An unknown interface ID (`0xffffffff`) returns `false`.

## Computing interface IDs

An interface ID is the XOR of the 4-byte function selectors of all functions in the interface (excluding inherited functions). For a single function, it’s that function’s selector.

- **ERC165**: only `supportsInterface(bytes4)` → `0x01ffc9a7`.
- **FooBar**: derived from `calculate()` and `test1(address)`; in this project it is `0x6e7f1a90`.

You can compute selectors/interface IDs with Vyper tooling or standard EVM selector calculations.

## References

- [EIP-165: Standard Interface Detection](https://eips.ethereum.org/EIPS/eip-165)
- [Vyper documentation](https://docs.vyperlang.org/)
