#!/bin/bash

# Update package lists
sudo apt update -y

# Install curl if not already installed
sudo apt install curl -y

# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# Source .bashrc to use nvm
source ~/.bashrc

# Check if nvm is installed
if ! command -v nvm &> /dev/null; then
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
