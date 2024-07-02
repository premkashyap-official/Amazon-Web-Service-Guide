# README: How to Install Node.js in AWS EC2 Instance

This guide provides a step-by-step process to install Node.js in an AWS EC2 instance using NVM.

## Prerequisites
- Connect to the AWS instance using PuTTY or a PEM file.
- Basic understanding of Node.js.

## Steps to Install Node.js in AWS EC2 Instance

### Step 1: Connect to Your EC2 Instance
1. Open PuTTY or your preferred SSH client.
2. Connect to your EC2 instance using the PEM file.

   ```bash
   ssh -i /path/to/your-key.pem ec2-user@your-ec2-ip-address
    ```

### Step 2: Install NVM (Node Version Manager)
1. Update the package index:

   ```bash
   sudo apt update -y
   ```
2. Install NVM using the following curl command:

   ```bash
     curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
   ```
