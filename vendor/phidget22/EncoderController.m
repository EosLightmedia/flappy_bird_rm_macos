//
//  EncoderController.m
//  Encoder
//
//  Created by Phidgets on 2015-07-15.
//  Copyright (c) 2015 Phidgets. All rights reserved.
//

#import "EncoderController.h"
//#import "DigitalInputController.h"

@implementation EncoderController

-(void)startEncoder:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort{
  PhidgetReturnCode result;
  // YOU MUST CREATE TWO SETS OF CHANNELS, ONE FOR THE ENCODER AND ONE FOR THE DIGITAL INPUT, BECAUSE THEY ARE ON THE SAME DEVICE I MUST DOUBLE UP ALL MY CREATES AND SETTINGS METHODS
  PhidgetEncoderHandle ec;
  PhidgetDigitalInputHandle di;

  int64_t position;
  //uint32_t position;
  
  result = PhidgetNet_addServer(serverName, ipAddress, networkPort, "", 0);
    if(result != EPHIDGET_OK){
      NSLog(@"error connecting to wireless vint");
    }
  
  result = PhidgetEncoder_create(&ec);
  if(result != EPHIDGET_OK){
     NSLog(@"error creating encoder");
  }
  
  result = PhidgetDigitalInput_create(&di);
  if(result != EPHIDGET_OK){
  	 NSLog(@"error creating digital input");
  }


  result = Phidget_setDeviceSerialNumber(ec, serialNumber);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting serial number for encoder");
  }
  
  result = Phidget_setDeviceSerialNumber(di, serialNumber);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting serial number for digital input");
  }
  
  result = Phidget_setHubPort(ec, hubPort);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port for encoder");
  }
  
  result = Phidget_setHubPort(di, hubPort);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port for digital input");
  }

  //result = Phidget_setIsHubPortDevice(ec, 1);  <<<THIS MAKES THE VINT HUB PORT A DIGITAL INPUT, WAS BLOCKING THE  DIGITAL INPUT FROM THE ENCODER  
  //if(result != EPHIDGET_OK){
  //  NSLog(@"error setting hub port device for encoder");
  //}
  //
  //result = Phidget_setIsHubPortDevice(di, 1);
  //if(result != EPHIDGET_OK){
  //  NSLog(@"error setting hub port device for digital input");
  //}

  result = Phidget_setChannel(ec, deviceChannel);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting channel for encoder for encoder");
  }
  
  result = Phidget_setChannel(di, deviceChannel);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting channel for digital input");
  }

  // Handlers
  result = Phidget_setOnAttachHandler(ec, gotAttach, (__bridge void*)self);
  if(result != EPHIDGET_OK){
    NSLog(@"error initializing attach handler for encoder");
  }
  
  result = Phidget_setOnAttachHandler(di, gotAttach, (__bridge void*)self);
  if(result != EPHIDGET_OK){
    NSLog(@"error initializing attach handler for digital input");
  }
  
  //result = PhidgetEncoder_setDataInterval(ec, 250);
  //if(result != EPHIDGET_OK){
  //  NSLog(@"error initializing data interval");
  //}
  
  result = PhidgetEncoder_setPositionChangeTrigger(ec, 1);
  if(result != EPHIDGET_OK){
    NSLog(@"error initializing data change trigger");
  }
	  

  // Open connection to phidget
  //result = Phidget_open(ec);
  //if(result != EPHIDGET_OK){
  //  NSLog(@"error opening phidget for encoder!");
  //}
  //
  //result = Phidget_open(di);
  //if(result != EPHIDGET_OK){
  //  NSLog(@"error opening phidget for digital input!");
  //}
  result = Phidget_openWaitForAttachment(ec, 5000);
  
  result = Phidget_openWaitForAttachment(di, 5000);
  
  
  //result = PhidgetEncoder_setPositionChangeTrigger(ch, 0);
  //if(result != EPHIDGET_OK){
  //	  NSLog(@"error positioning dial");
  //}
  
  result = PhidgetEncoder_setOnPositionChangeHandler(ec, positionChangeHandler, (__bridge void*)self);
  if(result != EPHIDGET_OK){
  	  NSLog(@"error setting position!");
  }
  
  result = PhidgetDigitalInput_setOnStateChangeHandler(di, gotStateChangeData, (__bridge void*)self);
  if(result != EPHIDGET_OK){
  	  NSLog(@"error setting up DigitalInput");
  }
}

