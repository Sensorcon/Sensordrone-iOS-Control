//
//  SensordroneiOSControlFirstViewController.h
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LEConnectionViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *droneList;
@property NSMutableArray *colorNames;

@property NSString *droneName;


- (IBAction)startScan:(id)sender;
- (IBAction)stopScan:(id)sender;
- (IBAction)disconnect:(id)sender;


@end
