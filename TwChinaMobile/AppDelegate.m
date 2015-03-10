//
//  AppDelegate.m
//  TwChinaMobile
//
//  Created by tw on 15-1-31.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "AppDelegate.h"
#import "LeveyTabBarController.h"
#import "GlobalData.h"
#include "constant.h"
#import "MyNavViewController.h"

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // 加载全局数据
    [[GlobalData sharedSingleton] setAccount: @"13888888888"];
    
    g_windowsBounds = [ UIScreen mainScreen ].bounds;
    g_applicationFrame = [ UIScreen mainScreen ].applicationFrame;
    g_screenWidth = g_windowsBounds.size.width;
    g_screenHeight = g_windowsBounds.size.height;
    
    // 主视图控制器
	_mainViewController = [[LeveyTabBarController alloc] init];
    
    // 主导航vc
    //MyNavViewController *myNavViewController = [[MyNavViewController alloc] initWithRootViewController:_mainViewController];
    UINavigationController *myNavViewController = [[UINavigationController alloc] initWithRootViewController:_mainViewController];
    myNavViewController.navigationBar.tintColor = [UIColor redColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = myNavViewController;
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

// tabbar 相关接口
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSLog(@"select tab bar");
}

- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    NSLog(@"didEndCustomizingViewControllers");
}

- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers
{
    
}

- (void)tabBarController:(UITabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
    
}

@end
