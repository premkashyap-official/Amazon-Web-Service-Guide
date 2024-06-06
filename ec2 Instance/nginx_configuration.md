# Nginx Setup Guide

This guide provides step-by-step instructions to set up Nginx, a powerful web server, on a Linux system.

## Prerequisites

- A Linux-based server (e.g., Ubuntu, CentOS)
- Access to the server with sudo privileges
**IMPORTANT : This guide is created based on Ubuntu type of instace. So the commands contain `apt` which is an ubuntu commad. For Linux use `yum` and replace in the place of `apt`.**

## Step 1: Update System Packages

Before installing Nginx, update the system's package index:

```bash
sudo apt update

