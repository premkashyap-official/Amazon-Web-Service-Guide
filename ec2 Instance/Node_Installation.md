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
3. Close and reopen your terminal or source the NVM script:
   ```bash
   source ~/.bashrc
   ```
4. Verify that NVM is installed:
   ```bash
   command -v nvm
   ```
5. Install a specific version of Node.js (e.g., version 14.17.0):
   ```bash
   nvm install 14.17.0
   ```
   If you need to check other versions, visit [Node.js Previous Releases](https://nodejs.org/en/about/previous-releases).
6. Set the default Node.js version to the installed version:
   ```bash
   nvm alias default 14.17.0
   ```
7. Switch Node.js Version with NVM
   ```bash
   nvm ls
   ```
8. Choose a version from installed nodejs versions and use this command:
   ```bash
   nvm use xx.xx.x
   ```
   here xx.xx.x is version of node.
**NOTE : You need to install the node version that you want to use before switching.**