-(void)startDigitalInput:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort{
  PhidgetReturnCode result;
  
  PhidgetDigitalInputHandle bt;

  int64_t position;
  //uint32_t position;
  
  //result = PhidgetEncoder_create(&ec);
  result = PhidgetNet_addServer(serverName, ipAddress, networkPort, "", 0);
    if(result != EPHIDGET_OK){
      NSLog(@"error connecting to wireless vint");
    }
  
  result = PhidgetDigitalInput_create(&bt);
  if(result != EPHIDGET_OK){
  	 NSLog(@"error setting digital input channel");
  }


 // result = Phidget_setDeviceSerialNumber(ec, serialNumber);
 // if(result != EPHIDGET_OK){
 //   NSLog(@"error setting serial number for encoder");
 // }
  result = Phidget_setDeviceSerialNumber(bt, serialNumber);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting serial number for digital input");
  }
  
  //result = Phidget_setHubPort(ec, hubPort);
  //if(result != EPHIDGET_OK){
  //  NSLog(@"error setting hub port");
  //}
  
  result = Phidget_setHubPort(bt, 2);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port");
  }

  result = Phidget_setIsHubPortDevice(ch, 2);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port device");
  }

 // result = Phidget_setChannel(ec, 0);
 // if(result != EPHIDGET_OK){
 //   NSLog(@"error setting channel for encoder");
 // }
  
  result = Phidget_setChannel(bt, 0);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting channel for digital input");
  }

  // Handlers
  result = Phidget_setOnAttachHandler(bt, gotAttach, (__bridge void*)self);
  if(result != EPHIDGET_OK){
    NSLog(@"error initializing attach handler");
  }

  // Open connection to phidget
  result = Phidget_open(bt);
  if(result != EPHIDGET_OK){
    NSLog(@"error opening phidget!");
  }
  
  //result = PhidgetEncoder_setPositionChangeTrigger(ch, 0);
  //if(result != EPHIDGET_OK){
  //	  NSLog(@"error positioning dial");
  //}
  
  //result = PhidgetEncoder_setOnPositionChangeHandler(ch, positionChangeHandler, (__bridge void*)self);
  //if(result != EPHIDGET_OK){
  //	  NSLog(@"error setting position!");
  //}
  
  result = PhidgetDigitalInput_setOnStateChangeHandler(bt, gotStateChangeData, (__bridge void*)self);
  if(result != EPHIDGET_OK){
  	  NSLog(@"error setting up DigitalInput");
  }
}

- (void)setEnabled:(int)value channel:(int)channelNumber{
	
	PhidgetEncoder_setEnabled(ch, value);
	NSLog(@"Encoder Enabled!");
}

- (void)setDigitalInput:(int)value channel:(int)channelNumber{
	
	//PhidgetDigitalInput_getState(0, value);
	NSLog(@"DigitalInput Enabled!");
}

- (void)setPosition:(int)value serialNumber:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel{
	NSLog(@"setting encoder value");
	NSLog(@"Position:%d",value);
	PhidgetEncoder_setPosition(ch, value);

}


#pragma mark Event callbacks
void gotAttach(PhidgetHandle phid, void *context, int state){
	int serialNumber;
	int hubPort;
	int position;

	NSLog(@"Phidget Attached");
	Phidget_getDeviceSerialNumber(phid, &serialNumber);
	Phidget_getHubPort(phid, &hubPort);
	PhidgetEncoder_setPosition(phid, 0);
	PhidgetEncoder_setPositionChangeTrigger(phid, 1);

	
    NSDictionary *attachData = [[NSDictionary alloc] initWithObjectsAndKeys:
      [NSNumber numberWithInt:serialNumber],
      @"serial",
      [NSNumber numberWithInt:hubPort],
      @"port",
      nil
    ];
	
    [(__bridge id)context performSelectorOnMainThread:@selector(onAttachHandler:)
                                           withObject:attachData
                                        waitUntilDone:NO];
}

//void stateChangeHandler(PhidgetDigitalInputHandle phid, void *context, int state) {
//	//int input;
//	NSLog(@"Im State Change Handler");
//	//PhidgetDigitalInput_getState(phid, state);
//	PhidgetDigitalInput_OnStateChangeCallback(phid, *context,  int state);
//	
//    NSDictionary *inputData = [[NSDictionary alloc] initWithObjectsAndKeys:
//      [NSNumber numberWithInt:state],
//      @"input",
//      nil
//    ];
//	
//    [(__bridge id)context performSelectorOnMainThread:@selector(onStateChangeHandler:)
//                                           withObject:inputData
//                                        waitUntilDone:NO];
//}

