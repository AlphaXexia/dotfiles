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

# Install BlackArch Repositories on Arch Linux
read -p "Do you want to install BlackArch tools? y/n " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # Install Strap Script
    curl -O https://blackarch.org/strap.sh
    
    # Change Script Permissions
    chmod +x strap.sh
    
    # Run Strap Script
    sudo ./strap.sh
    
    # Add BlackArch keyring
    sudo pacman -S blackarch-keyring
    
    # Update Package List
    sudo pacman -Syyu
    
    # Prompt to Install Packages
    while true; do
        read -p "Do you want to install BlackArch packages? y/n " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo -e "\nSelect a package to install:"
            echo -e "\n I am only showing the most common packages"
            echo "1. blackarch-webapp (size: $(pacman -Si blackarch-webapp | grep 'Installed Size' | awk '{print $4}'))"
            echo "2. blackarch-spoof (size: $(pacman -Si blackarch-spoof | grep 'Installed Size' | awk '{print $4}'))"
            echo "3. blackarch-recon (size: $(pacman -Si blackarch-recon | grep 'Installed Size' | awk '{print $4}'))"
            echo "4. blackarch-pentesting (size: $(pacman -Si blackarch-pentesting | grep 'Installed Size' | awk '{print $4}'))"
            echo "5. blackarch-networking (size: $(pacman -Si blackarch-networking | grep 'Installed Size' | awk '{print $4}'))"
            echo "6. blackarch-malware (size: $(pacman -Si blackarch-malware | grep 'Installed Size' | awk '{print $4}'))"
            echo "7. blackarch-exploitation (size: $(pacman -Si blackarch-exploitation | grep 'Installed Size' | awk '{print $4}'))"
            echo "8. blackarch-database (size: $(pacman -Si blackarch-database | grep 'Installed Size' | awk '{print $4}'))"
            echo "9. blackarch-cryptography (size: $(pacman -Si blackarch-cryptography | grep 'Installed Size' | awk '{print $4}'))"
            echo "0. Quit"
            read -p "Enter your choice: " choice
            
            case $choice in
                1) sudo pacman -S blackarch-webapp;;
                2) sudo pacman -S blackarch-spoof;;
                3) sudo pacman -S blackarch-recon;;
                4) sudo pacman -S blackarch-pentesting;;
                5) sudo pacman -S blackarch-networking;;
                6) sudo pacman -S blackarch-malware;;
                7) sudo pacman -S blackarch-exploitation;;
                8) sudo pacman -S blackarch-database;;
                9) sudo pacman -S blackarch-cryptography;;
                0) break;;
                *) echo "Invalid option";;
           esac
        else
            break
        fi
    done
    
    echo "BlackArch packages installation complete."
fi

# Download SecLists
read -p "Do you want to download SecLists Wordlist? y/n " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Downloading SecLists${NC}"
    sudo wget -c https://github.com/danielmiessler/SecLists/archive/master.zip -O /usr/share/wordlists/SecList.zip
fi

# Check if Vim is installed
if ! command -v vim &> /dev/null
then
    read -p "Vim is not installed. Do you want to install it now? y/n " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "Installing Vim..."
        sudo pacman -S vim
    else
        echo "Vim is required for this script. Exiting..."
        exit 1
    fi
fi

# Install custom .vimrc
read -p "Do you want to use the custom .vimrc file? y/n " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${RED}[*] Setting up .vimrc${NC}"
    echo "set number" >> ~/.vimrc
    echo "syntax on" >> ~/.vimrc
    echo "Done."
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
# Check if distribution is Manjaro or any other Arch-based distro
if [[ $(lsb_release -is) == "ManjaroLinux" ]]
then
    # Install RustScan for Manjaro
    read -p "Do you want to install RustScan? y/n " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "${RED}[*] Installing RustScan${NC}"
        yay -S rustscan
    fi
else
    # Install RustScan for other Arch-based distros
    read -p "Do you want to install RustScan? y/n " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo -e "${RED}[*] Installing RustScan${NC}"
        wget https://github.com/RustScan/RustScan/releases/download/2.0.0/rustscan_2.0.0_amd64.deb -O rustscan.deb
        sudo dpkg -i rustscan.deb
        rm rustscan.deb
    fi
fi

echo -e "${RED}[*] ALL DONE, HAPPY HACKING!${NC}"
    
# Update Package List
sudo pacman -Syyu