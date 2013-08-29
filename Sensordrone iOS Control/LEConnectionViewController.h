//
//  SensordroneiOSControlFirstViewController.h
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensordroneiOSLibrary.h"
#import "SDCAppDelegate.h"

@interface LEConnectionViewController : UIViewController <DroneEventDelegate, UITableViewDelegate, UITableViewDataSource>

@property SDCAppDelegate *delegate;
@property (weak, nonatomic) IBOutlet UITableView *droneList;
@property NSMutableArray *colorNames;
@property (weak, nonatomic) IBOutlet UILabel *connectionStatus;
@property (weak, nonatomic) IBOutlet UIButton *disconnectButton;

@property NSString *droneName;


// Our first view
-(IBAction)scanButtonPressed:(id)sender;
//-(IBAction)disconnectButtonPressed:(id)sender;
-(void)handleLongPress:(id)sender;
-(void)tapDetected:(id)sender;
@end
