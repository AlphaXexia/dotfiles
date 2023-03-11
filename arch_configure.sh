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

#!/bin/bash

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
    
    # Display Software Categories
    sudo pacman -Sg | grep blackarch
    
    # Add BlackArch keyring
    sudo pacman -S blackarch-keyring
    
    # Update Package List
    sudo pacman -Syyu
    
    # Prompt to Install Packages
    while true; do
        read -p "Do you want to install BlackArch packages? y/n " -n 1 -r
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            while true; do
                echo -e "\nSelect a package to install:"
                echo "1. blackarch-webapp"
                echo "2. blackarch-spoof"
                echo "3. blackarch-recon"
                echo "4. blackarch-pentesting"
                echo "5. blackarch-networking"
                echo "6. blackarch-malware"
                echo "7. blackarch-exploitation"
                echo "8. blackarch-database"
                echo "9. blackarch-cryptography"
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
                    0) exit;;
                    *) echo "Invalid option";;
                esac

                read -p "Do you want to install another BlackArch package? y/n " -n 1 -r
                if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                    break
                fi
            done
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