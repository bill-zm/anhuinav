//
//  AppDelegate.m
//
//  Created by Reese on 16-6-3.
//  Copyright (c) 2016年 Reese. All rights reserved.
//
#import "AppDelegate.h"
#import "FNLoginViewController.h"
//#import "FNavViewController.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    FNLoginViewController *fnController = [[FNLoginViewController alloc] initWithNibName:@"FNLoginViewController" bundle:nil];
    self.window.rootViewController = fnController;
    [self.window makeKeyAndVisible];
    return YES;
}
@end
