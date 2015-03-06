//
//  CustomTabBarViewController.h
//  TwChinaMobile
//
//  Created by tw on 15-2-12.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GXCustomButton.h"
#import "LeveyTabBar.h"

@interface CustomTabBarViewController : UITabBarController <LeveyTabBarDelegate>

//@property (nonatomic, strong) UIImageView *tabBarView; //自定义的覆盖原先的tarbar的控件

@property (nonatomic, strong) GXCustomButton *previousBtn; //记录前一次选中的按钮

@property (nonatomic, strong) LeveyTabBar *myTabBar;

- (id)initWithImageArray:(NSArray *)arr;

@end
