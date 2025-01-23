#!/bin/bash

# Exit script on error
set -e

echo ">> Installing WebAssembly target for Rust..."
rustup target add wasm32-unknown-unknown

echo ">> Installing useful WebAssembly tools..."
cargo install wasm-pack cargo-generate

echo ">> Verifying WebAssembly tools installation..."
wasm-pack --version
cargo-generate --version

echo ">> WebAssembly setup completed successfully!"
