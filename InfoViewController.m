//
//  InfoViewController.m
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 6/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

@synthesize infoView;

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
    NSString *generalInfo;
    generalInfo = @"Conections: \n\n";
    generalInfo = [generalInfo stringByAppendingString:@"Pressing the \"Scan\" button will search for Sensordrones advertising via Bluetooth Low Energy. Sensordrones will populate in the list; selecting one will attempt to connect to it. Pressing the \"Cancel/Disconnect\" button will cancel the scanning process (or disconnect from a Sensordrone if connected). Holding this button for 3 seconds can also cause a force-disconnect command to be sent.\n\n"];
    
    generalInfo = [generalInfo stringByAppendingString:@"Sensor Info:\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Temperature (Ambient):\n"];
    generalInfo = [generalInfo stringByAppendingString:@"This is the Temperature of the environement your Sensordrone is currently in. \n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Humidity:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"This is the Percent Relative Humidity of the environement your Sensordrone is currently in.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Pressure:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"This is the Pressure of the environement your Sensordrone is currently in.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Object Temperature (IR):\n"];
    generalInfo = [generalInfo stringByAppendingString:@"This is the (non-contact) temperature of the object you are pointing your Sensordrone at.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Illuminance:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"The Sensordrone is eqiupped with an RGB color sensor. From these values, you can calculate things like Color, Color Temeprature, and Illuminance. The Lux value provided is calibrated for a (mostly) broadband light source (like incandescent and flurescent bulbs), and won't work well for narrow band light sources like LEDs (without a separate calibration algorithm).\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Precision Gas:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"The precision gas sensor responds to low concentrations of several gases and is calibrated at the factory with carbon monoxide (CO). The units of ppm (parts per million) is a representation of the gas concentration assuming the gas being measured is CO.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Proximity Capacitance:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"The Sensordrone has a proximity capacitance sensor located in the bottom of it's plastic housing. It will react differently to different material. Try a few different things out! It currently measures from 0 to 4 picoFarad with a resolution of 1 femtoFarad.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"External Voltage:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"This is the measured voltage from the Sensordrone's external ADC pin. It accepts 0 to 3 Volts and will read in the millivolt range. The pin is left floating, and will jump around if nothing is plugged into it.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Altitude:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Altitude (above sea level) can be thought of as a psuedo-sensor. The altitude is calculated from the current pressure referenced to pressure at sea-level. Changes in the weather can cause changes in your calculated altitude above sea leavel.\n\n"];
    generalInfo = [generalInfo stringByAppendingString:@"Battery Voltage:\n"];
    generalInfo = [generalInfo stringByAppendingString:@"This is the Sensordrone's current battery voltage level. The Sensordrone uses a Lithium Polymer (LiPo) battery, and therefore will typically read between 4.2 and 3.25 Volts (a low battery is around 3.25 Volts) \n\n"];
    
    generalInfo = [generalInfo stringByAppendingString:@"Different units can be selected on the \"Settings\" tab"];
    [infoView setText:generalInfo];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
