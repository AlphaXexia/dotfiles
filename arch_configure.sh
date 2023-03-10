#!/bin/bash

# Output color variables
RED='\033[0;31m'
NC='\033[0m'

echo -e "${RED}[*] Arch-based OS Customization Script${NC}"

# Update Repositories
echo -e "${RED}[*] Updating repo list${NC}"
sudo pacman -Syyu

# Remove unwanted packages
echo -e "${RED}[*] Removing unwanted packages${NC}"
sudo pacman -R neovim

# Installing Essentials
echo -e "${RED}[*] Installing Essentials${NC}"
sudo pacman -S vim wget git curl htop tmux zsh python-pip dotdotpwn openvpn keepassxc plank exploitdb

# Install Chromium
read -p "Do you want to install chromium browser? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing Chromium${NC}"
    sudo pacman -S chromium
fi

# Install Tilix
read -p "Do you want to install Tilix? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing Tilix${NC}"
    sudo pacman -S tilix
    read -p "Do you want to set Tilix as your default terminal? y/n " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "${RED}[*] Setting Tilix as Default Terminal${NC}"
        sudo update-alternatives --config x-terminal-emulator
    fi
fi

# Install Docker
read -p "Do you want to install Docker? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing Docker${NC}"
    sudo pacman -S docker
    sudo systemctl enable docker
    sudo systemctl start docker
fi

# Install Kali Default Programs
read -p "Do you want to install Kali Default Programs? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing Kali Default Programs${NC}"
    sudo pacman -S kali-linux-default
fi

# Install Kali Web Tools
read -p "Do you want to install Kali Web Tools y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing Kali Web Tools${NC}"
    sudo pacman -S kali-tools-web
fi

# Download SecLists
read -p "Do you want to download SecLists Wordlist? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Downloading SecLists${NC}"
    sudo wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O /usr/share/wordlists/SecList.zip
fi

# Custom .vimrc
read -p "Do you want to use the custom .vimrc file? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Setting up .vimrc${NC}"
    echo "set number" >> ~/.vimrc
    echo "syntax on" >> ~/.vimrc
fi

# Installing oh-my-zsh
read -p "Do you want to install oh-my-zsh? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing oh-my-zsh${NC}"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Custom .zshrc
read -p "Do you want to use the custom .zshrc file? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Setting up .zshrc${NC}"
    rm ~/.zshrc
    wget https://raw.githubusercontent.com/AlexisAhmed/BugBountyToolkit-ZSH/main/.zshrc -O ${HOME}/.zshrc
fi

# Install Python Libraries
read -p "Do you want to install Python Libraries? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Installing Python Libraries${NC}"
    pip3 install requests pwntools
fi

# Install RustScan
read -p "Do you want to install RustScan? y/n " -n 