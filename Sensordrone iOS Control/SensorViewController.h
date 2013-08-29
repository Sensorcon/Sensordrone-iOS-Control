//
//  SensordroneiOSControlSecondViewController.h
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SensordroneiOSLibrary.h"
#import "SDCAppDelegate.h"

@interface SensorViewController : UIViewController <DroneEventDelegate, UITabBarControllerDelegate>

// Switches
@property (weak, nonatomic) IBOutlet UISwitch *tempSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *humiditySwitch;
@property (weak, nonatomic) IBOutlet UISwitch *pressureSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *irSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *rgbSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *precisionSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *capacitanceSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *adcSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *altitudeSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *batterySwitch;

@property (weak, nonatomic) IBOutlet UIImageView *worldPicture;


// Display Fields
@property (weak, nonatomic) IBOutlet UILabel *temperatureDisplay;
@property (weak, nonatomic) IBOutlet UILabel *humidityDisplay;
@property (weak, nonatomic) IBOutlet UILabel *pressureDisplay;
@property (weak, nonatomic) IBOutlet UILabel *irtempDisplay;
@property (weak, nonatomic) IBOutlet UILabel *luxDisplay;
@property (weak, nonatomic) IBOutlet UILabel *precisionGasDisplay;
@property (weak, nonatomic) IBOutlet UILabel *capacitanceDisplay;
@property (weak, nonatomic) IBOutlet UILabel *adcDisplay;
@property (weak, nonatomic) IBOutlet UILabel *altitudeDisplay;
@property (weak, nonatomic) IBOutlet UILabel *batteryVoltageDisplay;


@property SDCAppDelegate *delegate;

@property NSInteger tempUnitKey;
@property NSInteger pressureUnitKey;
@property NSInteger altitudeUnitKey;
@property NSInteger irUnitKey;

@property NSTimer *adcRepeater;
@property NSTimer *tempRepeater;
@property NSTimer *humidityRepeater;
@property NSTimer *pressureRepeater;
@property NSTimer *luxRepeater;
@property NSTimer *precisionRepeater;
@property NSTimer *capRepeater;
@property NSTimer *altRepeater;
@property NSTimer *batteryVoltageRepeater;
@property NSTimer *irRepeater;

-(IBAction)ambientTemperatureToggled:(id)sender;
-(IBAction)humidityToggled:(id)sender;
-(IBAction)pressureToggled:(id)sender;
-(IBAction)IRToggled:(id)sender;
-(IBAction)illuminanceToggled:(id)sender;
-(IBAction)precisionGasToggled:(id)sender;
-(IBAction)capcatianceToggled:(id)sender;
-(IBAction)adcToggled:(id)sender;
-(IBAction)altitudeToggled:(id)sender;
-(IBAction)batteryVoltageToggled:(id)sender;

-(void) tapDetected:(id)sender;

@end
