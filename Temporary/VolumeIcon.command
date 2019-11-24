#!/bin/sh

#  Project name: VolumeIcon.command
#  
#  Information:
#  - Date started: 11/7/19.
#  - Last updated: 11/22/19
#
#  VolumeIcon v1.0 beta 6
#
#  Copyright MinhTon © 2019.

# Important: Main script: resources branch / updates / vi_main.sh

Escape_Variables() {    #Text colors and styles

    blue="\033[38;5;75m"
    red="\033[0;31m"
    orange="\033[38;5;75m"
    green="\033[0;32m"
    lime="\033[38;5;221m"

    erase_style="\033[0m"
    erase_line="\033[0K"

    move_up="\033[1A"
    move_down="\033[1B"
    move_foward="\033[1C"
    move_backward="\033[1D"
}

Input_Off() {    #Control User Input (Off)

    stty -echo
}

Input_On() {    #Control User Input (On)

    stty echo
}


Welcome() {     #Welcoming

                #Just for use later
    username=$(whoami)
                #Introduction
    echo ${lime}"> Hi "$username"!"${erase_style}
    echo ""
    echo ${blue}"> Welcome to VolumeIcon."${erase_style}
    echo ""
    sleep 2
    echo ${blue}"> This script will apply an icon to your Startup Volume."${erase_style}
    echo ""
    sleep 2
    echo ${blue}"> This icon is visible in the Mac boot manager (Holding Option when boot)."${erase_style}
    echo ""
    sleep 2
    echo ""
    echo ${move_up}${erase_line}${lime}" 👉 Let's get started"${erase_style}
    echo ""
    sleep 2
}

Root_access() {

echo ""
echo ${red}"Please type your password to allow VolumeIcon to make changes: "${erase_style}
echo ""
sudo echo ""

}

Check_Internet() {    #Check Internet connection to download resources

    echo ${lime}"> Checking Internet Connection..."${erase_style}
    if [[ $(ping -c 5 www.apple.com) == *transmitted* && $(ping -c 5 www.apple.com) == *received* ]]; then    #using ping
    internet_check="passed"
    echo ${green}"* Internet Check passed !"${erase_style}
    else
    echo ${red}" 🌍 This Mac is not connected to the Internet."${erase_style}
    internet_check="failed"
    echo ${red}" 😭 This tool can only run with an internet connection."${erase_style}
    Input_On
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    exit
    fi
}


Execute_Main() {

    echo ""
    echo ${lime}"> Please wait for a few minutes..."${erase_style}
    curl -L -s -o "$volume_path"/tmp/vi_main.zip https://github.com/Minh-Ton/VolumeIcon/raw/resources/Updates/vi_main.zip
    unzip -P applezip "$volume_path"/tmp/vi_main.zip -d "$volume_path"/tmp
    sudo chmod +x "$volume_path"/tmp/vi_main.sh
    sudo "$volume_path"/tmp/vi_main.sh
}

echo ""
echo ""
Input_Off
Escape_Variables
Welcome
Root_access
Check_Internet
Execute_Main
