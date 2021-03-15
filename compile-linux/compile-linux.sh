#! /bin/bash

# Update OS
sudo apt-get update
sudo apt-get -y upgrade
# Update Rust
rustup update stable
# Create build directory
BUILD_TARGET_DIR=~/builds/linux-x86-64
mkdir -p $BUILD_TARGET_DIR
rm -r ${BUILD_TARGET_DIR}/*
# Download MASQ Node source
git clone --depth 1 https://github.com/MASQ-Project/Node.git src
# Compile MASQNode
cd ~/src/node
cargo build --release --verbose
cp ~/src/node/target/release/MASQNode ${BUILD_TARGET_DIR}/
# Compile masq
cd ~/src/masq
cargo build --release --verbose
cp ~/src/node/target/release/masq ${BUILD_TARGET_DIR}/
# Compile dns_utility
cd ~/src/dns_utility
cargo build --release --verbose
cp ~/src/dns_utility/target/release/dns_utility ${BUILD_TARGET_DIR}/
# Compile port_exposer
cd ~/src/port_exposer
cargo build --release --verbose
cp ~/src/port_exposer/target/release/port_exposer ${BUILD_TARGET_DIR}/
# Compile automap
cd ~/src/automap
cargo build --release --verbose
cp ~/src/automap/target/release/automap ${BUILD_TARGET_DIR}/
