#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install Python on Ubuntu/Debian
install_ubuntu() {
    echo "Installing Python $PYTHON_VERSION on Ubuntu..."
    sudo apt update -y
    sudo apt-get install -y gnupg curl
    
    # Add deadsnakes PPA repository for newer Python versions
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update -y

    # Install the specified Python version
    sudo apt install -y python$PYTHON_VERSION
    sudo apt install -y python$PYTHON_VERSION-venv
}

# Function to install Python on CentOS/RedHat
install_centos() {
    echo "Installing Python $PYTHON_VERSION on CentOS/RedHat..."
    sudo yum update -y
    sudo yum install -y "python$PYTHON_VERSION"
}

# Default Python version (if not specified)
PYTHON_VERSION=${1:-"3.11"}

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

# Confirm the installation of Python
echo "Python $PYTHON_VERSION installed successfully."
python$PYTHON_VERSION --version