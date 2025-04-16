#!/bin/bash
# Must be run with sudo -E
# Docker instalation Ubuntu 22.04 wsl 2
# Might work on other debian based systems

# 1. System update
sudo apt update
sudo apt upgrade -y

# 2. Dependencies
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# 3. GPG docker key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# 4. Add docker repo to system
echo "deb [signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. Install
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Add user to docker grp 
# Warning : IF NOT RUN WITH sudo -E THIS WONT WORK
sudo usermod -aG docker $USER
