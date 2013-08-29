//
//  SensordroneiOSControlAppDelegate.h
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensordroneiOSLibrary.h"


@interface SDCAppDelegate : UIResponder <UIApplicationDelegate, DroneEventDelegate> 


@property (strong, nonatomic) UIWindow *window;
@property Drone *aDrone;

@end
