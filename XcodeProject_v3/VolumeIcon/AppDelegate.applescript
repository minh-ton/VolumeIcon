--
--  AppDelegate.applescript
--  VolumeIcon
--
--  Created by Ford on 2/29/20.
--  Copyright © 2020 MinhTon. All rights reserved.
--

script AppDelegate
	property parent : class "NSObject"
    property OptionsPopUp : missing value
    property progressLabel : missing value
    property progressBar : missing value
    property progressButton : missing value
    property progressButton2 : missing value
    property progressButtonLabel : missing value
	property theWindow : missing value
    
    on selectOptionPopupClicked_(sender)
        set Option to ((OptionsPopUp's indexOfSelectedItem()) as string) as integer
        if Option = 0 then
            do shell script "rm -R ~/VItemp/choiceSelected.txt"
            do shell script "touch ~/VItemp/choiceSelected.txt"
            set whatToDo to "apply"
            do shell script "echo " & whatToDo & " >> ~/VItemp/choiceSelected.txt"
            else if Option = 1
            do shell script "rm -R ~/VItemp/choiceSelected.txt"
            do shell script "touch ~/VItemp/choiceSelected.txt"
            set whatToDo to "remove"
            do shell script "echo " & whatToDo & " >> ~/VItemp/choiceSelected.txt"
        end if
    end selectOptionPopupClicked_
	
    on progressButtonClicked_(sender)
        progressButton's setEnabled_(false)
        OptionsPopUp's setEnabled_(false)
        progressLabel's setStringValue:"Starting helper..."
        do shell script "echo " with administrator privileges
        tell progressBar to setDoubleValue:5
        delay 1
        progressLabel's setStringValue:"Please choose a volume to continue..."
        --
        do shell script "ls /Volumes"
        get paragraphs of result
        set volname to (choose from list (result) with prompt "What volume would you like to use?") as string
        tell progressBar to setDoubleValue:10
        --
        set whatToDo to (do shell script "cat ~/VItemp/choiceSelected.txt") as string
        --
        if whatToDo = "remove" then
            progressLabel's setStringValue:"Removing volume icon..."
            try
            do shell script "rm /Volumes/" & volname & "/.VolumeIcon.icns" with administrator privileges
            on error errMsg number errNum
            display alert "Read-only file system" message "Please choose another writable volume." buttons {"Quit"} default button "Quit"
            do shell script "killall VolumeIcon"
            end try
            tell progressBar to setDoubleValue:100
            delay 2
            progressLabel's setStringValue:"Completed."
            progressButtonLabel's setStringValue:"Please restart for changes to take effect."
            progressButton's setHidden_(true)
            progressButton2's setHidden_(false)
            display notification "Successfully removed icon from " & volname & "." with title "VolumeIcon v3.0" sound name "Opening"
        end if
        --
        if whatToDo = "apply" then
            delay 0.1
            tell progressBar to setDoubleValue:10
            delay 0.1
            tell progressBar to setDoubleValue:15
            set app_directory to POSIX PATH of (path to current application as text) & "Contents/Resources/"
            progressLabel's setStringValue:"Checking environment support..."
            -- set libShell to quoted form of (app_directory & "lib.sh") as string
            -- do shell script "chmod +x " & libShell
            -- do shell script "cp " & libShell & " ~/VItemp/lib.sh"
            set shellContent to "/Volumes/" & volname & "/BaseSystem.dmg"
            -- do shell script "echo VOLUME_PATH=" & shellContent & " >> ~/VItemp/lib.sh"
            set EVDetectionSh to quoted form of (app_directory & "shell.bundle/EVDetection.sh") as string
            do shell script "chmod +x " & EVDetectionSh
            set environment to (do shell script EVDetectionSh & " " & shellContent)
            tell progressBar to setDoubleValue:20
            delay 2
            progressLabel's setStringValue:"Checking system version..."
            set macOSVersion to (do shell script "defaults read /Volumes/" & volname & "/System/Library/CoreServices/SystemVersion.plist ProductVersion | cut -c-5") as string
            tell progressBar to setDoubleValue:30
            progressLabel's setStringValue:"Applying volume icon..."

            -- This is for 10.15 Catalina
            delay 0.1
            tell progressBar to setDoubleValue:40
            if macOSVersion = "10.15"
                if environment = "installer" then
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/CatalinaRecovery.icns") as string
                else if environment = "system"
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/Catalina.icns") as string
                end if
            end if
            
            -- This is for 10.14 Mojave
            delay 0.1
            tell progressBar to setDoubleValue:40
            if macOSVersion = "10.14" then
                if environment = "installer" then
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/MojaveRecovery.icns") as string
                    else if environment = "system"
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/Mojave.icns") as string
                end if
            end if
            
            -- This is for 10.13 High Sierra
            delay 0.1
            tell progressBar to setDoubleValue:50
            if macOSVersion = "10.13" then
                if environment = "installer" then
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/HighSierraRecovery.icns") as string
                    else if environment = "system"
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/HighSierra.icns") as string
                end if
            end if
            
            -- This is for 10.15 Catalina
            delay 0.1
            tell progressBar to setDoubleValue:60
            if macOSVersion = "10.12" then
                if environment = "installer" then
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/SierraRecovery.icns") as string
                    else if environment = "system"
                    set VolumeIcon to quoted form of (app_directory & "BootIcons.bundle/Sierra.icns") as string
                end if
            end if
            -- Copy to the targeted volume:
            delay 0.1
            tell progressBar to setDoubleValue:70
            try
                do shell script "cp -a " & VolumeIcon & " /Volumes/" & volname & "/.VolumeIcon.icns" with administrator privileges
                on error errMsg number errNum
                display alert "Read-only file system" message "Please choose another writable volume." buttons {"Quit"} default button "Quit"
                do shell script "killall VolumeIcon"
                display dialog
            end try
            tell progressBar to setDoubleValue:100
            delay 2
            progressLabel's setStringValue:"Completed."
            progressButtonLabel's setStringValue:"Please restart for changes to take effect."
            progressButton's setHidden_(true)
            progressButton2's setHidden_(false)
            display notification "An icon has been successfully applied to " & volname & "." with title "VolumeIcon v3.0" sound name "Opening"
        end if
    end progressButtonClicked_

    on QuitButtonClicked_(sender)
        do shell script "rm -R ~/VItemp"
        do shell script "reboot" with administrator privileges
    end QuitButtonClicked_

	on applicationWillFinishLaunching_(aNotification)
		-- Insert code here to initialize your application before any files are opened
        do shell script "mkdir ~/VItemp"
        do shell script "chflags hidden ~/VItemp"
        --
        set username to (do shell script "whoami")
        progressLabel's setStringValue:"Hi " & username & "! Welcome to the redesigned VolumeIcon app."
        --
        do shell script "touch ~/VItemp/choiceSelected.txt"
        set whatToDo to "apply"
        do shell script "echo " & whatToDo & " >> ~/VItemp/choiceSelected.txt"
        progressButtonLabel's setStringValue:"Continue"
        progressButton2's setHidden_(true)
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
        do shell script "rm -R ~/VItemp"
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
    on applicationShouldTerminateAfterLastWindowClosed_(sender)
        return true
    end applicationShouldTerminateAfterLastWindowClosed_
    
end script
