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

@synthesize delegate;
@synthesize droneList;
@synthesize colorNames;

@synthesize disconnectButton;
@synthesize droneName;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.delegate = (SDCAppDelegate *)[[UIApplication sharedApplication] delegate];
    // We change this to the delegate while here
    [delegate.aDrone setDelegate:self];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(handleLongPress:)];
    longPress.minimumPressDuration = 3; //seconds
//    longPress.delegate = self;
    [disconnectButton addGestureRecognizer:longPress];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    
    [disconnectButton addGestureRecognizer:tapGesture];
}


-(void) viewDidAppear:(BOOL)animated {
    
    if (delegate.aDrone.delegate != self) {
        [delegate.aDrone setDelegate:self];
    }
    
    if ([delegate.aDrone isDroneConnected]) {
        NSString *connectString = @"Connected: ";
        connectString = [connectString stringByAppendingString:droneName];
        [self.connectionStatus setText:connectString];
    } else {
        [self.connectionStatus setText:@"Not Connected"];
    }
    [droneList reloadData];
}

-(void)viewDidDisappear:(BOOL)animated {
    // Cancel the scan jsut in case
    [delegate.aDrone stopScanningForDrones];
    [delegate.aDrone.scannedDroneNames removeAllObjects];
    [delegate.aDrone.scannedDronePeriperals removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) handleLongPress:(id)sender {
    [delegate.aDrone stopScanningForDrones];
    if ([delegate.aDrone.dronePeripheral isConnected]) {
        [delegate.aDrone.btleManger cancelPeripheralConnection:delegate.aDrone.dronePeripheral];
    }
    
    [delegate.aDrone clearJobQueue];
}

-(void)tapDetected:(id)sender {
    if ([delegate.aDrone isDroneConnected]) {
        [delegate.aDrone setLEDs:0 :0 :0];
    } else {
        [self.connectionStatus setText:@"Not Connected"];
    }
    [delegate.aDrone stopScanningForDrones];
    [delegate.aDrone disconnect];
}

-(void)scanButtonPressed:(id)sender {

    if ([delegate.aDrone isDroneConnected]) {
        [[[UIAlertView alloc] initWithTitle:@"Already connected!" message:@"Please disconnect before trying to connect again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        return;
    }

    if ([delegate.aDrone.btleManger state] == CBCentralManagerStatePoweredOn) {
        [delegate.aDrone scanForDrones];
        [self.connectionStatus setText:@"Scanning..."];
    } else {
        [[[UIAlertView alloc] initWithTitle:@"Bluetooth is not enabled!" message:@"Please enable Bluetooth in the system settings to use this app" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
    

}


// Table Stuff
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [delegate.aDrone.scannedDroneNames count];
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
    cell.textLabel.text = [delegate.aDrone.scannedDroneNames
                           objectAtIndex: [indexPath row]];
    return cell;
}

// On item selected
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [delegate.aDrone stopScanningForDrones];
    [self setDroneName:[delegate.aDrone.scannedDroneNames objectAtIndex:indexPath.row]];
    [delegate.aDrone btleConnect:[delegate.aDrone.scannedDronePeriperals objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.connectionStatus setText:@"Connecting..."];
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([delegate.aDrone isDroneConnected]) {
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
    [delegate.aDrone setLEDs:0 :0 :142];
    // Update the display
    NSString *connectString = @"Connected: ";
    connectString = [connectString stringByAppendingString:droneName];
    [self.connectionStatus setText:connectString];
}

-(void) doOnDisconnect {
    [self.connectionStatus setText:@"Not Connected"];
}

-(void) doOnConnectionLost {
    [self.connectionStatus setText:@"Connection Lost!"];
}

-(void) doOnConnectionFailed {
   [self.connectionStatus setText:@"Connection failed!"]; 
}

@end
