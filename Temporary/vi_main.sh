#!/bin/sh

#  Project name: VolumeIcon.command
#
#  Information:
#  - Date started: 11/7/19.
#  - Last updated: 11/23/19
#
#  VolumeIcon v1.0 beta 6
#
#  Copyright MinhTon © 2019.

#  Main script is here !

# ----------------------------------- # Preparing stuffs

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

# ----------------------------------- # Main section here.

Input_Volume() {    #Input Volume name to have a more precise path

echo ""
echo ${blue}"What volume would you like to use?"${erase_style}
echo ${lime}"- - -> Input a volume name."${erase_style}
for volume_path in /Volumes/*; do
volume_name="${volume_path#/Volumes/}"
if [[ ! "$volume_name" == com.apple* ]]; then
echo ${green}"     ${volume_name}"${erase_style} | sort -V
fi
done
Input_On
echo " "
read -e -p "Your desired volume: " volume_name
Input_Off
echo ""
volume_path="/Volumes/$volume_name"

}

Check_Volume_Version() {    #Check volume version

echo ${lime}"> Checking macOS Compatibility..."${erase_style}
volume_version="$(defaults read "$volume_path"/System/Library/CoreServices/SystemVersion.plist ProductVersion)"
volume_version_short="$(defaults read "$volume_path"/System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-5)"
volume_build="$(defaults read "$volume_path"/System/Library/CoreServices/SystemVersion.plist ProductBuildVersion)"
}

Check_Volume_Support() {    #Check compatibility

if [[ $volume_version_short == "10.1"[2-3-4-5] ]]; then
echo ${green}"*macOS Compatibility Check passed !"${erase_style}
else
echo ${red}"💻 Oops... You are not running the latest macOS."${erase_style}
echo ${red}"😭 Run this tool on a supported system. (10.13 or newer)"${erase_style}
Input_On
echo ""
echo ""
echo ""
echo ""
echo ""
exit
fi
}

Install_volIcon() {   #Apply icon to volume

if [[ $volume_version_short == "10.12" ]]; then
Sierra
fi

if [[ $volume_version_short == "10.13" ]]; then
HighSierra
fi

if [[ $volume_version_short == "10.14" ]]; then
Mojave
fi

if [[ $volume_version_short == "10.15" ]]; then
Catalina
fi

Remove_Temp

}

Remove_Temp() {

#Remove temp files (Stored in tmp)

if [[ $volume_version_short == "10.12" ]]; then
sudo rm "$volume_path"/tmp/Sierra.icns
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
osascript -e 'display notification "VolumeIcon has finished applying a new shiny icon to your selected volume! Have fun!" with title "VolumeIcon v2.1" sound name "Opening"'
fi

if [[ $operation == "2" ]]; then
Remove_volIcon
osascript -e 'display notification "VolumeIcon has finished removing the icon! Sorry to see you go!" with title "VolumeIcon v2.1" sound name "Opening"'
fi

}

Finalizing() {

echo ""

echo ${blue}"Thank you for using VolumeIcon."${erase_style}
echo ""
Input_On
sudo rm "$volume_path"/tmp/vi_main.sh
sudo rm "$volume_path"/tmp/vi_main.zip
echo ""
echo ""
echo ""
echo ""
echo ""
exit

}


# ----------------------------------- # Each version of macOS uses its own function.

Sierra() {  # Support for macOS Sierra 10.12

echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/Sierra.icns https://github.com/Minh-Ton/VolumeIcon/raw/resources/Boot_icons/Sierra.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/Sierra.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied Sierra icon to your Volume."${erase_style}

}

HighSierra() {  #Support for macOS High Sierra 10.13

echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/HighSierra.icns https://github.com/Minh-Ton/VolumeIcon/raw/resources/Boot_icons/HighSierra.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/HighSierra.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied High Sierra icon to your Volume."${erase_style}

}

Mojave() {  # Support for macOS Mojave 10.14

echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/Mojave.icns https://github.com/Minh-Ton/Volumeicon/raw/resources/Boot_icons/Mojave.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/Mojave.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied Mojave icon to your Volume."${erase_style}

}

Catalina() {    # Support for macOS Catalina 10.15

echo " "
if [[ $(diskutil info "$volume_name"|grep "Mount Point") == *"/" && ! $(diskutil info "$volume_name"|grep "Mount Point") == *"/Volumes" ]]; then
sudo mount -uw /
fi
echo ""
echo ${green}"> Downloading resources."${erase_style}
sudo curl -L -s -o "$volume_path"/tmp/Catalina.icns https://github.com/Minh-Ton/VolumeIcon/raw/resources/Boot_icons/Catalina.icns

#Copy process...
echo ${green}"> Adding Volume icon to your startup Volume..."
sudo cp -a "$volume_path"/tmp/Catalina.icns "$volume_path"/.VolumeIcon.icns
echo ${move_up}${erase_line}${lime}"+ Applied Catalina icon to your Volume."${erase_style}

}

# ----------------------------------- # Commands to execute

Input_Off
Escape_Variables
Input_Volume
Check_Volume_Version
Check_Volume_Support
Input_Operation
Finalizing
