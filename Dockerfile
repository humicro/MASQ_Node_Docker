# *** Build Stage ***
FROM debian:buster AS builder

LABEL maintainer="microoo <hu@microoo.net>"

# Update OS
RUN apt-get update && \
    apt-get -y upgrade

# Install required packages
RUN apt-get install -y sudo build-essential curl git

# Create a sudo user
RUN adduser --disabled-password --gecos '' node && \
    adduser node sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER node
WORKDIR /home/node/

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --output rustup.sh && \
	sh ./rustup.sh -y
ENV PATH="/home/node/.cargo/bin:$PATH"

# Download MASQ Node source
RUN git clone https://github.com/MASQ-Project/Node.git src


# @@@ Build
RUN mkdir build

# Compile to Linux x86-64
RUN mkdir build/linux-x86-64

# Compile MASQNode
RUN cd ~/src/node/ && \
    cargo clean && \
    cargo build --release --verbose && \
    cp ~/src/node/target/release/MASQNode ~/build/linux-x86-64/

# Compile masq
RUN cd ~/src/masq/ && \
    cargo clean && \
    cargo build --release --verbose && \
    cp ~/src/node/target/release/masq ~/build/linux-x86-64/

# Compile dns_utility
RUN cd ~/src/dns_utility/ && \
    cargo clean && \
    cargo build --release --verbose && \
    cp ~/src/dns_utility/target/release/dns_utility ~/build/linux-x86-64/

# Compile port_exposer
RUN cd ~/src/port_exposer/ && \
    cargo clean && \
    cargo build --release --verbose && \
    cp ~/src/port_exposer/target/release/port_exposer ~/build/linux-x86-64/


# *** Serve Stage ***
FROM debian:buster-slim as server

LABEL maintainer="microoo <hu@microoo.net>"

# Update OS
RUN apt-get update && \
    apt-get -y upgrade

# Create a sudo user
RUN apt-get install sudo -y && \
    adduser --disabled-password --gecos '' node && \
    adduser node sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER node
WORKDIR /home/node

# Install MASQ Node
COPY --from=builder --chown=node:node /home/node/build/linux-x86-64/* /usr/local/bin/
