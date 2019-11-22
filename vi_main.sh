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

#  Main script is here !

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

Input_Operation() {     #Input operations

echo ""
echo ${blue}"What operation would you like to proceed?"${erase_style}
echo ${lime}"- - - > Input an operation number."${erase_style}
echo ${green}"     1 - Add Volume icon"${erase_style}
echo ${green}"     2 - Remove Volume icon"${erase_style}
Input_On
echo " "
read -e -p "Your input :  " operation
Input_Off

if [[ $operation == "1" ]]; then
Install_volIcon
fi

if [[ $operation == "2" ]]; then
Remove_volIcon
fi

}

Install_volIcon() {   #Apply icon to volume

#Support for macOS Sierra
if [[ $volume_version_short == "10.12" ]]; then
echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/Sierra.icns https://github.com/Minh-Ton/VolumeIcon/raw/resources/Sierra.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/Sierra.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied Sierra icon to your Volume."${erase_style}
fi

#Support for macOS High Sierra
if [[ $volume_version_short == "10.13" ]]; then
echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/HighSierra.icns https://github.com/Minh-Ton/VolumeIcon/raw/resources/HighSierra.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/HighSierra.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied High Sierra icon to your Volume."${erase_style}
fi

#Support for macOS Mojave
if [[ $volume_version_short == "10.14" ]]; then
echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/Mojave.icns https://github.com/Minh-Ton/Volumeicon/raw/resources/Mojave.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/Mojave.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied Mojave icon to your Volume."${erase_style}
fi

#Support for macOS Catalina
if [[ $volume_version_short == "10.15" ]]; then
echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/Catalina.icns https://github.com/Minh-Ton/Volumeicon/raw/resources/Catalina.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/Catalina.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied Catalina icon to your Volume."${erase_style}
fi

#Remove temporary files

if [[ $volume_version_short == "10.13" ]]; then
sudo rm "$volume_path"/tmp/HighSierra.icns
fi

if [[ $volume_version_short == "10.13" ]]; then
sudo rm "$volume_path"/tmp/HighSierra.icns
fi

if [[ $volume_version_short == "10.14" ]]; then
sudo rm "$volume_path"/tmp/Mojave.icns
fi

if [[ $volume_version_short == "10.15" ]]; then
sudo rm "$volume_path"/tmp/Catalina.icns
fi

}

Remove_volIcon() { #Remove icon from volume

echo ""
echo ${green}"> Removing icon from your volume..."
echo ""
sudo rm "$volume_path"/.VolumeIcon.icns
echo ""
echo ${move_up}${erase_line}${lime}"+ Removed icon from your Volume."${erase_style}
}

Finalizing() {

echo ""

echo ${blue}"Thank you "$username" for using VolumeIcon."${erase_style}
echo ""
echo ${green}"- - - > Check out MinhTon's other repositories: https://github.com/Minh-Ton"${erase_style}
Input_On
echo ""
echo ""
echo ""
echo ""
echo ""
sudo rm "$volume_path"/tmp/vi_main.sh
exit

}

Input_Off
Escape_Variables
Input_Operation
Finalizing
