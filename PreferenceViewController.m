//
//  SensordroneiOSControlThirdViewController.m
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "PreferenceViewController.h"

@interface PreferenceViewController ()

@end

@implementation PreferenceViewController

@synthesize unitAlert;

@synthesize btnAltF;
@synthesize btnAltM;
@synthesize btnIRC;
@synthesize btnIRF;
@synthesize btnIRK;
@synthesize btnPresAtm;
@synthesize btnPresP;
@synthesize btnPresTorr;
@synthesize btnTempC;
@synthesize btnTempF;
@synthesize btnTempK;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    unitAlert = [[UIAlertView alloc] initWithTitle:@"Unit Choice Saved" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Temp btns
-(void)clickedAmbientTemp:(id)sender {
    if (sender == btnTempK) {
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"TEMPERATURE"];
        [unitAlert setMessage:@"Kelvin will be displayed for Ambient Temperature"];
    } else if (sender == btnTempF) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"TEMPERATURE"];
        [unitAlert setMessage:@"Fahrenheit will be displayed for Ambient Temperature"];
    } else if (sender == btnTempC) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"TEMPERATURE"];
        [unitAlert setMessage:@"Celcius will be displayed for Ambient Temperature"];
    }
    [unitAlert show];
}

// Pressure
-(void)clickedPressure:(id)sender {
    if (sender == btnPresAtm) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"PRESSURE"];
        [unitAlert setMessage:@"Atmosphere will be displayed for Pressure"];
    } else if (sender == btnPresP) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"PRESSURE"];
        [unitAlert setMessage:@"Pascal will be displayed for Pressure"];
    } else if (sender == btnPresTorr) {
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"PRESSURE"];
        [unitAlert setMessage:@"Torr will be displayed for Pressure"];
    }
    [unitAlert show];
}

//IR
-(void)clickedIR:(id)sender {
    if (sender == btnIRK) {
        [[NSUserDefaults standardUserDefaults] setInteger:2 forKey:@"IR"];
        [unitAlert setMessage:@"Kelvin will be displayed for IR Temperature"];
    } else if (sender == btnIRF) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"IR"];
        [unitAlert setMessage:@"Fahrenheit will be displayed for IR Temperature"];
    } else if (sender == btnIRC) {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"IR"];
        [unitAlert setMessage:@"Celcius will be displayed for IR Temperature"];
    }
    [unitAlert show];
}

// Altitude
- (void) clickedAltitude:(id)sender {
    if (sender == btnAltF) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"ALTITUDE"];
        [unitAlert setMessage:@"Feet will be displayed for Altitude"];
    } else if (sender == btnAltM){
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"ALTITUDE"];
        [unitAlert setMessage:@"Meters will be displayed for Altitude"];
    }
    [unitAlert show];
}

@end
