//
//  AppDelegate.m
//  LifeLogger
//
//  Created by John Mulvey on 5/19/18.
//  Copyright © 2018 mulvsoft. All rights reserved.
//

//@import GoogleMobileAds;

#import "AppDelegate.h"
#import "MSFeatureLifeLogger.h"
#import "MSMobilecore.h"
//#import <MSMobilecore/MSMobilecore.h>


// ca-app-pub-5690864134174270~9653299055

@interface AppDelegate ()
@property (nonatomic,strong) MMDrawerController* drawerController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   
  // [[GADMobileAds sharedInstance] startWithCompletionHandler:nil];
  
    [MSMobileCore instance].coreResourceDelegate = [MSFeatureLifeLogger instance];
  
    [[MSMobileCore instance] startMobileCore];
    

    [[MSFeatureLifeLogger instance] initCatagories];

    
    UINavigationController* navControllerCenter = (UINavigationController*)[MSFeatureLifeLogger BuildScreenforStack:nil withNavController:nil screen:MSLifeLoggerScreenCenterView];
    
    UINavigationController* navControllerLeft =  (UINavigationController*)[MSFeatureLifeLogger BuildScreenforStack:nil withNavController:nil screen:MSLifeLoggerScreenLeftView];
    
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navControllerCenter leftDrawerViewController:navControllerLeft];
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setRestorationIdentifier:@"MMDrawer"];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
   [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModePanningCenterView];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModePanningCenterView];
    

    
    self.window.rootViewController = self.drawerController;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
