#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_ubuntu() {
    sudo apt update -y
    sudo apt-get install -y gnupg curl
    curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg --dearmor
    echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list
    sudo apt-get update
    sudo apt-get install -y mongodb-org
    if ! sudo systemctl start mongod; then
        echo "Failed to start MongoDB service."
    fi
}

install_centos() {
    sudo yum update -y
    echo "[mongodb-org-7.0] name=MongoDB Repository baseurl=https://repo.mongodb.org/yum/amazon/2023/mongodb-org/7.0/x86_64/ gpgcheck=1 enabled=1 gpgkey=https://pgp.mongodb.com/server-7.0.asc" | sudo tee /etc/yum.repos.d/mongodb-org-7.0.repo > /dev/null
    sudo yum install -y mongodb-org
    if ! sudo systemctl start mongod; then
        echo "Failed to start MongoDB service."
    fi
}

if command_exists lsb_release; then
    DISTRO=$(lsb_release -si)
elif [ -e /etc/os-release ]; then
    DISTRO=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release | tr -d '"')
else
    echo "Unsupported Linux distribution. Please install packages manually."
    exit 1
fi

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
