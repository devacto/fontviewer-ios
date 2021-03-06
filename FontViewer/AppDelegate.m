//
//  AppDelegate.m
//  FontViewer
//
//  Created by Victor Wibisono on 22/09/13.
//  Copyright (c) 2013 Victor Wibisono. All rights reserved.
//

#import "AppDelegate.h"

#import "TableViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self loadFirstTimeSettings];
    
    // Setting TableViewController and NavigationViewController
    UIViewController *tableViewController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    tableViewController.title = @"Font Catalogue";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    // Override point for customization after application launch.
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];

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
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - First load handler

- (void)loadFirstTimeSettings
{
    if ([self getUsedCounter] <= 1) {
        [AppDelegate setDefaultSettings];
        [self incrementUsedCounter];
    }
}

- (NSInteger)getUsedCounter
{
    NSInteger counter = [[NSUserDefaults standardUserDefaults] integerForKey:@"usedCounter"];
    return counter;
}

- (void)incrementUsedCounter
{
    NSInteger counter = [[NSUserDefaults standardUserDefaults] integerForKey:@"usedCounter"];
    counter++;
    [[NSUserDefaults standardUserDefaults] setInteger:counter forKey:@"usedCounter"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)setDefaultSettings
{
    // Setting text alignment to 0 - which is LEFT.
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"TextAlignmentIndex"];
    
    // Setting sort by index to 0 - which is ALPHABETICAL ORDER
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"SortByIndex"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ReverseCharacterBool"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"SortAscendingBool"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
