//
//  EncoderController.h
//  Encoder
//
//  Created by Phidgets on 2015-07-15.
//  Copyright (c) 2015 Phidgets. All rights reserved.
//

#import <Foundation/Foundation.h>
#import </Library/Frameworks/Phidget22.framework/Headers/phidget22.h>
#import "PhidgetInfoBox.h"

@interface EncoderController : NSObject <NSWindowDelegate>
{
    PhidgetEncoderHandle ch;
	PhidgetDigitalInputHandle ch2;
	
    IBOutlet NSTextField *positionChangeText;
	//IBOutlet NSTextField *timeChangeText;
    IBOutlet NSTextField *positionText;
    IBOutlet NSTextField *indexPositionText;
    IBOutlet NSTextField *velocityText;
    IBOutlet NSBox *dataBox;
    IBOutlet NSTextField *stateTextField;
	IBOutlet NSBox *stateBox;
}

- (void)startEncoder:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort;
//- (void)startDigitalInput:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort;
- (void)setEnabled:(int)value channel:(int)channelNumber;
- (void)setPosition:(int)value serialNumber:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel;
- (void)resetPosition;
//- (void)startDigitalInput:(int)value channel:(int)channelNumber;

@end

@interface EncoderInputController : NSObject <NSWindowDelegate>
{
    PhidgetDigitalInputHandle ch;
	
    IBOutlet NSBox *dataBox;
    IBOutlet NSTextField *stateTextField;
	IBOutlet NSBox *stateBox;
}

- (void)startEncoderInput:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort;

@end

@interface DigitalInputController : NSObject <NSWindowDelegate>
{
    PhidgetDigitalInputHandle ch;
	
    IBOutlet NSBox *dataBox;
    IBOutlet NSTextField *stateTextField;
	IBOutlet NSBox *stateBox;
}

- (void)startDigitalInput:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort;

@end

