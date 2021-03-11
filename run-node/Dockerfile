# *** "MASQ-Run-Node" Docker Image for MASQ Node ***
FROM debian:buster-slim

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

# Config Node Helper
RUN sudo apt-get install -y python3 python3-pip && \
    sudo pip3 install requests tomlkit
