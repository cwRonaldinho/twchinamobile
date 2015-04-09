//
//  BaseMineTableView.h
//  TwChinaMobile
//
//  Created by tw on 15-4-1.
//  Copyright (c) 2015年 tw. All rights reserved.
//

// "我的" 页面中多个 tableview 的基类

#import <UIKit/UIKit.h>

@interface BaseMyMobileTableView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
    BOOL hasDisclosureAccessoriesInFirstLine;                           // 在第一行最右边是否有指示箭头
    NSString *titleBackgoundImageName;
}

@property (nonatomic, copy) NSString *titleName;
@property(nonatomic, strong) UIViewController *parent;


- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parent;

@end

// 我的套餐
@interface MyPackages : BaseMyMobileTableView

- (instancetype)initWithFrame:(CGRect)frame;

@end

// 我的账单
@interface MyBill : BaseMyMobileTableView

- (instancetype)initWithFrame:(CGRect)frame;

@end

// 我的积分
@interface MyAccumulate : BaseMyMobileTableView

- (instancetype)initWithFrame:(CGRect)frame;

@end

// 我的业务
@interface MyServices : BaseMyMobileTableView

- (instancetype)initWithFrame:(CGRect)frame;

@end
