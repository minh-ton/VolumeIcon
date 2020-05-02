//
//  AppController.m
//  VolumeIcon
//
//  Created by Ford on 4/30/20.
//  Copyright © 2020 fordApps. All rights reserved.
//

#import "AppController.h"
#import <Cocoa/Cocoa.h>

@implementation AppController

- (id)init {
    self = [super init];
    return self;
}

- (void)awakeFromNib {
    
    // Copy flags file to /tmp
    
    NSBundle *appdir = [NSBundle mainBundle];
    NSString *flagspath = [appdir pathForResource:@"VolumeIconFlags" ofType:@"plist"];
    
    NSTask *copyFlags = [[NSTask alloc] init];
    [copyFlags setLaunchPath:@"/bin/cp"];
    [copyFlags setArguments:@[ flagspath, @"/tmp" ]];
    [copyFlags launch];
    
    NSString *IconPack = [appdir pathForResource:@"volumeicon" ofType:@"bundle"];
    NSTask *copyIconPack = [[NSTask alloc] init];
    [copyIconPack setLaunchPath:@"/bin/cp"];
    [copyIconPack setArguments:@[ @"-R", IconPack, @"/tmp" ]];
    [copyIconPack launch];
    
    // Get Volume List
    
    [progressLabel setHidden:YES];
    NSArray *VolumesList = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Volumes" error:nil]];
    [selectVolumePopUp addItemsWithTitles:VolumesList];
    
    NSString *SelectedVolume = selectVolumePopUp.titleOfSelectedItem;
    
    NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
    [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
    NSArray *svwritearg = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"SelectedVolume", SelectedVolume,nil];
    [writeSelectedVoltoplist setArguments:svwritearg];
    [writeSelectedVoltoplist launch];
    
}

- (IBAction)SelectTargetVolume:(id)sender {
    
    NSString *SelectedVolume = selectVolumePopUp.titleOfSelectedItem;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *VolumePath = [@"/Volumes/" stringByAppendingString:SelectedVolume];
    NSString *VolIcon = [VolumePath stringByAppendingString:@"/.VolumeIcon.icns"];
    if ([fileManager fileExistsAtPath:VolIcon]){
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Detected a Volume Icon on the selected disk."];
        [alert setInformativeText:@"Press OK to choose the option to reset the icon to default, then click Start Operation."];
        [alert addButtonWithTitle:@"OK"];
        [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:nil contextInfo:nil];
        
        NSString *SelectedChoice = @"Remove";
        NSTask *writeSelectedChoicetoplist = [[NSTask alloc] init];
        [writeSelectedChoicetoplist setLaunchPath:@"/usr/bin/defaults"];
        NSArray *scwritearg = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"SelectedChoice", SelectedChoice,nil];
        [writeSelectedChoicetoplist setArguments:scwritearg];
        [writeSelectedChoicetoplist launch];
        
    } else {
        
        NSString *SelectedChoice = @"Apply";
        NSTask *writeSelectedChoicetoplist = [[NSTask alloc] init];
        [writeSelectedChoicetoplist setLaunchPath:@"/usr/bin/defaults"];
        NSArray *scwritearg = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"SelectedChoice", SelectedChoice,nil];
        [writeSelectedChoicetoplist setArguments:scwritearg];
        [writeSelectedChoicetoplist launch];
        
    }
    
    NSString *plistpath = [VolumePath stringByAppendingString:@"/System/Library/CoreServices/SystemVersion.plist"];
    if ([fileManager fileExistsAtPath:plistpath]){
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"Cannot get system version for this volume."];
        [alert setInformativeText:@"Make sure that this volume is bootable and can be seen in Boot Manager."];
        [alert addButtonWithTitle:@"OK"];
        [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:nil contextInfo:nil];
    }
    
    NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
    [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
    NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"SelectedVolume", SelectedVolume,nil];
    [writeSelectedVoltoplist setArguments:defaultsArgs];
    [writeSelectedVoltoplist launch];
    
}

