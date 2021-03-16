#! /bin/bash

# Update OS
sudo apt-get update
sudo apt-get -y upgrade
# Update Rust
rustup update
# Create build directory
BUILD_TARGET_PATH=~/builds/${BUILD_DIR}/${TARGET_ARCHITECTURE}
mkdir -p $BUILD_TARGET_PATH
rm -r ${BUILD_TARGET_PATH}/*
# Download MASQ Node source
if [ -d /src/Node ]; then
    cd /src/Node
    
    # discrad any local change
    git reset --hard origin/master
    git clean -fd

    # remove old targets
    rm -r /src/Node/*/target

    # keep repo updated
    git pull
else
	cd /src
    git clone https://github.com/MASQ-Project/Node.git
fi

# Set Docker Permission
sudo chmod 666 /var/run/docker.sock

cd /src/Node
if [ $ENABLE_TEST ]; then
    CROSS_MODE=test
else
	CROSS_MODE=build
fi
# Compile MASQNode
cross $CROSS_MODE --manifest-path node/Cargo.toml --target $TARGET_ARCHITECTURE --release
cp node/target/${TARGET_ARCHITECTURE}/release/MASQNode ${BUILD_TARGET_PATH}/
# Compile masq
cross $CROSS_MODE --manifest-path masq/Cargo.toml --target $TARGET_ARCHITECTURE --release
cp masq/target/${TARGET_ARCHITECTURE}/release/masq ${BUILD_TARGET_PATH}/
# Compile dns_utility
cross $CROSS_MODE --manifest-path dns_utility/Cargo.toml --target $TARGET_ARCHITECTURE --release
cp dns_utility/target/${TARGET_ARCHITECTURE}/release/dns_utility ${BUILD_TARGET_PATH}/
# Compile port_exposer
cross $CROSS_MODE --manifest-path port_exposer/Cargo.toml --target $TARGET_ARCHITECTURE --release
cp port_exposer/target/${TARGET_ARCHITECTURE}/release/port_exposer ${BUILD_TARGET_PATH}/
# Compile automap
cross $CROSS_MODE --manifest-path automap/Cargo.toml --target $TARGET_ARCHITECTURE --release
cp automap/target/${TARGET_ARCHITECTURE}/release/automap ${BUILD_TARGET_PATH}/

# Set Docker Permission to default
sudo chmod 660 /var/run/docker.sock
