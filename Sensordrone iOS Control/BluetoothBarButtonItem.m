//
//  BluetoothBarButtonItem.m
//  Sensordrone BLE Finder
//
//  Created by Mark Rudolph on 11/4/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "BluetoothBarButtonItem.h"

@implementation BluetoothBarButtonItem

@synthesize btIconView;
@synthesize btIconOn;
@synthesize btIconOff;



-(id)initWithSetup {
    btIconOn = [UIImage imageNamed:@"bluetooth_on.png"];
    btIconOff = [UIImage imageNamed:@"bluetooth_off.png"];
    btIconView = [[UIImageView alloc] initWithImage:btIconOff];
    [btIconView setContentMode:UIViewContentModeScaleToFill];
    self = [super initWithCustomView:btIconView];
    [self setSize:32 :32];
    return self;
}

-(id)initWithSize:(int)width :(int)height {
    btIconOn = [UIImage imageNamed:@"bluetooth_on.png"];
    btIconOff = [UIImage imageNamed:@"bluetooth_off.png"];
    btIconView = [[UIImageView alloc] initWithImage:btIconOff];
    [btIconView setContentMode:UIViewContentModeScaleToFill];
    self = [super initWithCustomView:btIconView];
    [self setSize:width :height];
    return self;
}



-(void)setSize:(int)width :(int)height {
    self.btIconView.frame = CGRectMake(0, 0, width, height);
}

-(void)showConnected {
    [self.btIconView setImage:btIconOn];
}

-(void)showDisconnected {
    [self.btIconView setImage:btIconOff];
}

@end
