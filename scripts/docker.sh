#!/bin/bash

# Determine the OS and version
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS=$ID
    VERSION=$VERSION_ID
else
    echo "Cannot determine the OS. Exiting."
    exit 1
fi

# Function to install Docker on Ubuntu
install_docker_ubuntu() {
    echo "Removing old Docker versions..."
    for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
        sudo apt-get remove -y $pkg
    done
    
    echo "Updating package index..."
    sudo apt-get update
    
    echo "Installing required packages..."
    sudo apt-get install -y ca-certificates curl
    
    echo "Adding Docker's GPG key..."
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    echo "Adding Docker repository..."
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
    
    echo "Updating package index..."
    sudo apt-get update
    
    echo "Installing Docker..."
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# Function to install Docker on CentOS
install_docker_centos() {
    echo "Removing old Docker versions..."
    sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    
    echo "Installing required packages..."
    sudo yum install -y yum-utils
    
    echo "Adding Docker repository..."
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    
    echo "Installing Docker..."
    sudo yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    
    echo "Starting and enabling Docker service..."
    sudo systemctl start docker
    sudo systemctl enable docker
}

# Main installation logic
case $OS in
    ubuntu)
        echo "Detected OS: Ubuntu $VERSION"
        install_docker_ubuntu
    ;;
    centos)
        echo "Detected OS: CentOS $VERSION"
        install_docker_centos
    ;;
    *)
        echo "Unsupported OS: $OS. Exiting."
        exit 1
    ;;
esac

echo "Docker installation completed!"