//
//  BluetoothBarButtonItem.h
//  Sensordrone BLE Finder
//
//  Created by Mark Rudolph on 11/4/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

//UIImage* btIconOn;
//UIImage* btIconOff;
//UIImageView* btIconView;

@interface BluetoothBarButtonItem : UIBarButtonItem

@property UIImageView *btIconView;
@property UIImage *btIconOn;
@property UIImage *btIconOff;

-(id)initWithSetup;
-(id)initWithSize:(int)width:(int)height;

-(void)showConnected;
-(void)showDisconnected;
-(void)setSize:(int) width: (int) height;

@end
