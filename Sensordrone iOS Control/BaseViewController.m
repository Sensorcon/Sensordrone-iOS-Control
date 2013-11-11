//
//  BaseViewController.m
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 11/11/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    //
    self.bleStatusIcon = [[BluetoothBarButtonItem alloc] initWithSetup];
    self.navigationItem.rightBarButtonItem = self.bleStatusIcon;
    self.delegate = (SDCAppDelegate *)[[UIApplication sharedApplication] delegate];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // When we appear, we want to become the LE delegate
    if ([self.delegate.myDrone delegate] != self) {
        [self.delegate.myDrone setDelegate:self];
    }

    // Update our bleStatusIcon to show BLE connection status
    [self setStatusIcon];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setStatusIcon {
    if ([self.delegate.myDrone isDroneConnected]) {
        [self.bleStatusIcon showConnected];
    }
    else {
        [self.bleStatusIcon showDisconnected];
    }
}
@end
