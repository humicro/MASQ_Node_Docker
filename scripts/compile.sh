#! /bin/bash

# Update OS
sudo apt-get update
sudo apt-get -y upgrade
# Update Rust
rustup update stable
# Create build directory
BUILD_TARGET_PATH=~/builds/${BUILD_DIR}
mkdir -p $BUILD_TARGET_PATH
rm -r ${BUILD_TARGET_PATH}/*
# Download MASQ Node source
if [ -d ~/.src/Node ]; then
	cd ~/.src/Node
    
    # discrad any local change
    git clean -fd
    git reset --hard origin/master

    # keep repo updated
    git pull
else
	cd ~/.src
    git clone https://github.com/MASQ-Project/Node.git
fi
cp -r ~/.src ~/src
# Compile MASQNode
cd ~/src/Node/node
cargo build --release --verbose
cp ~/src/Node/node/target/${RUST_CROSS_TARGET}/release/MASQNode ${BUILD_TARGET_PATH}/
# Compile masq
cd ~/src/Node/masq
cargo build --release --verbose
cp ~/src/Node/node/target/${RUST_CROSS_TARGET}/release/masq ${BUILD_TARGET_PATH}/
# Compile dns_utility
cd ~/src/Node/dns_utility
cargo build --release --verbose
cp ~/src/Node/dns_utility/target/${RUST_CROSS_TARGET}/release/dns_utility ${BUILD_TARGET_PATH}/
# Compile port_exposer
cd ~/src/Node/port_exposer
cargo build --release --verbose
cp ~/src/Node/port_exposer/target/${RUST_CROSS_TARGET}/release/port_exposer ${BUILD_TARGET_PATH}/
# Compile automap
cd ~/src/Node/automap
cargo build --release --verbose
cp ~/src/Node/automap/target/${RUST_CROSS_TARGET}/release/automap ${BUILD_TARGET_PATH}/
