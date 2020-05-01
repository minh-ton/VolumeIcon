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
    NSLog(@"Successfully copied Flags to /tmp");
    
    NSString *IconPack = [appdir pathForResource:@"volumeicon" ofType:@"bundle"];
    NSTask *copyIconPack = [[NSTask alloc] init];
    [copyIconPack setLaunchPath:@"/bin/cp"];
    [copyIconPack setArguments:@[ @"-R", IconPack, @"/tmp" ]];
    [copyIconPack launch];
    NSLog(@"Successfully copied Icon Pack to /tmp");
    
    // Get Volume List
    
    [progressLabel setHidden:YES];
    NSArray *VolumesList = [[NSMutableArray alloc] initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Volumes" error:nil]];
    [selectVolumePopUp addItemsWithTitles:VolumesList];
    
    NSString *SelectedVolume = selectVolumePopUp.titleOfSelectedItem;
    NSLog(@"%@", SelectedVolume);
    
    NSTask *writeSelectedVoltoplist = [[NSTask alloc] init];
    [writeSelectedVoltoplist setLaunchPath:@"/usr/bin/defaults"];
    NSArray *svwritearg = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"SelectedVolume", SelectedVolume,nil];
    [writeSelectedVoltoplist setArguments:svwritearg];
    [writeSelectedVoltoplist launch];
    
    NSString *SelectedChoice = @"Apply";
    NSTask *writeSelectedChoicetoplist = [[NSTask alloc] init];
    [writeSelectedChoicetoplist setLaunchPath:@"/usr/bin/defaults"];
    NSArray *scwritearg = [[NSArray alloc] initWithObjects:@"write", @"/tmp/VolumeIconFlags.plist", @"SelectedChoice", SelectedChoice,nil];
    [writeSelectedChoicetoplist setArguments:scwritearg];
    [writeSelectedChoicetoplist launch];
}

- (IBAction)SelectTargetVolume:(id)sender {

    NSString *SelectedVolume = selectVolumePopUp.titleOfSelectedItem;
    NSLog(@"%@", SelectedVolume);
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
    NSLog(@"%@", SelectedVolume);
    NSLog(@"%@", SelectedChoice);
    
    if ([SelectedVolume isEqualToString:@"Choose a Volume..."]) {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"No Volume Selected."];
        [alert setInformativeText:@"Please choose a target volume to continue. It can be your startup volume or a bootable installer."];
        [alert addButtonWithTitle:@"OK"];
        [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:nil contextInfo:nil];
        
    } else {
        
        [selectVolumePopUp setEnabled:NO];
        [progressLabel setHidden:NO];
        [selectVolumeIcon setEnabled:NO];
        [processingIcon setEnabled:YES];
        
        [progressBar setIndeterminate:YES];
        [progressBar startAnimation:self];
        [progressLabel setStringValue:@"Starting Helper..."];
        
        NSString *VolumePath = [@"/Volumes/" stringByAppendingString:SelectedVolume];
        NSString *SystemVersionPlistPath = [VolumePath stringByAppendingString:@"/System/Library/CoreServices/SystemVersion.plist"];
        NSLog(@"%@", VolumePath);
        
        NSDictionary *VersionPlist = [NSDictionary dictionaryWithContentsOfFile:SystemVersionPlistPath];
        NSString *productVersion = [VersionPlist objectForKey:@"ProductVersion"];
        productVersion = [productVersion substringToIndex:(productVersion.length - 2)];
        NSLog(@"%@", productVersion);
        
        // Catalina
        if ([productVersion isEqualToString:@"10.15"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/Catalina.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[@"-c", cpArgs]];
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
        }
        
        // Mojave
        if ([productVersion isEqualToString:@"10.14"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/Mojave.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            NSLog(@"%@", cpArgs);
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // High Sierra
        if ([productVersion isEqualToString:@"10.13"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/HighSierra.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // Sierra
        if ([productVersion isEqualToString:@"10.12"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/Sierra.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // El Capitan
        if ([productVersion isEqualToString:@"10.11"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/ElCapitan.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // Yosemite
        if ([productVersion isEqualToString:@"10.10"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/Yosemite.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // Mavericks
        if ([productVersion isEqualToString:@"10.9"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/Mavericks.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // Mountain Lion
        if ([productVersion isEqualToString:@"10.8"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/MountainLion.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
        
        // Lion
        if ([productVersion isEqualToString:@"10.7"]) {
            STPrivilegedTask *copyVolIcon = [[STPrivilegedTask alloc] init];
            [copyVolIcon setLaunchPath:@"/bin/bash"];
            NSString *cpArgsOriginal = [@"cp -a /tmp/volumeicon.bundle/Lion.icns " stringByAppendingString:VolumePath];
            NSString *cpArgs = [cpArgsOriginal stringByAppendingString:@"/.VolumeIcon.icns"];
            [copyVolIcon setArguments:@[cpArgs]];
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
        }
    }
}

@end
