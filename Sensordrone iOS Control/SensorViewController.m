//
//  SensordroneiOSControlSecondViewController.m
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "SensorViewController.h"

@interface SensorViewController ()

@end

@implementation SensorViewController

@synthesize tempUnitKey;
@synthesize pressureUnitKey;
@synthesize irUnitKey;
@synthesize altitudeUnitKey;

@synthesize worldPicture;

// GUI Buttons
@synthesize irSwitch;
@synthesize tempSwitch;
@synthesize humiditySwitch;
@synthesize pressureSwitch;
@synthesize rgbSwitch;
@synthesize precisionSwitch;
@synthesize capacitanceSwitch;
@synthesize adcSwitch;
@synthesize altitudeSwitch;
@synthesize batterySwitch;

// Labels
@synthesize temperatureDisplay;
@synthesize humidityDisplay;
@synthesize pressureDisplay;
@synthesize irtempDisplay;
@synthesize luxDisplay;
@synthesize precisionGasDisplay;
@synthesize capacitanceDisplay;
@synthesize adcDisplay;
@synthesize altitudeDisplay;
@synthesize batteryVoltageDisplay;

// Repeaters
@synthesize adcRepeater;
@synthesize tempRepeater;
@synthesize humidityRepeater;
@synthesize pressureRepeater;
@synthesize luxRepeater;
@synthesize precisionRepeater;
@synthesize capRepeater;
@synthesize altRepeater;
@synthesize batteryVoltageRepeater;
@synthesize irRepeater;

@synthesize delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.delegate = (SDCAppDelegate *)[[UIApplication sharedApplication] delegate];
    // We change this to the delegate while here
    [delegate.aDrone setDelegate:self];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected:)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    worldPicture.userInteractionEnabled = YES;
    [worldPicture addGestureRecognizer:tapGesture];
    
}

-(void)tapDetected:(id)sender {
    temperatureDisplay.text = @"--";
    humidityDisplay.text = @"--";
    pressureDisplay.text = @"--";
    irtempDisplay.text = @"--";
    luxDisplay.text = @"--";
    precisionGasDisplay.text = @"--";
    capacitanceDisplay.text = @"--";
    adcDisplay.text = @"--";
    altitudeDisplay.text = @"--";
    batteryVoltageDisplay.text = @"--";
}

-(void) viewDidAppear:(BOOL)animated {
    if (delegate.aDrone.delegate != self) {
        [delegate.aDrone setDelegate:self];
    }
    [self setTempUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"TEMPERATURE"]];
    [self setPressureUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"PRESSURE"]];
    [self setIrUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"IR"]];
    [self setAltitudeUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"ALTITUDE"]];

    [self.tabBarController setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// T E M P E R A T U R E
-(void)ambientTemperatureToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [tempSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([tempSwitch isOn]) {
        [delegate.aDrone enableAmbientTemperature];
    } else {
        [delegate.aDrone disableAmbientTemperature];
    }

}
-(void) doOnAmbientTemperatureEnabled {
    tempRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureAmbientTemperature) userInfo:nil repeats:NO];
}
-(void) doOnAmbientTemperatureDisabled {
    [tempRepeater invalidate];
}
-(void) doOnAmbientTemperatureMeasured {
    if (tempUnitKey == 0) {
        [temperatureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f F", [delegate.aDrone measuredAmbientTemperatureInFahreneit]] waitUntilDone:NO];
    } else if (tempUnitKey == 1) {
        [temperatureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f C", [delegate.aDrone measuredAmbientTemperatureInCelcius]] waitUntilDone:NO];
    } else if (tempUnitKey == 2) {
        [temperatureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f K", [delegate.aDrone measuredAmbientTemperatureInKelvin]] waitUntilDone:NO];
    }
    

    tempRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureAmbientTemperature) userInfo:nil repeats:NO];
}


// H U M I D I T Y
-(void)humidityToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [humiditySwitch setOn:NO animated:TRUE];
        return;
    }
    if ([humiditySwitch isOn]) {
        [delegate.aDrone enableHumidity];
    } else {
        [delegate.aDrone disableHumidity];
    }
    
}
-(void) doOnHuditiyEnabled {
    humidityRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureHumidity) userInfo:nil repeats:NO];
}
-(void) doOnHuditiyDisabled {
    [humidityRepeater invalidate];
}
-(void) doOnHuditiyMeasured {
    [humidityDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f %%", [delegate.aDrone measuredPercentHumidity]] waitUntilDone:NO];
    humidityRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureHumidity) userInfo:nil repeats:NO];
    
}

