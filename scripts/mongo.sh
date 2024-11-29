#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Default MongoDB version
MONGO_VERSION=${1:-"7.0"}

# Function to install MongoDB on Ubuntu
install_ubuntu() {
    echo "Installing MongoDB $MONGO_VERSION on Ubuntu..."
    sudo apt update -y
    sudo apt-get install -y gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-${MONGO_VERSION}.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-${MONGO_VERSION}.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/${MONGO_VERSION} multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-${MONGO_VERSION}.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    if ! sudo systemctl start mongod; then
        echo "Failed to start MongoDB service."
        exit 1
    fi
    echo "MongoDB $MONGO_VERSION installed and started successfully on Ubuntu."
}

# Function to install MongoDB on CentOS
install_centos() {
    echo "Installing MongoDB $MONGO_VERSION on CentOS..."
    sudo yum update -y
    echo -e "[mongodb-org-${MONGO_VERSION}]\nname=MongoDB Repository\nbaseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/${MONGO_VERSION}/x86_64/\ngpgcheck=1\nenabled=1\ngpgkey=https://pgp.mongodb.com/server-${MONGO_VERSION}.asc" | sudo tee /etc/yum.repos.d/mongodb-org-${MONGO_VERSION}.repo > /dev/null
    sudo yum install -y mongodb-org
    if ! sudo systemctl start mongod; then
        echo "Failed to start MongoDB service."
        exit 1
    fi
    echo "MongoDB $MONGO_VERSION installed and started successfully on CentOS."
}

# Detect the distribution
if command_exists lsb_release; then
    DISTRO=$(lsb_release -si)
    elif [ -e /etc/os-release ]; then
    DISTRO=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release | tr -d '"')
else
    echo "Unsupported Linux distribution. Please install packages manually."
    exit 1
fi

# Installation based on the distribution
case "$DISTRO" in
    Ubuntu)
        install_ubuntu
    ;;
    amzn)
        install_centos
    ;;
    *)
        echo "Unsupported distribution: $DISTRO. Please install packages manually."
        exit 1
    ;;
esac