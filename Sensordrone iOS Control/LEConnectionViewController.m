//
//  SensordroneiOSControlFirstViewController.m
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "LEConnectionViewController.h"

@interface LEConnectionViewController ()

@end

@implementation LEConnectionViewController

@synthesize droneList;
@synthesize colorNames;

@synthesize droneName;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [droneList reloadData];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // Cancel the scan jsut in case
    [self.delegate.myDrone stopScanningForDrones];
    [self.delegate.myDrone.scannedDroneNames removeAllObjects];
    [self.delegate.myDrone.scannedDronePeriperals removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)startScan:(id)sender {
    if ([self.delegate.myDrone isDroneConnected]) {
        [[[UIAlertView alloc] initWithTitle:@"Already connected!" message:@"Please disconnect before trying to connect again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }
    
    if ([self.delegate.myDrone.btleManger state] == CBCentralManagerStatePoweredOn) {
        [self.delegate.myDrone scanForDrones];
        NSLog(@"Scanning...");
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Bluetooth is not enabled!" message:@"Please enable Bluetooth in the system settings to use this app" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

- (IBAction)stopScan:(id)sender {
    [self.delegate.myDrone stopScanningForDrones];
}

- (IBAction)disconnect:(id)sender {
    [self.delegate.myDrone disconnect];
}


// Table Stuff
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.delegate.myDrone.scannedDroneNames count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    cell.textLabel.text = [self.delegate.myDrone.scannedDroneNames
                           objectAtIndex: [indexPath row]];
    return cell;
}

// On item selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate.myDrone stopScanningForDrones];
    [self setDroneName:[self.delegate.myDrone.scannedDroneNames objectAtIndex:indexPath.row]];
    [self.delegate.myDrone btleConnect:[self.delegate.myDrone.scannedDronePeriperals objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate.myDrone isDroneConnected]) {
        [[[UIAlertView alloc] initWithTitle:@"Already connected!" message:@"Please disconnect before trying to connect again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return nil;
    } else {
        return indexPath;
    }
}



// Our implementation of the Sensordrone Potocol
-(void) doOnFoundDrone {
    [droneList reloadData];
}

-(void) doOnConnect {
    // Turn on the lights
    [self.delegate.myDrone setLEDs:0 :0 :142];
    // Update the display
    NSString *connectString = @"Connected: ";
    connectString = [connectString stringByAppendingString:droneName];
    [self.bleStatusIcon showConnected];
    [[[UIAlertView alloc] initWithTitle:@"Connected" message:@"You have successfully connected!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];

}

-(void) doOnDisconnect {
    [self.bleStatusIcon showDisconnected];
    [[[UIAlertView alloc] initWithTitle:@"Disconnected" message:@"You have successfully disconnected" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

-(void) doOnConnectionLost {
    [self.bleStatusIcon showDisconnected];
    [self.delegate showConnectionLostDialog];

}

-(void) doOnConnectionFailed {
    [[[UIAlertView alloc] initWithTitle:@"Connection Failed!" message:@"Connection was not successful. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
