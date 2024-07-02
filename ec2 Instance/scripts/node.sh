#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install packages using apt (for Ubuntu/Debian)
install_ubuntu() {
    sudo apt update -y
    sudo apt install curl -y
}

# Function to install packages using yum (for CentOS)
install_centos() {
    sudo yum update -y
}

# Detect Linux distribution
if command_exists lsb_release; then
    DISTRO=$(lsb_release -si)
elif [ -e /etc/os-release ]; then
    DISTRO=$(awk -F= '$1 == "ID" {print $2}' /etc/os-release | tr -d '"')
else
    echo "Unsupported Linux distribution. Please install packages manually."
fi

# Install necessary packages based on distribution
case "$DISTRO" in
    Ubuntu)
        install_ubuntu
        ;;
    amzn)
        install_centos
        ;;
    *)
        echo "Unsupported distribution: $DISTRO. Please install packages manually."
        ;;
esac

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Source .bashrc to use nvm
source ~/.bashrc

# Check if nvm is installed
if ! command_exists nvm; then
    echo "nvm is not installed. Please check the installation."
    exit 1
fi

# Check if a node version argument is provided
if [ $# -eq 0 ]; then
    echo "No node version specified. Installing the latest version..."
    # Install the latest LTS version
    nvm install --lts
else
    # Install the specified node version
    nvm install "$1"
fi

# Set the default node version
nvm alias default "$(nvm current)"

# Display installed node versions
echo "Installed node versions:"
nvm ls

# Display default node version
echo "Default node version:"
node --version
