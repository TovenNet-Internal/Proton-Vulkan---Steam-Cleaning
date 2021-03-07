#!/bin/bash

echo -e "This program repairs Mesa and Vulkan Issues for Nvidia on Ubuntu based destros only.\nSuch as KDE, Kubunutu etc.\n\nIt is inteded to be a quick repair tool for all things Steam, NVIDIA and Proton.\n\nIf that is not you do not continue. If your machine breaks your own your own.\n"
read -p "Continue [Y]/n: " continue

if [[ ($continue == 'Y' || $continue == 'y')]]; then
    echo -e "\n"
    read -p "Last chance.. Are you sure? [y]/n: " sure
    
    if [[ (sure == 'Y') || $sure == 'y') ]]; then
            echo "**Lets Repair Some Mesa Mess!**"
            echo "Stage 1 of 6 - Roll back beta drivers"
            sudo add-apt-repository ppa:graphics-drivers/ppa --remove
            sudo apt-get --assume-yes update > /dev/null
            sudo apt-get --assume-yes autoremove > /dev/null
            sudo apt-get --assume-yes dist-upgrade > /dev/null
            sudo pkcon refresh > /dev/null
            sudo pkcon get-packages > /dev/null
            sudo pkcon update > /dev/null
            sudo pkcon repair > /dev/null
            sudo pkcon get-updates > /dev/null

            echo -e "\nStage 2 of 6 - Clean package cache"
            sudo apt-get --assume-yes clean > /dev/null

            echo -e "\nStage 3 of 6 - Repair any broken installs"
            sudo apt-get --assume-yes --fix-missing update > /dev/null
            sudo dpkg --configure -a > /dev/null
            sudo apt-get --assume-yes install -f > /dev/null
            sudo apt-get --assume-yes clean && sudo apt-get update > /dev/null
            sudo apt-get --assume-yes dist-upgrade > /dev/null
            sudo apt-get --assume-yes autoremove > /dev/null

            echo -e "\nStage 4 of 6 - Remove problematic services"
            sudo apt-get --assume-yes purge screen-resolution-extra > /dev/null

            echo -e "\nStage 5 of 6 purge old gpu drivers and related compoonents"
            sudo apt-get --assume-yes purge vulkan-tools mesa-vulkan-drivers mesa-vdpau-drivers mesa-utils-extra mesa-utils mesa-utils-extra mesa-vulkan-drivers:i386 libnvidia-* > /dev/null


            echo -e "\nStage 6 of 6 install new drivers"
            sudo ubuntu-drivers autoinstall > /dev/null
            sudo apt-get --assume-yes install vulkan-tools mesa-vulkan-drivers mesa-vdpau-drivers mesa-utils-extra mesa-utils mesa-utils-extra mesa-vulkan-drivers mesa-vulkan-drivers:i386 > /dev/null
            echo -e "Please Reboot Your Machine"
        else
            echo -e "Abort\n"
    fi
else
    echo -e "Abort\n"
fi
