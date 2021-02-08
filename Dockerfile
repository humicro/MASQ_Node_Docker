FROM ubuntu:20.04

LABEL maintainer="microoo <hu@microoo.net>"

# Update OS
RUN apt-get update && \
    apt-get -y upgrade

# Install required packages
RUN apt-get install -y sudo build-essential curl git libssl-dev

# Create a sudo user
RUN adduser --disabled-password --gecos '' node
RUN adduser node sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER node
WORKDIR /home/node/

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --output rustup.sh && \
	sh ./rustup.sh -y
ENV PATH="/home/node/.cargo/bin:$PATH"

# Download MASQ Node source code & compile
RUN git clone --depth 1 https://github.com/MASQ-Project/Node.git src && \
    cd ~/src/node/ && cargo build --release --verbose && \
    cd ~/src/masq/ && cargo build --release --verbose && \
    cd ~/src/dns_utility/ && cargo build --release --verbose && \
    cd ~/src/port_exposer/ && cargo build --release --verbose

# Collect compiled binaries to ~/bin/
RUN mkdir ~/bin/ && \
    cp ~/src/node/target/release/MASQNode ~/bin/ && \
    cp ~/src/node/target/release/MASQNodeW ~/bin/ && \
    cp ~/src/node/target/release/masq ~/bin/ && \
    cp ~/src/dns_utility/target/release/dns_utility ~/bin/ && \
    cp ~/src/dns_utility/target/release/dns_utilityw ~/bin/ && \
    cp ~/src/port_exposer/target/release/port_exposer ~/bin/
