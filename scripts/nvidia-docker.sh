#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Docker and NVIDIA Docker on Ubuntu/Debian
install_ubuntu() {
    echo "Installing Docker and NVIDIA Docker on Ubuntu/Debian..."
    sudo apt-get update -y
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Add Docker's GPG key and repository
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    
    sudo apt-get update -y
    sudo apt-get install -y docker-ce gnupg
    
    # Set up NVIDIA Docker repository
    sudo mkdir -p /etc/systemd/system/docker.service.d
    curl -fsSL https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    distribution=$(lsb_release -cs)
    curl -fsSL https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

    sudo apt-get update -y
    sudo apt-get install -y nvidia-docker2
    
    # Restart Docker
    sudo systemctl restart docker

    # Verify installation
    docker --version
    dpkg -l | grep nvidia-docker
    sudo docker info | grep "Runtimes"
}

# Function to install Docker and NVIDIA Docker on CentOS/RedHat
install_centos() {
    echo "Installing Docker and NVIDIA Docker on CentOS/RedHat..."
    sudo yum update -y
    sudo yum install -y yum-utils

    # Add Docker's repository
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io

    # Set up NVIDIA Docker repository
    distribution="rhel8"
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo

    sudo yum install -y nvidia-docker2

    # Start and enable Docker
    sudo systemctl start docker
    sudo systemctl enable docker

    # Verify installation
    docker --version
    rpm -qa | grep nvidia-docker
    sudo docker info | grep "Runtimes"
}

# Detect Linux distribution
if command_exists lsb_release; then
    DISTRO=$(lsb_release -si)
elif [ -e /etc/os-release ]; then
    DISTRO=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release | tr -d '"')
else
    echo "Unsupported Linux distribution. Please install packages manually."
    exit 1
fi

# Install based on the detected distribution
case "$DISTRO" in
    Ubuntu|Debian)
        install_ubuntu
        ;;
    centos|rhel|amzn)
        install_centos
        ;;
    *)
        echo "Unsupported distribution: $DISTRO. Please install packages manually."
        exit 1
        ;;
esac