//
//  AppDelegate.h
//  TwChinaMobile
//
//  Created by tw on 15-1-31.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainTabBarController;

//@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>
@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)  MainTabBarController *mainViewController;

@end
