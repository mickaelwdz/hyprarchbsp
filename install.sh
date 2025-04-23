#!/bin/bash

setfont cyr-sun16
clear

echo """
 _   _                   ___           _    ______            
| | | |                 / _ \         | |   | ___ \           
| |_| |_   _ _ __  _ __/ /_\ \_ __ ___| |__ | |_/ / ___ _ __  
|  _  | | | | '_ \| '__|  _  | '__/ __| '_ \| ___ \/ __| '_ \ 
| | | | |_| | |_) | |  | | | | | | (__| | | | |_/ /\__ \ |_) |
\_| |_/\__, | .__/|_|  \_| |_/_|  \___|_| |_\____/ |___/ .__/ 
        __/ | |                                        | |    
       |___/|_|                                        |_|   
"""
echo
echo "Starting pre-install..." && sleep 2

##==> Installing basic dependencies for pacman
#######################################################
dependencies=(python python-pip)
for package in "${dependencies[@]}"; do
    if ! pacman -Q $package &> /dev/null; then
        sudo pacman -S --needed $package
    fi
done
#######################################################


##==> Installing python and dependencies for it
#######################################################
declare -a packages=(
	"inquirer"
	"loguru"
	"psutil"
	"gputil"
	"pyamdgpuinfo"
	"pyyaml"
	"pillow"
	"colorama"
)

for package in "${packages[@]}"; do
    if ! pip show $package &> /dev/null; then
        pip install $package --break-system-packages
    fi
done
#######################################################


##==> Building the system
#######################################################
python Builder/install.py