- (IBAction)StartOperationClicked:(id)sender {
    
    NSDictionary *flagspath = [NSDictionary dictionaryWithContentsOfFile:@"/tmp/VolumeIconFlags.plist"];
    NSString *SelectedVolume = [flagspath objectForKey:@"SelectedVolume"];
    NSString *SelectedChoice = [flagspath objectForKey:@"SelectedChoice"];
    
    if ([SelectedVolume isEqualToString:@"Choose a Volume..."]) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"No Volume Selected."];
        [alert setInformativeText:@"Please choose a target volume to continue. It can be your startup volume or a bootable installer."];
        [alert addButtonWithTitle:@"OK"];
        [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:nil contextInfo:nil];
        
    } else {
        
        if ([SelectedChoice isEqualToString:@"Apply"]) {
            
            [selectVolumePopUp setEnabled:NO];
            [selectVolumeIcon setEnabled:NO];
            [processingIcon setEnabled:YES];
            
            [progressBar setIndeterminate:YES];
            [progressBar startAnimation:self];
            
            NSString *VolumePath = [@"/Volumes/" stringByAppendingString:SelectedVolume];
            NSString *SystemVersionPlistPath = [VolumePath stringByAppendingString:@"/System/Library/CoreServices/SystemVersion.plist"];
            
            NSDictionary *VersionPlist = [NSDictionary dictionaryWithContentsOfFile:SystemVersionPlistPath];
            NSString *productVersion = [VersionPlist objectForKey:@"ProductVersion"];
            productVersion = [productVersion substringToIndex:(productVersion.length - 2)];
            
            // Catalina
            if ([productVersion isEqualToString:@"10.15"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"Catalina",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // Mojave
            if ([productVersion isEqualToString:@"10.14"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"Mojave",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // High Sierra
            if ([productVersion isEqualToString:@"10.13"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"HighSierra",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // Sierra
            if ([productVersion isEqualToString:@"10.12"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"Sierra",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // El Capitan
            if ([productVersion isEqualToString:@"10.11"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"ElCapitan",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // Yosemite
            if ([productVersion isEqualToString:@"10.10"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"Yosemite",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // Mavericks
            if ([productVersion isEqualToString:@"10.9"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"Mavericks",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // Mountain Lion
            if ([productVersion isEqualToString:@"10.8"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"MountainLion",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            // Lion
            if ([productVersion isEqualToString:@"10.7"]) {
                NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
                [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
                NSArray *defaultsArgs = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"IconFileName", @"Lion",nil];
                [writeSelectedVoltoplist setArguments:defaultsArgs];
                [writeSelectedVoltoplist launch];
            }
            
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] initWithLaunchPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"VolumeIcon.sh"]];
            OSStatus err = [copyVolIcon launch];
            if (err == errAuthorizationSuccess) {
                NSLog(@"Task successfully launched");
            }
            else if (err == errAuthorizationCanceled) {
                NSLog(@"User cancelled");
            }
            else {
                NSLog(@"Something went wrong");
            }
            
            [progressLabel setHidden:NO];
            [progressLabel setStringValue:@"Operation Completed."];
            [progressBar stopAnimation:self];
            [selectVolumeIcon setEnabled:NO];
            [processingIcon setEnabled:NO];
            [completeIcon setEnabled:YES];
            
        } else if ([SelectedChoice isEqualToString:@"Remove"]) {
            
            [progressBar startAnimation:self];
            STPrivilegedTask *removeVolIcon = [[STPrivilegedTask alloc] initWithLaunchPath:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Cleanup.sh"]];
            OSStatus err = [removeVolIcon launch];
            if (err == errAuthorizationSuccess) {
                NSLog(@"Task successfully launched");
            }
            else if (err == errAuthorizationCanceled) {
                NSLog(@"User cancelled");
            }
            else {
                NSLog(@"Something went wrong");
            }
            
            [progressLabel setHidden:NO];
            [progressLabel setStringValue:@"Operation Completed."];
            [progressBar stopAnimation:self];
            [selectVolumeIcon setEnabled:NO];
            [processingIcon setEnabled:NO];
            [completeIcon setEnabled:YES];
        }
        
    }
}

@end
