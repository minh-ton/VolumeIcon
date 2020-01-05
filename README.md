# [VolumeIcon v2.2](https://github.com/Minh-Ton/VolumeIcon)

⬇️ Download the latest release from here: [VolumeIcon v2.2](https://github.com/Minh-Ton/VolumeIcon/releases/download/v2.2.0/VolumeIcon.zip) 

⌛️ Want to see release notes? See here: [Changelogs](https://github.com/Minh-Ton/VolumeIcon/releases/latest)

## 1. Introduction

This application is to apply an icon to your bootable volume.

The icon can be seen in the Mac Boot Manager (Press Option while booting)

#### Minimum requirement: macOS 10.12.6 or newer

## 2. How to use:

Step 1: Download the application using the link above.

Step 2: Click on the VolumeIcon.zip to unzip the file.

Step 3: Run the VolumeIcon application. 

Step 4: A Terminal window will appear. Click on the Terminal window to use the utility. 

### After using the utility... Press and hold the Option (Alt) key immediately after turning on or restarting your Mac to see the effect.
![Optional Text](https://github.com/Minh-Ton/VolumeIcon/raw/resources/Icons_Images/1.png)

## Source code:

### AppleScript app: 

```AppleScript 
set app_directory to POSIX path of (path to me)
set VolumeIcon to quoted form of (app_directory & "Contents/Resources/VolumeIcon.command")
set step1_clrtmp to quoted form of (app_directory & "Contents/Resources/step1_delete.sh")
set step2_clrtmp to quoted form of (app_directory & "Contents/Resources/step2_delete.sh")
set reboot_scrpt to quoted form of (app_directory & "Contents/Resources/reboot_scrpt.sh")
--> Hide/minimize all windows
tell application "Finder"
	set visible of every process whose visible is true to false
	set the collapsed of windows to true
end tell
--> Execute the script
do shell script "/Applications/Utilities/Terminal.app/Contents/MacOS/Terminal " & VolumeIcon & " >/dev/null &" with administrator privileges
--> Cleaning up files
do shell script step1_clrtmp with administrator privileges
do shell script step2_clrtmp with administrator privileges
set n to 2
set progress total steps to n
set progress description to "VolumeIcon v2.2"
set progress additional description to "Cleaning up temporary files..."
repeat with i from 1 to n
	delay 1
	set progress completed steps to i
end repeat
--> Promp user to restart
display alert "Messages from VolumeIcon v2.2" message "Would you like to restart your Mac for changes to be applied?" as critical buttons {"Restart later", "Restart now"} default button "Restart now" cancel button "Restart later"
if the button returned of the result is "Restart now" then
	do shell script reboot_scrpt
	quit
else
	quit
end if
```
### Shell script:

```Shell
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

                #Introduction
    echo ${lime}"> Hi !"${erase_style}
    echo ""
    echo ${blue}"> Welcome to VolumeIcon."${erase_style}
    echo ""
    sleep 2
    echo ${blue}"> This app will apply an icon to your Startup Volume."${erase_style}
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


Check_Internet() {    #Check Internet connection to download resources

    echo ${lime}"> Checking Internet Connection..."${erase_style}
    if [[ $(ping -c 5 www.apple.com) == *transmitted* && $(ping -c 5 www.apple.com) == *received* ]]; then    #using ping
    internet_check="passed"
    echo ${green}"* Internet Check passed !"${erase_style}
    else
    osascript -e 'display alert "This Mac is not connected to the Internet" message "Please run this app with an internet connection." buttons {"Quit"} '
    Input_On
    echo ""
    echo ""
    echo ""
    echo ""
    echo ""
    killall Terminal
    fi
}


Execute_Main() {

    echo ""
    echo ${lime}"> Please wait for a few minutes..."${erase_style}
    curl -L -s -o /tmp/vi_main.zip https://github.com/Minh-Ton/VolumeIcon/raw/resources/Updates/vi_main.zip
    unzip -qq -P applezip /tmp/vi_main.zip -d /tmp
    sudo chmod +x /tmp/vi_main.sh
    sudo /tmp/vi_main.sh
}

echo ""
echo ""
Input_Off
Escape_Variables
Welcome
Check_Internet
Execute_Main
```