// P R E S S U R E
-(void)pressureToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [pressureSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([pressureSwitch isOn]) {
        [delegate.aDrone enablePressure];
    } else {
        if ([delegate.aDrone altitudeStatus]) {
            [self doOnPressureDisabled];
        } else {
            [delegate.aDrone disablePressure];
        }
        
    }
    
}
-(void) doOnPressureEnabled {
    pressureRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measurePressure) userInfo:nil repeats:NO];
}
-(void) doOnPressureDisabled {
    [pressureRepeater invalidate];
}
-(void) doOnPressureMeasured {

    if (pressureUnitKey == 0) {
        [pressureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f Pa", [delegate.aDrone measuredPressureInPascal]] waitUntilDone:NO];
    } else if (pressureUnitKey == 1) {
        [pressureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f Atm", [delegate.aDrone measuredPressureInAtmosphere]] waitUntilDone:NO];
    } else if (pressureUnitKey == 2) {
        [pressureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f Torr", [delegate.aDrone measuredPressureInTorr]] waitUntilDone:NO];
    }
    
    pressureRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measurePressure) userInfo:nil repeats:NO];
    
    
}

// I R

-(void) IRToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [irSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([irSwitch isOn]) {
        [delegate.aDrone enableIRTemperature];
    } else {
        [delegate.aDrone disableIRTemperature];
    }
}
-(void) doOnIRTemperatureEnabled {
    irRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureIRTemperature) userInfo:nil repeats:NO];
}
-(void) doOnIRTemperatureDisabled {
    [irRepeater invalidate];
}
-(void) doOnIRTemperatureMeasured {
    if (irUnitKey == 0) {
        [irtempDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f F", [delegate.aDrone measuredIRTemperatureInFahreneit]] waitUntilDone:NO];
    } else if (irUnitKey == 1) {
        [irtempDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f C", [delegate.aDrone measuredIRTemperatureInCelcius]] waitUntilDone:NO];
    } else if (irUnitKey == 2) {
        [irtempDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f K", [delegate.aDrone measuredIRTemperatureInKelvin]] waitUntilDone:NO];
    }
    
    irRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureIRTemperature) userInfo:nil repeats:NO];
}

// R G B C
-(void) illuminanceToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [rgbSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([rgbSwitch isOn]) {
        [delegate.aDrone enableRGBC];
    } else {
        [delegate.aDrone disableRGBC];
    }
}
-(void) doOnRGBCEnabled {
    luxRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureRGBC) userInfo:nil repeats:NO];
}
-(void) doOnRGBCDisabled {
    [luxRepeater invalidate];
}
-(void) doOnRGBCMeasured {
    [luxDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.0f Lux", [delegate.aDrone measuredRGBCIlluminanceInLux]] waitUntilDone:NO];
    luxRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureRGBC) userInfo:nil repeats:NO];
}

// P R E C I S I O N  G A S
-(void)precisionGasToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [precisionSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([precisionSwitch isOn]) {
        [delegate.aDrone enablePrecisionGas];
    } else {
        [delegate.aDrone disablePrecisionGas];
    }
}

-(void)doOnPrecisonGasEnabled {
    precisionRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measurePrecisionGas) userInfo:nil repeats:NO];
}
-(void) doOnPrecisonGasDisabled {
    [precisionRepeater invalidate];
    
}
-(void) doOnPrecisonGasMeasured {
    [precisionGasDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f ppm", [delegate.aDrone measuredPrecisionGasInPPMCO]] waitUntilDone:NO];
    precisionRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measurePrecisionGas) userInfo:nil repeats:NO];
}

// C A P A C I T A N C E
-(void)capcatianceToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [capacitanceSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([capacitanceSwitch isOn]) {
        [delegate.aDrone enableCapacitance];
    } else {
        [delegate.aDrone disableCapacitance];
    }
}
-(void) doOnCapacitanceEnabled {
        capRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureCapacitance) userInfo:nil repeats:NO];
}
-(void) doOnCapacitanceDisabled {
    [capRepeater invalidate];
}
-(void) doOnCapacitanceMeasured {
    [capacitanceDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.0f fF", [delegate.aDrone measuredCapacitanceInFemtoFarad]] waitUntilDone:NO];
    capRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureCapacitance) userInfo:nil repeats:NO];
}

// A D C
-(void) adcToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [adcSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([adcSwitch isOn]) {
        [delegate.aDrone enableADC];
    } else {
        [delegate.aDrone disableADC];
    }
}
-(void) doOnADCMeasured {
    NSString *display = [[NSString alloc] initWithFormat:@"%.3f V",[delegate.aDrone measuredADCInVolts]];
    [adcDisplay performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:NO];
    adcRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureADC) userInfo:nil repeats:NO];
}

