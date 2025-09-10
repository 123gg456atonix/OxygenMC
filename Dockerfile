# By 123gg456_ . Don't use this without giving me a credit. Please respect me and my work.
FROM ubuntu:latest

# Set environment variables for user and home directory
ENV USER=container
ENV HOME=/home/container

# Set the working directory
WORKDIR /home/container

# Copy the entrypoint script to the container
COPY ./entrypoint.sh /oxygenmc.sh

# Update and install required packages
RUN apt update -y && \
    apt upgrade -y && \
    apt install -y \
        curl \
        zip \
        unzip \
        jq \
        coreutils \
        software-properties-common \
        toilet && \
    adduser --disabled-password --home /home/container container

# Switch to non-root user
USER container

# Set the entrypoint
CMD ["/bin/bash", "/oxygenmc.sh"]