# Update OS
sudo apt-get update
sudo apt-get -y upgrade
# Update Rust
rustup update stable
# Create build directory
mkdir -p ~/builds/linux-x86-64
rm -r ~/builds/linux-x86-64/*
# Download MASQ Node source
git clone --depth 1 https://github.com/MASQ-Project/Node.git src
# Compile MASQNode
cd ~/src/node
cargo build --release --verbose
cp ~/src/node/target/release/MASQNode ~/builds/linux-x86-64/
# Compile masq
cd ~/src/masq
cargo build --release --verbose
cp ~/src/node/target/release/masq ~/builds/linux-x86-64/
# Compile dns_utility
cd ~/src/dns_utility
cargo build --release --verbose
cp ~/src/dns_utility/target/release/dns_utility ~/builds/linux-x86-64/
# Compile port_exposer
cd ~/src/port_exposer
cargo build --release --verbose
cp ~/src/port_exposer/target/release/port_exposer ~/builds/linux-x86-64/