void gotStateChangeData(PhidgetDigitalInputHandle phid, void *context, int state){
	int input;
	PhidgetDigitalInput_getState(phid, &input);
	NSLog(@"Im State Change Handler");
	
    NSDictionary *inputData = [[NSDictionary alloc] initWithObjectsAndKeys:
      [NSNumber numberWithInt:input],
      @"input",
      nil
    ];
		
        [(__bridge id)context performSelectorOnMainThread:@selector(onStateChangeHandler:)
											withObject:inputData
                                               //withObject:[NSNumber numberWithInt:state]
                                            waitUntilDone:NO];
}
void resetPosition(PhidgetEncoderHandle phid, void *context, int positionChange, double timeChange, int indexTriggered){
	PhidgetEncoder_setPosition(phid, 0);
}

void positionChangeHandler(PhidgetEncoderHandle phid, void *context, int positionChange, double timeChange, int indexTriggered){
	int position;
	NSLog(@"Im Position Change Handler");
	PhidgetEncoder_getPosition(phid, &position);
				
			
	
    NSDictionary *positionData = [[NSDictionary alloc] initWithObjectsAndKeys:
      [NSNumber numberWithInt:position],
      @"position",
      nil
    ];
	
    [(__bridge id)context performSelectorOnMainThread:@selector(onPositionChangeHandler:)
                                           withObject:positionData
                                        waitUntilDone:NO];
	//NSLog(@"Position:%d",position); 
	//17200
	//if (position >= 4300){
	//	NSLog(@"Setting back to 0");
	//	PhidgetEncoder_setPosition(phid, 0);
	//}
	//
	//if (position < 0){
	//	NSLog(@"Setting back to 96");
	//	PhidgetEncoder_setPosition(phid, 4300);
	//}
}

static void gotDetach(PhidgetHandle phid, void *context){
    [(__bridge id)context performSelectorOnMainThread:@selector(onDetachHandler)
                                           withObject:nil
                                        waitUntilDone:NO];
}

static void gotError(PhidgetHandle phid, void *context, Phidget_ErrorEventCode errcode, const char *error){
    [(__bridge id)context performSelectorOnMainThread:@selector(errorHandler:)
                                           withObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:errcode], [NSString stringWithUTF8String:error], nil]
                                        waitUntilDone:NO];
}

#pragma mark Attach, detach, data, and error events
- (void)onAttachHandler:(NSDictionary *)attachData{
  NSLog(@"Im Attach Handler");
  
  PhidgetEncoder_setEnabled(ch, 1);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_attached" object:nil userInfo:attachData];
}

- (void)onDetachHandler{
    //Reset
    
}

- (void)onPositionChangeHandler:(NSDictionary *)positionData{
	NSLog(@"Dial has Changed Position");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_position_change" object:nil userInfo:positionData];
}

//- (void)onStateChangeHandler:(NSDictionary *)inputData{
//	NSLog(@"State has changed");
//	[[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_state_change" object:nil userInfo:inputData];
//}

- (void)onStateChangeHandler:(NSDictionary*)inputData{
	NSLog(@"Input has Changed State");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_state_change" object:nil userInfo:inputData];
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"mouse_down_info" object:nil userInfo:inputData];
    //if(inputData.intValue == 1){
	//	NSLog(@"Input = 1");
    //    stateTextField.stringValue = @"T";
    //    stateBox.fillColor = [NSColor whiteColor];
    //    stateTextField.textColor = [NSColor blackColor];
	//	[[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_state_change" object:nil userInfo:inputData];
    //}
    //else{
	//	NSLog(@"Input = 0");
    //    stateTextField.stringValue = @"F";
    //    stateBox.fillColor = [NSColor blackColor];
    //    stateTextField.textColor = [NSColor whiteColor];
	//	[[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_state_change" object:nil userInfo:inputData];
    //}
}


@end

@implementation EncoderInputController

