# *** Build Stage ***
FROM rust:latest AS builder

# Update OS
RUN apt-get update && \
    apt-get -y upgrade

# Download MASQ Node source
RUN git clone https://github.com/MASQ-Project/Node.git src

# Compile MASQNode
RUN cd /src/node/ && \
    cargo build --release --verbose
RUN mkdir /build && \
    cp /src/node/target/release/MASQNode \
       /src/node/target/release/MASQNodeW /build/

# Compile masq
RUN cd /src/masq/ && \
    cargo build --release --verbose && \
    cp /src/node/target/release/masq /build/

# Compile dns_utility
RUN cd /src/dns_utility/ && \
    cargo build --release --verbose && \
    cp /src/dns_utility/target/release/dns_utility \
       /src/dns_utility/target/release/dns_utilityw /build/

# Compile port_exposer
RUN cd /src/port_exposer/ && \
    cargo build --release --verbose && \
    cp /src/port_exposer/target/release/port_exposer /build/


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
COPY --from=builder --chown=node:node /build/* /usr/local/bin/
