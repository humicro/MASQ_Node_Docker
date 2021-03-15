# *** "MASQ-Compile-Linux" Docker Image for MASQ Node ***
FROM debian:buster

LABEL maintainer="microoo <hu@microoo.net>"

# Update OS; Install required packages; Create a sudo user
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y sudo build-essential curl git && \
    adduser --disabled-password --gecos '' node && \
    adduser node sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
USER node
WORKDIR /home/node

# Install Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --output rustup.sh && \
	sh ./rustup.sh -y && \
    rm ./rustup.sh
ENV PATH="/home/node/.cargo/bin:$PATH"

## Run compilation script
CMD [ "bash", "-c", "chmod +x ./compile.sh && ./compile.sh" ]
