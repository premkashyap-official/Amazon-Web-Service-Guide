#!/bin/bash

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

install_ubuntu() {
    sudo apt update -y
    sudo apt-get install -y gnupg curl
    sudo add-apt-repository ppa:deadsnakes/ppa
    sudo apt install python3.11
    sudo apt install python3.11-venv
}

install_centos() {
    sudo yum update -y
    sudo yum install python3.11
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
