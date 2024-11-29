#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install necessary packages using apt (Ubuntu/Debian)
install_ubuntu() {
    echo "Updating package index and installing curl..."
    sudo apt update -y || { echo "Failed to update packages"; exit 1; }
    sudo apt install -y curl || { echo "Failed to install curl"; exit 1; }
}

# Function to install necessary packages using yum (CentOS/RedHat)
install_centos() {
    echo "Updating package index..."
    sudo yum update -y || { echo "Failed to update packages"; exit 1; }
    echo "Installing curl..."
    sudo yum install -y curl || { echo "Failed to install curl"; exit 1; }
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

# Install necessary packages based on the detected distribution
case "$DISTRO" in
    Ubuntu|Debian)
        install_ubuntu
        ;;
    amzn|centos|rhel)
        install_centos
        ;;
    *)
        echo "Unsupported distribution: $DISTRO. Please install packages manually."
        exit 1
        ;;
esac

# Variables
NVM_VERSION="v0.39.1"

# Install nvm
echo "Installing nvm version $NVM_VERSION..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash || { echo "Failed to install nvm"; exit 1; }

# Source .bashrc to load nvm
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    source "$HOME/.zshrc"
else
    echo "Shell configuration file not found. Please source nvm manually."
    exit 1
fi

# Check if nvm is installed
if ! command_exists nvm; then
    echo "nvm is not installed. Please check the installation."
    exit 1
fi

# Install Node.js
if [ $# -eq 0 ]; then
    echo "No Node.js version specified. Installing the latest LTS version..."
    nvm install --lts || { echo "Failed to install Node.js"; exit 1; }
else
    echo "Installing Node.js version $1..."
    nvm install "$1" || { echo "Failed to install Node.js version $1"; exit 1; }
fi

# Set the default Node.js version
DEFAULT_NODE_VERSION=$(nvm current)
nvm alias default "$DEFAULT_NODE_VERSION"

# Display installed Node.js versions
echo "Installed Node.js versions:"
nvm ls

# Display the default Node.js version
echo "Default Node.js version:"
node --version