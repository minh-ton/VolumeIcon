#!/bin/sh

#  VolumeIcon.command
#  
#
#  Created by Ford on 11/7/19.
#  

Escape_Variables() {    #Text colors and styles

    blue="\033[0;34m"
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
    echo ${blue}"> Welcome to VolumeIcon."${erase_style}
    echo ""
    sleep 2
    echo ${blue}"> This script will apply an icon to your Startup Volume."${erase_style}
    echo ""
    sleep 2
    echo ${blue}"> This icon can be seen in the Mac boot manager (Holding Option when boot)."${erase_style}
    echo ""
    sleep 2
    echo ""
    echo ${move_up}${erase_line}${lime}"- - - > Let's get started"${erase_style}
    echo ""
    sleep 2
}

Check_Internet() {    #Check Internet connection to download resources

    if [[ $(ping -c 5 www.google.com) == *transmitted* && $(ping -c 5 www.google.com) == *received* ]]; then    #using ping
    internet_check="passed"
    else
    echo ${red}"- This Mac is not connected to the Internet."${erase_style}
    internet_check="failed"
    echo ${red}"/ This tool can only run with an internet connection."${erase_style}
    Input_On
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    exit
    fi
}

Input_Volume() {    #Input Volume name to have a more precise path

    echo ""
    echo ${blue}"/ What volume would you like to use?"${erase_style}
    echo ${blue}"/ Input a volume name."${erase_style}
    for volume_path in /Volumes/*; do
    volume_name="${volume_path#/Volumes/}"
    if [[ ! "$volume_name" == com.apple* ]]; then
    echo ${green}"/     ${volume_name}"${erase_style} | sort -V
    fi
    done
    Input_On
    read -e -p "/ " volume_name
    Input_Off
    echo ""
    echo ${red}"VolumeIcon wants to make changes. Please enter your password to continue:"${erase_style}
    echo ""
    volume_path="/Volumes/$volume_name"

    if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
    sudo mount -uw /
    fi
}

Check_Volume_Version() {    #Check volume version

    volume_version="$(defaults read "$volume_path"/System/Library/CoreServices/SystemVersion.plist ProductVersion)"
    volume_version_short="$(defaults read "$volume_path"/System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-5)"

    volume_build="$(defaults read "$volume_path"/System/Library/CoreServices/SystemVersion.plist ProductBuildVersion)"
}

Check_Volume_Support() {    #Check compatibility

    if [[ $volume_version_short == "10.1"[4-5] ]]; then
    echo
    else
    echo ${red}"- Oops... You are not running the latest macOS."${erase_style}
    echo ${red}"/ Run this tool on a supported system. (10.14 or newer)"${erase_style}
    Input_On
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    exit
    fi
}

Input_Operation() {     #Input operations

    echo ""
    echo ${blue}"/ What operation would you like to proceed?"${erase_style}
    echo ${blue}"/ Input an operation number."${erase_style}
    echo ${green}"/     1 - Add Volume icon"${erase_style}
    echo ${green}"/     2 - Remove Volume icon"${erase_style}
    Input_On
    read -e -p "/ " operation
    Input_Off


if [[ $operation == "1" ]]; then
    Install_volIcon
fi

if [[ $operation == "2" ]]; then
    Remove_volIcon
fi

}


Install_volIcon() {     #Apply icon to volume

    echo ""
    if [[ $volume_version_short == "10.14" ]]; then
    echo ${green}"> Downloading internet resources."${erase_style}
    sudo curl -L -s -o /tmp/Mojave.icns https://github.com/Minh-Ton/Volumeicon/raw/resources/Mojave.icns

    #Copy process...
    echo ${green}" > Adding Volume icon to your startup Volume..."
    sudo cp -a "$volume_path"/tmp/Mojave.icns "$volume_path"/.VolumeIcon.icns
    echo ${move_up}${erase_line}${lime}"+ Applied Mojave icon to your Volume."${erase_style}

    fi

    if [[ $volume_version_short == "10.15" ]]; then
    echo ${green}"> Downloading internet resources."${erase_style}
    sudo curl -L -s -o /tmp/Catalina.icns https://github.com/Minh-Ton/Volumeicon/raw/resources/Catalina.icns

    #Copy process...
    echo ${green}" > Adding Volume icon to your startup Volume..."
    sudo cp -a "$volume_path"/tmp/Catalina.icns "$volume_path"/.VolumeIcon.icns
    echo ${move_up}${erase_line}${lime}"+ Applied Catalina icon to your Volume."${erase_style}

    fi

    #Remove temporary files
    if [[ $volume_version_short == "10.14" ]]; then
    sudo rm /tmp/Mojave.icns
    else
    sudo rm /tmp/Catalina.icns
    fi
}

Remove_volIcon() { #Remove icon from volume

    echo ""
    echo ${green}" > Removing icon from your volume..."
    sudo rm "$volume_path"/.VolumeIcon.icns
    echo ${move_up}${erase_line}${lime}"+ Removed icon from your Volume."${erase_style}
}

Finalizing() {

    echo ""
    echo ${blue}"/ Thank you for using VolumeIcon."${erase_style}
    echo ${blue}"Check out MinhTon's other repositories: https://github.com/Minh-Ton"${erase_style}
    Input_On
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""

    exit

}

echo ""
echo ""
Input_Off
Escape_Variables
Welcome
Check_Internet
Input_Volume
Check_Volume_Version
Check_Volume_Support
Input_Operation
Finalizing
