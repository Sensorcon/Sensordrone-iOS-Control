//
//  SensordroneiOSControlAppDelegate.m
//  Sensordrone iOS Control
//
//  Created by Mark Rudolph on 5/28/13.
//  Copyright (c) 2013 Sensorcon, Inc. All rights reserved.
//

#import "SDCAppDelegate.h"

@implementation SDCAppDelegate

@synthesize myDrone;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    self.myDrone = [[Drone alloc] initWithDelegate:self];
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //
    
    // If a user puts the application in the background, disconnect the device.
    if ([myDrone.dronePeripheral isConnected]) {
        [myDrone.btleManger cancelPeripheralConnection:myDrone.dronePeripheral];
    }
    // Clear the NSOperationQueue of any jobs taht didn't get processed.
    [myDrone clearJobQueue];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    // Clear the NSOperationQueue of any jobs taht didn't get processed.
    [myDrone clearJobQueue];
    [myDrone clearJobQueue];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)showConnectionLostDialog {
    [[[UIAlertView alloc] initWithTitle:@"Connection lost!" message:@"It seems the connection was lost. Please reconnect from the connections page" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}

@end