-(void) doOnADCEnabled {
    adcRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureADC) userInfo:nil repeats:NO];
}
-(void) doOnADCDisabled {
    [adcRepeater invalidate];
}

// A L T I T U D E
-(void)altitudeToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [altitudeSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([altitudeSwitch isOn]) {
        [delegate.aDrone enableAltitude];
    } else {
        if ([delegate.aDrone pressureStatus]) {
            // If the pressure sensor is on, don't actually shut it off.
            [self doOnAltitudeDisabled];
        } else {
            [delegate.aDrone disableAltitude];
        }
        
    }
}
-(void) doOnAltitudeEnabled {
    altRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureAltitude) userInfo:nil repeats:NO];
}
-(void) doOnAltitudeDisabled {
    [altRepeater invalidate];
}

-(void) doOnAltitudeMeasured {
    
    if (altitudeUnitKey == 0) {
        [altitudeDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f Ft", [delegate.aDrone measuredAltitudeInFeet]] waitUntilDone:NO];
    } else if (altitudeUnitKey == 1) {
        [altitudeDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f m", [delegate.aDrone measuredAltitudeInMeter]] waitUntilDone:NO];
    }
    altRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureAltitude) userInfo:nil repeats:NO];
}

// B A T T E R Y  V O L T A G E
-(void)batteryVoltageToggled:(id)sender {
    if (![delegate.aDrone isDroneConnected]) {
        [batterySwitch setOn:NO animated:TRUE];
        return;
    }
    if ([batterySwitch isOn]) {
        batteryVoltageRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureDroneBatteryVoltage) userInfo:nil repeats:NO];
    } else {
        [batteryVoltageRepeater invalidate];
    }
}
-(void) doOnBatteryVoltageMeasured {
    [batteryVoltageDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f V", [delegate.aDrone measuredBatteryVoltage]] waitUntilDone:NO];
    if ([batterySwitch isOn]) {
        batteryVoltageRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.aDrone selector:@selector(measureDroneBatteryVoltage) userInfo:nil repeats:NO];
    }
    
}


-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    int selectedIndex = [[tabBarController viewControllers] indexOfObject:viewController];
    
    // Don't let them switch to the connection screen witout turning off sensors
    if (selectedIndex == 0) {
        BOOL allOff = YES;
        allOff = allOff && ![tempSwitch isOn];
        allOff = allOff && ![humiditySwitch isOn];
        allOff = allOff && ![pressureSwitch isOn];
        allOff = allOff && ![irSwitch isOn];
        allOff = allOff && ![rgbSwitch isOn];
        allOff = allOff && ![precisionSwitch isOn];
        allOff = allOff && ![capacitanceSwitch isOn];
        allOff = allOff && ![adcSwitch isOn];
        allOff = allOff && ![altitudeSwitch isOn];
        allOff = allOff && ![batterySwitch isOn];

        if (!allOff) {
            [[[UIAlertView alloc] initWithTitle:@"Whoa!" message:@"Please turn off all of the sensors before going back to the connection screen" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        }
        
        return allOff;
    } else {
        return YES;
    }
}

-(void) doOnConnectionLost {
    if ([tempSwitch isOn]) {
        [tempSwitch setOn:NO animated:YES];
    }
    if ([humiditySwitch isOn]) {
        [humiditySwitch setOn:NO animated:YES];
    }
    if ([pressureSwitch isOn]) {
        [pressureSwitch setOn:NO animated:YES];
    }
    if ([irSwitch isOn]) {
        [irSwitch setOn:NO animated:YES];
    }
    if ([rgbSwitch isOn]) {
        [rgbSwitch setOn:NO animated:YES];
    }
    if ([precisionSwitch isOn]) {
        [precisionSwitch setOn:NO animated:YES];
    }
    if ([capacitanceSwitch isOn]) {
        [capacitanceSwitch setOn:NO animated:YES];
    }
    if ([adcSwitch isOn]) {
        [adcSwitch setOn:NO animated:YES];
    }
    if ([altitudeSwitch isOn]) {
        [altitudeSwitch setOn:NO animated:YES];
    }
    if ([batterySwitch isOn]) {
        [batterySwitch setOn:NO animated:YES];
    }
   
     [[[UIAlertView alloc] initWithTitle:@"Connection lost!" message:@"It seems the connection was lost. Please reconnect from the connections tab" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
