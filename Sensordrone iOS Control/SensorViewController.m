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
@synthesize toggleArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toggleArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 10; i++) {
        [self.toggleArray addObject:[NSNumber numberWithBool:NO]];
    }

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
    [super viewDidAppear:animated];
    
    [self setTempUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"TEMPERATURE"]];
    [self setPressureUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"PRESSURE"]];
    [self setIrUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"IR"]];
    [self setAltitudeUnitKey:[[NSUserDefaults standardUserDefaults] integerForKey:@"ALTITUDE"]];

    [self reToggle];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// T E M P E R A T U R E
-(void)ambientTemperatureToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [tempSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([tempSwitch isOn]) {
        [delegate.myDrone enableAmbientTemperature];
    } else {
        [delegate.myDrone disableAmbientTemperature];
    }

}
-(void) doOnAmbientTemperatureEnabled {
    tempRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureAmbientTemperature) userInfo:nil repeats:NO];
}
-(void) doOnAmbientTemperatureDisabled {
    [tempRepeater invalidate];
}
-(void) doOnAmbientTemperatureMeasured {
    if (tempUnitKey == 0) {
        [temperatureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f F", [delegate.myDrone measuredAmbientTemperatureInFahreneit]] waitUntilDone:NO];
    } else if (tempUnitKey == 1) {
        [temperatureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f C", [delegate.myDrone measuredAmbientTemperatureInCelcius]] waitUntilDone:NO];
    } else if (tempUnitKey == 2) {
        [temperatureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f K", [delegate.myDrone measuredAmbientTemperatureInKelvin]] waitUntilDone:NO];
    }
    

    tempRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureAmbientTemperature) userInfo:nil repeats:NO];
}


// H U M I D I T Y
-(void)humidityToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [humiditySwitch setOn:NO animated:TRUE];
        return;
    }
    if ([humiditySwitch isOn]) {
        [delegate.myDrone enableHumidity];
    } else {
        [delegate.myDrone disableHumidity];
    }
    
}
-(void) doOnHuditiyEnabled {
    humidityRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureHumidity) userInfo:nil repeats:NO];
}
-(void) doOnHuditiyDisabled {
    [humidityRepeater invalidate];
}
-(void) doOnHuditiyMeasured {
    [humidityDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.1f %%", [delegate.myDrone measuredPercentHumidity]] waitUntilDone:NO];
    humidityRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureHumidity) userInfo:nil repeats:NO];
    
}

// P R E S S U R E
-(void)pressureToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [pressureSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([pressureSwitch isOn]) {
        [delegate.myDrone enablePressure];
    } else {
        if ([delegate.myDrone altitudeStatus]) {
            [self doOnPressureDisabled];
        } else {
            [delegate.myDrone disablePressure];
        }
        
    }
    
}
-(void) doOnPressureEnabled {
    pressureRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measurePressure) userInfo:nil repeats:NO];
}
-(void) doOnPressureDisabled {
    [pressureRepeater invalidate];
}
-(void) doOnPressureMeasured {

    if (pressureUnitKey == 0) {
        [pressureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f Pa", [delegate.myDrone measuredPressureInPascal]] waitUntilDone:NO];
    } else if (pressureUnitKey == 1) {
        [pressureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f Atm", [delegate.myDrone measuredPressureInAtmosphere]] waitUntilDone:NO];
    } else if (pressureUnitKey == 2) {
        [pressureDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f Torr", [delegate.myDrone measuredPressureInTorr]] waitUntilDone:NO];
    }
    
    pressureRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measurePressure) userInfo:nil repeats:NO];
    
    
}

// I R

-(void) IRToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [irSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([irSwitch isOn]) {
        [delegate.myDrone enableIRTemperature];
    } else {
        [delegate.myDrone disableIRTemperature];
    }
}
-(void) doOnIRTemperatureEnabled {
    irRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureIRTemperature) userInfo:nil repeats:NO];
}
-(void) doOnIRTemperatureDisabled {
    [irRepeater invalidate];
}
-(void) doOnIRTemperatureMeasured {
    if (irUnitKey == 0) {
        [irtempDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f F", [delegate.myDrone measuredIRTemperatureInFahreneit]] waitUntilDone:NO];
    } else if (irUnitKey == 1) {
        [irtempDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f C", [delegate.myDrone measuredIRTemperatureInCelcius]] waitUntilDone:NO];
    } else if (irUnitKey == 2) {
        [irtempDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f K", [delegate.myDrone measuredIRTemperatureInKelvin]] waitUntilDone:NO];
    }
    
    irRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureIRTemperature) userInfo:nil repeats:NO];
}

// R G B C
-(void) illuminanceToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [rgbSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([rgbSwitch isOn]) {
        [delegate.myDrone enableRGBC];
    } else {
        [delegate.myDrone disableRGBC];
    }
}
-(void) doOnRGBCEnabled {
    luxRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureRGBC) userInfo:nil repeats:NO];
}
-(void) doOnRGBCDisabled {
    [luxRepeater invalidate];
}
-(void) doOnRGBCMeasured {
    [luxDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.0f Lux", [delegate.myDrone measuredRGBCIlluminanceInLux]] waitUntilDone:NO];
    luxRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureRGBC) userInfo:nil repeats:NO];
}

