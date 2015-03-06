//
//  AppDelegate.m
//  TwChinaMobile
//
//  Created by tw on 15-1-31.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "AppDelegate.h"
#import "LeveyTabBarController.h"
#import "LiuliangViewController.h"
#import "WoDeViewController.h"
#import "CustomTabBarViewController.h"
#import "GlobalData.h"
#include "constant.h"



@implementation AppDelegate

@synthesize window;
@synthesize leveyTabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // 加载全局数据
    [[GlobalData sharedSingleton] setAccount: @"13812345678"];
    
    g_windowsBounds = [ UIScreen mainScreen ].bounds;
    g_applicationFrame = [ UIScreen mainScreen ].applicationFrame;
    
//    // tabbarvc 的 vc 列表
//    NSMutableArray *controllers = [NSMutableArray  array];
//    
//    // 创建主 tabbarvc 中的所有 vc
//    // 1. 流量 vc
//    LiuliangViewController *liuLiangVC = [[LiuliangViewController alloc] init];
//    [controllers addObject:liuLiangVC];
//    
//   // 2. 我的 vc
//    WoDeViewController *woDeVC = [[WoDeViewController alloc] initWithStyle:UITableViewStylePlain];
//    woDeVC.view.backgroundColor = [UIColor redColor];
//    [controllers addObject:woDeVC];
//    
//    // 3. 发现 vc
//    WoDeViewController *discoverVC = [[WoDeViewController alloc] initWithStyle:UITableViewStylePlain];
//    discoverVC.view.backgroundColor = [UIColor blueColor];
//    [controllers addObject:discoverVC];
//    
//    // 4. 设置 vc
//    WoDeViewController *setupVC = [[WoDeViewController alloc] initWithStyle:UITableViewStylePlain];
//    setupVC.view.backgroundColor = [UIColor grayColor];
//
//    [controllers addObject:woDeVC];
//    
//    // TODO: 其它 vc 稍后实现
    
    
    
    // 自定义 tabbarcontroller	
	leveyTabBarController = [[LeveyTabBarController alloc] init];
    
    // 设置各 vc 的 parent 信息
    //liuLiangVC.parent = leveyTabBarController;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.leveyTabBarController;
    [self.window makeKeyAndVisible];
    
    // 尝试使用 tabbarcontroller + navigationcontroller 方式
//    CustomTabBarViewController *tabbarVC = [[CustomTabBarViewController alloc] initWithImageArray:imgArr];
//    self.window.rootViewController = tabbarVC;
//    [self.window makeKeyAndVisible];

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