-(void)startEncoderInput:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort{
  PhidgetReturnCode result;
  PhidgetDigitalInputHandle ch;
  NSLog(@"Digimon go!");

  result = PhidgetNet_addServer(serverName, ipAddress, networkPort, "", 0);
    if(result != EPHIDGET_OK){
      NSLog(@"error connecting to wireless vint");
    }
  
  result = PhidgetDigitalInput_create(&ch);
  if(result != EPHIDGET_OK){
    NSLog(@"error creating input for Encoder Input");
  }

  result = Phidget_setDeviceSerialNumber(ch, serialNumber);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting serial number for Encoder Input");
  }

  result = Phidget_setHubPort(ch, hubPort);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port for Encoder Input");
  }

  result = Phidget_setIsHubPortDevice(ch, 2);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port device for Encoder Input");
  }

  result = Phidget_setChannel(ch, deviceChannel);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting channel for Encoder Input");
  }

  // Handlers
  
  result = PhidgetDigitalInput_setOnStateChangeHandler(ch, gotStateChangeDataFromEncoder, (__bridge void*)self);
  if(result != EPHIDGET_OK){
    NSLog(@"error initializing state change handler for Encoder Input");
  }

  // Open connection to phidget
  result = Phidget_open(ch);
  if(result != EPHIDGET_OK){
    NSLog(@"error opening phidget!");
  }
}

#pragma mark Event callbacks

void gotStateChangeDataFromEncoder(PhidgetDigitalInputHandle phid, void *context, int state){
	int input;
	PhidgetDigitalInput_getState(phid, &input);
	NSLog(@"Im State Change Handler For Encoder Button");
	
    NSDictionary *inputDataButton = [[NSDictionary alloc] initWithObjectsAndKeys:
      [NSNumber numberWithInt:input],
      @"input",
      nil
	    ];
		
        [(__bridge id)context performSelectorOnMainThread:@selector(onButtonStateChangeHandler:)
												withObject:inputDataButton
	                                               //withObject:[NSNumber numberWithInt:state]
	                                            waitUntilDone:NO];
}

#pragma mark Attach, detach, data, and error events

- (void)onButtonStateChangeHandler:(NSDictionary*)inputDataButton{
	NSLog(@"Encoder Button has Changed State");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_state_change_from_encoder" object:nil userInfo:inputDataButton];
}


@end

@implementation DigitalInputController

-(void)startDigitalInput:(int)serialNumber port:(int)hubPort  channel:(int)deviceChannel serverName:(const char *)serverName ip:(const char *)ipAddress networkPort:(int)networkPort{
  PhidgetReturnCode result;
  PhidgetDigitalInputHandle ch;
  NSLog(@"Digimon go!");

  result = PhidgetNet_addServer(serverName, ipAddress, networkPort, "", 0);
  if(result != EPHIDGET_OK){
    NSLog(@"error connecting to wireless vint");
  }
  
  result = PhidgetDigitalInput_create(&ch);
  if(result != EPHIDGET_OK){
    NSLog(@"error creating input for Digital Input");
  }

  result = Phidget_setDeviceSerialNumber(ch, serialNumber);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting serial number for Digital Input");
  }

  result = Phidget_setHubPort(ch, hubPort);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port for Digital Input");
  }

  result = Phidget_setIsHubPortDevice(ch, 2);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting hub port device for Digital Input");
  }

  result = Phidget_setChannel(ch, deviceChannel);
  if(result != EPHIDGET_OK){
    NSLog(@"error setting channel for Digital Input");
  }

  // Handlers
  
  result = PhidgetDigitalInput_setOnStateChangeHandler(ch, gotStateChangeDataFromButton, (__bridge void*)self);
  if(result != EPHIDGET_OK){
    NSLog(@"error initializing state change handler for Digital Input");
  }

  // Open connection to phidget
  result = Phidget_open(ch);
  if(result != EPHIDGET_OK){
    NSLog(@"error opening phidget!");
  }
}

#pragma mark Event callbacks

void gotStateChangeDataFromButton(PhidgetDigitalInputHandle phid, void *context, int state){
	int input;
	PhidgetDigitalInput_getState(phid, &input);
	NSLog(@"Im State Change Handler For Reset Button");
	
    NSDictionary *inputDataButton = [[NSDictionary alloc] initWithObjectsAndKeys:
      [NSNumber numberWithInt:input],
      @"input",
      nil
	    ];
		
        [(__bridge id)context performSelectorOnMainThread:@selector(onButtonStateChangeHandler:)
												withObject:inputDataButton
	                                               //withObject:[NSNumber numberWithInt:state]
	                                            waitUntilDone:NO];
}

#pragma mark Attach, detach, data, and error events

- (void)onButtonStateChangeHandler:(NSDictionary*)inputDataButton{
	NSLog(@"Reset Button has Changed State");
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phidget_state_change_from_button" object:nil userInfo:inputDataButton];
}


@end

