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

# Install MASQ Node
COPY --chown=node:node ./builds/linux-x86-64/* /usr/local/bin/
