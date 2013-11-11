//
//  SensordroneiOSControlThirdViewController.h
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface PreferenceViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *btnTempF;
@property (weak, nonatomic) IBOutlet UIButton *btnTempC;
@property (weak, nonatomic) IBOutlet UIButton *btnTempK;
@property (weak, nonatomic) IBOutlet UIButton *btnPresP;
@property (weak, nonatomic) IBOutlet UIButton *btnPresAtm;
@property (weak, nonatomic) IBOutlet UIButton *btnPresTorr;
@property (weak, nonatomic) IBOutlet UIButton *btnIRF;
@property (weak, nonatomic) IBOutlet UIButton *btnIRC;
@property (weak, nonatomic) IBOutlet UIButton *btnIRK;
@property (weak, nonatomic) IBOutlet UIButton *btnAltF;
@property (weak, nonatomic) IBOutlet UIButton *btnAltM;

-(IBAction)clickedAmbientTemp:(id)sender;
-(IBAction)clickedPressure:(id)sender;
-(IBAction)clickedIR:(id)sender;
-(IBAction)clickedAltitude:(id)sender;


@property UIAlertView *unitAlert;

@end
