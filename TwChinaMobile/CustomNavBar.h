//
//  CustomNavBar.h
//  TwChinaMobile
//
//  Created by tw on 15-2-5.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomNavBabDelegate;

// 自定义导航条(根据当前程序需求，包括背景图、logo、手机号及电话图标按钮)
@interface CustomNavBar : UIView

@property (nonatomic, strong) UIImageView *logoView;
@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, assign) id<CustomNavBabDelegate> delegate;

@end

// 自定义导航条协议
@protocol CustomNavBabDelegate<NSObject>
@optional
- (void)navBar:(CustomNavBar *)navBar didClickButton:(NSInteger)index;     // 点击电话按钮的处理函数
@end
