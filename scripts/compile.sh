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
    git reset --hard origin/master
    git clean -fd

    # remove old targets
    rm -r ~/.src/Node/*/target

    # keep repo updated
    git pull
else
	cd ~/.src
    git clone https://github.com/MASQ-Project/Node.git
fi
cp -r ~/.src ~/src

cd ~/src/Node
# Compile MASQNode
cargo build --manifest-path node/Cargo.toml --release --verbose
cp node/target/${RUST_CROSS_TARGET}/release/MASQNode ${BUILD_TARGET_PATH}/
# Compile masq
cargo build --manifest-path masq/Cargo.toml --release --verbose
cp node/target/${RUST_CROSS_TARGET}/release/masq ${BUILD_TARGET_PATH}/
# Compile dns_utility
cargo build --manifest-path dns_utility/Cargo.toml --release --verbose
cp dns_utility/target/${RUST_CROSS_TARGET}/release/dns_utility ${BUILD_TARGET_PATH}/
# Compile port_exposer
cargo build --manifest-path port_exposer/Cargo.toml --release --verbose
cp port_exposer/target/${RUST_CROSS_TARGET}/release/port_exposer ${BUILD_TARGET_PATH}/
# Compile automap
cargo build --manifest-path automap/Cargo.toml --release --verbose
cp automap/target/${RUST_CROSS_TARGET}/release/automap ${BUILD_TARGET_PATH}/
