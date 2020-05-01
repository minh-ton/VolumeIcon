//
//  AppController.h
//  VolumeIcon
//
//  Created by Ford on 4/30/20.
//  Copyright © 2020 fordApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import "STPrivilegedTask.h"
NS_ASSUME_NONNULL_BEGIN

@interface AppController : NSObject {
@private
    
    IBOutlet NSWindow *window;
    IBOutlet NSPopUpButton *selectVolumePopUp;
    IBOutlet NSImageView *selectVolumeIcon;
    IBOutlet NSImageView *processingIcon;
    IBOutlet NSImageView *completeIcon;
    IBOutlet NSTextField *progressLabel;
    IBOutlet NSProgressIndicator *progressBar;
    IBOutlet NSButton *startOperation;
    
}

- (id)init;
- (IBAction)SelectTargetVolume:(id)sender;
- (IBAction)StartOperationClicked:(id)sender;

@end

NS_ASSUME_NONNULL_END
