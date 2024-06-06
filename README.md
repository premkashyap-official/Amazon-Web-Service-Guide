# README: How to Create an AWS EC2 Instance

This guide provides a step-by-step process to create an AWS EC2 instance, covering everything from naming your instance to configuring its details.

## Prerequisites
- AWS Account
- Basic understanding of AWS services

## Steps to Create an AWS EC2 Instance

### Step 1: Create a Unique Name for the Instance
1. **Log in to your AWS Management Console.**
2. **Navigate to the EC2 Dashboard.**
3. **Click on "Launch Instance".**
4. **Enter a unique name for your instance in the "Name and tags" section.**

### Step 2: Select AMI (Amazon Machine Image) Type
1. **Select an Amazon Machine Image (AMI):**
   - **Navigate to the AMI selection screen.**
   - **Choose an AMI based on your requirements.** Examples include Amazon Linux, Ubuntu, Windows, etc.
   - **Refer to the [Amazon OS Types documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/operating-systems-and-machine-types.html#prereqs-operating-systems) for more details.**

### Step 3: Select the OS Version and Architecture Type Suitable for the Application
1. **Choose the appropriate OS version.** Ensure the version you choose is compatible with your application requirements.
2. **Select the architecture type.** Typically, you can choose between x86 (32-bit) and x86_64 (64-bit) architectures.

### Step 4: Select the Instance Type
1. **Choose an instance type based on your application’s needs.** The instance type determines the hardware of the host computer used for your instance. Each instance type offers different compute, memory, and storage capabilities.
   - **For general purpose workloads**, you might choose t2.micro or t3.micro (both are eligible for the free tier).
   - **For compute-intensive applications**, consider c5.large or c5.xlarge.
   - **For memory-intensive applications**, choose r5.large or r5.xlarge.
2. **Review the instance type details** to ensure it matches your performance requirements.
3. **Refer to the [Amazon Instance Types Documentation](https://aws.amazon.com/ec2/instance-types/) for more instance types details.**

### Step 5: Create a Key Pair
1. **Create a key pair to access the instance**
   When creating an instance on AWS, you'll need to create or select a key pair for SSH access. Follow these steps:
   - **Option 1:** Create a new key pair during instance creation
     - Provide a name for the key pair and select the file format (Types : PEM, PPK, RDP).
     - The private key file will be automatically downloaded to your computer. Store it securely.

   - **Option 2:** Use an existing key pair
     - If you already have a key pair created on AWS, select "Choose an existing key pair".
     - Select the key pair you want to use from the dropdown list.
   **IMPORTANT**
     * Ensure you have the private key file stored securely. Without the file it is not possible to access the instance.
     * You'll need the public key associated with this key pair to configure access to your instance.

### Step 6: Configure Instance Details
1. **Click "Next: Configure Instance Details".**
2. **Configure network settings** as needed. This includes choosing the VPC, subnet, auto-assign Public IP, etc. No need to change these options unless needed.
3. **Add storage** if needed. By default, an EBS (Elastic Block Store) volume is attached. You can change the storage based on the application need.
   - Click on "Add New Volume" or "Advanced" to access more options.
   - Here, you can adjust the size and type of the volume according to your requirements.
   - If encryption is needed:
     - Click on the volume you've added to configure it.
     - Under "Encryption," select the checkbox to enable encryption.
     - Choose either AWS managed keys (AWS Managed CMK) or customer managed keys (Customer Managed CMK) for encryption.
     - If using customer managed keys, ensure the key is created and accessible.
4. **Add tags** to help organize and manage your instances.
5. **Configure security groups** to control the inbound and outbound traffic to your instance.
   - **Option 1:** Create a new security group
     - Under "Security groups," select "Create a new security group."
     - Provide a name and description for the security group.
    - Add inbound rules to allow specific types of traffic:
       - For SSH access (Linux), add a rule with source "My IP" for secure connection.
       - You can also add HTTP and HTTPS rules with source "Anywhere" for web traffic.
       - For RDP access (Windows), add a rule with source "My IP" if needed.
       - Customize additional rules based on your requirements.
     - Add outbound rules as needed.
     - Click "Create security group" to finalize.

   - **Option 2:** Use an existing security group
     - If you already have a security group created on AWS, select "Choose an existing security group" during instance creation.
     - Select the security group you want to use from the dropdown list.
     - Ensure the selected security group has appropriate inbound rules configured to allow the necessary traffic.
     - Click "Review and Launch" to proceed with the selected security group.

### Step 7: Review and Launch
1. **Review all your settings.**
2. **Click "Launch".**
3. **Acknowledge the key pair warning** and click "Launch Instances".

### Step 7: Access Your Instance
1. **Navigate to the Instances section** in the EC2 Dashboard.
2. **Select your newly launched instance**.
3. **Copy the Public IP address** of your instance.
4. **SSH into your instance** using the key pair: in local system
   - **For Linux/Ubuntu:**
      - **Using OpenSSH:**
        ```bash
        ssh -i "path/to/your-key-pair.pem" ec2-user@your-public-ip
        ```
        Replace `"path/to/your-key-pair.pem"` with the path to your private key file and `your-public-ip` with the public IP address or hostname of your EC2 instance.
      - Alternatively, you can use the "Connect" button in the AWS Management Console to copy the SSH command directly.
   - **For Windows:**
     - Using SSH:
       - Use an SSH client like PuTTY, convert the .pem file to .ppk using PuTTYgen, and then connect using PuTTY.
     - Using RDP:
       - Ensure that you have enabled RDP in the security group settings.
       - Use the Remote Desktop Connection application to connect to your instance.
       - Enter the Public IP address of your instance and connect.

## Additional Resources
- [AWS EC2 Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)
- [Amazon OS Types Documentation](https://docs.aws.amazon.com/systems-manager/latest/userguide/operating-systems-and-machine-types.html#prereqs-operating-systems)

By following these steps, you will have a running instance tailored to your specific requirements. If you encounter any issues or need more detailed guidance, refer to the provided documentation links.
