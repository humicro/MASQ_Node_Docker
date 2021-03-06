# Update OS
sudo apt-get update
sudo apt-get -y upgrade
# Update Rust
rustup update stable
# Create build directory
mkdir -p ~/builds/rpi-arm6
rm -r ~/builds/rpi-arm6/*
# Download MASQ Node source
git clone --depth 1 https://github.com/MASQ-Project/Node.git src
# Compile MASQNode
cd ~/src/node
cargo build --release --verbose
cp ~/src/node/target/arm-unknown-linux-gnueabihf/release/MASQNode ~/builds/rpi-arm6/
# Compile masq
cd ~/src/masq
cargo build --release --verbose
cp ~/src/node/target/arm-unknown-linux-gnueabihf/release/masq ~/builds/rpi-arm6/
# Compile dns_utility
cd ~/src/dns_utility
cargo build --release --verbose
cp ~/src/dns_utility/target/arm-unknown-linux-gnueabihf/release/dns_utility ~/builds/rpi-arm6/
# Compile port_exposer
cd ~/src/port_exposer
cargo build --release --verbose
cp ~/src/port_exposer/target/arm-unknown-linux-gnueabihf/release/port_exposer ~/builds/rpi-arm6/
