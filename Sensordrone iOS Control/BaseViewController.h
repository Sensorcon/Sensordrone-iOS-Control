//
//  BaseViewController.h
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 11/11/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCAppDelegate.h"
#import "SensordroneiOSLibrary.h"
#import "BluetoothBarButtonItem.h"

@interface BaseViewController : UIViewController <DroneEventDelegate>

@property SDCAppDelegate *delegate;
@property BluetoothBarButtonItem *bleStatusIcon;


-(void)setStatusIcon;

@end
