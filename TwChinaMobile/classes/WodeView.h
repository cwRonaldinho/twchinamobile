//
//  WodeView.h
//  TwChinaMobile
//
//  Created by tw on 15-4-1.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMyMobileTableView.h"

@interface WodeView : UIView
@property (nonatomic, strong) MyPackages *tvPackages;           // 套餐
@property (nonatomic, strong) MyBill *tvBill;                               // 账单
@property (nonatomic, strong) MyAccumulate *tvAccumulate;   // 积分
@property (nonatomic, strong) MyServices *tvServices;               // 业务

@property(nonatomic, strong) UIViewController *parent;

- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parent;
@end