// P R E C I S I O N  G A S
-(void)precisionGasToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [precisionSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([precisionSwitch isOn]) {
        [delegate.myDrone enablePrecisionGas];
    } else {
        [delegate.myDrone disablePrecisionGas];
    }
}

-(void)doOnPrecisonGasEnabled {
    precisionRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measurePrecisionGas) userInfo:nil repeats:NO];
}
-(void) doOnPrecisonGasDisabled {
    [precisionRepeater invalidate];
    
}
-(void) doOnPrecisonGasMeasured {
    [precisionGasDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.1f ppm", [delegate.myDrone measuredPrecisionGasInPPMCO]] waitUntilDone:NO];
    precisionRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measurePrecisionGas) userInfo:nil repeats:NO];
}

// C A P A C I T A N C E
-(void)capcatianceToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [capacitanceSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([capacitanceSwitch isOn]) {
        [delegate.myDrone enableCapacitance];
    } else {
        [delegate.myDrone disableCapacitance];
    }
}
-(void) doOnCapacitanceEnabled {
        capRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureCapacitance) userInfo:nil repeats:NO];
}
-(void) doOnCapacitanceDisabled {
    [capRepeater invalidate];
}
-(void) doOnCapacitanceMeasured {
    [capacitanceDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@" %.0f fF", [delegate.myDrone measuredCapacitanceInFemtoFarad]] waitUntilDone:NO];
    capRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureCapacitance) userInfo:nil repeats:NO];
}

// A D C
-(void) adcToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [adcSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([adcSwitch isOn]) {
        [delegate.myDrone enableADC];
    } else {
        [delegate.myDrone disableADC];
    }
}
-(void) doOnADCMeasured {
    NSString *display = [[NSString alloc] initWithFormat:@"%.3f V",[delegate.myDrone measuredADCInVolts]];
    [adcDisplay performSelectorOnMainThread:@selector(setText:) withObject:display waitUntilDone:NO];
    adcRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureADC) userInfo:nil repeats:NO];
}

-(void) doOnADCEnabled {
    adcRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureADC) userInfo:nil repeats:NO];
}
-(void) doOnADCDisabled {
    [adcRepeater invalidate];
}

// A L T I T U D E
-(void)altitudeToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [altitudeSwitch setOn:NO animated:TRUE];
        return;
    }
    if ([altitudeSwitch isOn]) {
        [delegate.myDrone enableAltitude];
    } else {
        if ([delegate.myDrone pressureStatus]) {
            // If the pressure sensor is on, don't actually shut it off.
            [self doOnAltitudeDisabled];
        } else {
            [delegate.myDrone disableAltitude];
        }
        
    }
}
-(void) doOnAltitudeEnabled {
    altRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureAltitude) userInfo:nil repeats:NO];
}
-(void) doOnAltitudeDisabled {
    [altRepeater invalidate];
}

-(void) doOnAltitudeMeasured {
    
    if (altitudeUnitKey == 0) {
        [altitudeDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f Ft", [delegate.myDrone measuredAltitudeInFeet]] waitUntilDone:NO];
    } else if (altitudeUnitKey == 1) {
        [altitudeDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.0f m", [delegate.myDrone measuredAltitudeInMeter]] waitUntilDone:NO];
    }
    altRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureAltitude) userInfo:nil repeats:NO];
}

