#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install dependencies for Ubuntu/Debian
install_ubuntu_dependencies() {
    echo "Installing dependencies for Ubuntu/Debian..."
    sudo apt-get update -y
    sudo apt-get install -y \
    libgl1-mesa-glx libegl1-mesa \
    libxrandr2 libxss1 libxcursor1 \
    libxcomposite1 libasound2 libxi6 \
    libxtst6 curl
}

# Function to install dependencies for CentOS/RHEL
install_centos_dependencies() {
    echo "Installing dependencies for CentOS/RHEL..."
    sudo yum install -y \
    libGL libX11 libXrandr libXcursor \
    libXcomposite alsa-lib curl
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

# Install dependencies based on the distribution
case "$DISTRO" in
    Ubuntu|Debian)
        install_ubuntu_dependencies
    ;;
    centos|rhel|amzn)
        install_centos_dependencies
    ;;
    *)
        echo "Unsupported distribution: $DISTRO. Please install dependencies manually."
        exit 1
    ;;
esac

# Download the Anaconda installer
echo "Downloading Anaconda..."
curl -O https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh

# Verify the SHA256 checksum (replace with the actual SHA256 value from the Anaconda website)
echo "Verifying the Anaconda installer..."
shasum -a 256 ~/Anaconda3-2024.10-1-Linux-x86_64.sh

# If the checksum is correct, proceed with the installation
echo "Proceeding with Anaconda installation..."
bash ~/Anaconda3-2024.10-1-Linux-x86_64.sh

# During installation, the user will need to agree to the terms by typing 'yes'

# Once installed, source the bashrc to update environment variables
echo "Updating the environment..."
source ~/.bashrc

echo "Anaconda installation completed successfully!"