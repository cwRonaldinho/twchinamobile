//
//  LiuLiangView.h
//  TwChinaMobile
//
//  Created by tw on 15-3-3.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeveyTabBarController;

@interface LiuLiangView : UIView

@property(nonatomic, strong) UIView *mainView;
@property(nonatomic, strong) LeveyTabBarController *parent;

- (id)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parent;
- (void)reladData;
@end
