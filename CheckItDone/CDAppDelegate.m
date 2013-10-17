//
//  CDAppDelegate.m
//  CheckItDone
//
//  Created by Scott Richards on 9/11/13.
//  Copyright (c) 2013 Scott Richards. All rights reserved.
//

#import "CDAppDelegate.h"

#import "CDFirstViewController.h"
#import "CDSecondViewController.h"
#import "CDTaskViewController.h"
#import "CDTableViewController.h"
#import "CDTaskStore.h"
#import "CDListViewController.h"
#import "CDListStore.h"
#import "CDDataModel.h"

@implementation CDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.

//    CDTableViewController *itemsViewController = [[CDTableViewController alloc]init];
    CDListViewController *itemsViewController = [[CDListViewController alloc]init];
    // Create an instance of a UINavigationController
    // its stack contains only itemsViewController
    UINavigationController *navController = [[UINavigationController alloc]
                                             initWithRootViewController:itemsViewController];
    [[self window] setRootViewController:navController]; 
    [self.window makeKeyAndVisible];
//    self.dataModel = [[CDDataModel alloc] init];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    BOOL success = [[CDTaskStore sharedStore] saveChanges];
//    BOOL success = [self.dataModel saveChanges];
    if (success) {
        NSLog(@"Saved all of the BNRItems");
    } else {
        NSLog(@"Could not save any of the BNRItems");
    }
    success = [[CDListStore sharedStore] saveChanges];
    if (success) {
        NSLog(@"Saved all of the Lists");
    } else {
        NSLog(@"Could not save any of the Lists");
    }
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

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
