# *** "MASQ-Compile-Cross" Docker Image for MASQ Node ***
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
# RUN sudo mkdir -m777 /opt/rust /opt/cargo
# ENV RUSTUP_HOME=/opt/rust CARGO_HOME=/opt/cargo PATH=/opt/cargo/bin:$PATH
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs --output rustup.sh && \
	sh ./rustup.sh -y && \
    rm ./rustup.sh
ENV PATH="/home/node/.cargo/bin:$PATH"

# Setup Docker
RUN sudo apt-get install -y apt-transport-https lsb-release && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
    sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \
    sudo apt-get update && \
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Setup Cross
# RUN cargo install cross
# RUN rustup default nightly
RUN git clone -b patch https://github.com/humicro/cross.git && \
    cd cross && cargo build --release && \
    sudo cp ~/cross/target/release/cross /usr/local/bin/ && \
    rm -r ~/cross
ENV CROSS_DOCKER_IN_DOCKER=true

## Run compilation script
CMD [ "bash", "-c", "chmod +x ~/compile-cross.sh && ~/compile-cross.sh" ]