// B A T T E R Y  V O L T A G E
-(void)batteryVoltageToggled:(id)sender {
    if (![delegate.myDrone isDroneConnected]) {
        [batterySwitch setOn:NO animated:TRUE];
        return;
    }
    if ([batterySwitch isOn]) {
        batteryVoltageRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureDroneBatteryVoltage) userInfo:nil repeats:NO];
    } else {
        [batteryVoltageRepeater invalidate];
    }
}
-(void) doOnBatteryVoltageMeasured {
    [batteryVoltageDisplay performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%.2f V", [delegate.myDrone measuredBatteryVoltage]] waitUntilDone:NO];
    if ([batterySwitch isOn]) {
        batteryVoltageRepeater = [NSTimer scheduledTimerWithTimeInterval:1.0 target:delegate.myDrone selector:@selector(measureDroneBatteryVoltage) userInfo:nil repeats:NO];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self toggleAllOff];
}


-(void) doOnConnectionLost {
    [self.bleStatusIcon showDisconnected];
    
    [self toggleAllOff];
    

    [self.delegate showConnectionLostDialog];
}

-(void)reToggle {
    if ([self.delegate.myDrone isDroneConnected]) {
        // 0
        if ([[self.toggleArray objectAtIndex:0] boolValue]) {
            [tempSwitch setOn:YES animated:YES];
            [self ambientTemperatureToggled:self.tempSwitch];
        }
        // 1
        if ([[self.toggleArray objectAtIndex:1] boolValue]) {
            [humiditySwitch setOn:YES animated:YES];
            [self humidityToggled:self.humiditySwitch];
        }
        // 2
        if ([[self.toggleArray objectAtIndex:2] boolValue]) {
            [pressureSwitch setOn:YES animated:YES];
            [self pressureToggled:self.pressureSwitch];
        }
        // 3
        if ([[self.toggleArray objectAtIndex:3] boolValue]) {
            [irSwitch setOn:YES animated:YES];
            [self IRToggled:self.irSwitch];
        }
        // 4
        if ([[self.toggleArray objectAtIndex:4] boolValue]) {
            [rgbSwitch setOn:YES animated:YES];
            [self illuminanceToggled:self.rgbSwitch];
        }
        // 5
        if ([[self.toggleArray objectAtIndex:5] boolValue]) {
            [precisionSwitch setOn:YES animated:YES];
            [self precisionGasToggled:self.precisionSwitch];
        }
        // 6
        if ([[self.toggleArray objectAtIndex:6] boolValue]) {
            [capacitanceSwitch setOn:YES animated:YES];
            [self capcatianceToggled:self.capacitanceSwitch];
        }
        // 7
        if ([[self.toggleArray objectAtIndex:7] boolValue]) {
            [adcSwitch setOn:YES animated:YES];
            [self adcToggled:self.adcSwitch];
        }
        // 8
        if ([[self.toggleArray objectAtIndex:8] boolValue]) {
            [altitudeSwitch setOn:YES animated:YES];
            [self altitudeToggled:self.altitudeSwitch];
        }
        // 9
        if ([[self.toggleArray objectAtIndex:9] boolValue]) {
            [batterySwitch setOn:YES animated:YES];
            [self batteryVoltageToggled:self.batterySwitch];
        }
    }
}

-(void)toggleAllOff {
    if ([tempSwitch isOn]) {
        [tempSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:0 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([humiditySwitch isOn]) {
        [humiditySwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:1 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([pressureSwitch isOn]) {
        [pressureSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([irSwitch isOn]) {
        [irSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:3 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:3 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([rgbSwitch isOn]) {
        [rgbSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:4 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:4 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([precisionSwitch isOn]) {
        [precisionSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:5 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:5 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([capacitanceSwitch isOn]) {
        [capacitanceSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:6 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:6 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([adcSwitch isOn]) {
        [adcSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:7 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:7 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([altitudeSwitch isOn]) {
        [altitudeSwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:8 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:8 withObject:[NSNumber numberWithBool:NO]];
    }
    
    if ([batterySwitch isOn]) {
        [batterySwitch setOn:NO animated:YES];
        [self.toggleArray replaceObjectAtIndex:9 withObject:[NSNumber numberWithBool:YES]];
    }
    else {
        [self.toggleArray replaceObjectAtIndex:9 withObject:[NSNumber numberWithBool:NO]];
    }
}
@end
