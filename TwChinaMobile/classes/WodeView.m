//
//  WodeView.m
//  TwChinaMobile
//
//  Created by tw on 15-4-1.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "WodeView.h"
#import "constant.h"
#import "UIView+UIViewExt.h"
#import "CircleProgress.h"

#define kInsetHorizontal            8
#define kInsetVertical                 8
#define kHeightPackages           130
#define kHeightBill                     80
#define kHeightServices             190

@implementation WodeView

- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parent
{
    if (self = [super initWithFrame:frame]) {
        _parent = parent;
        
        self.backgroundColor = gkColorBackgrondGray;
        
        //
        _tvPackages = [[MyPackages alloc] initWithFrame:CGRectMake(kInsetHorizontal, kInsetVertical, (frame.size.width - kInsetHorizontal*2), kHeightPackages) parentVC:parent];
        [_tvPackages setTitleName:@"我的套餐"];
        [self addSubview:_tvPackages];
        
        float bottomY = [_tvPackages getBottomY];
        
        //
        _tvBill = [[MyBill alloc] initWithFrame:CGRectMake(kInsetHorizontal, bottomY + kInsetHorizontal, (frame.size.width - kInsetHorizontal*3)/2, kHeightBill) parentVC:parent];
        [_tvBill setTitleName:@"我的账单"];
        [self addSubview:_tvBill];
        
        //
        _tvAccumulate = [[MyAccumulate alloc] initWithFrame:CGRectMake(kInsetHorizontal*2 + _tvBill.frame.size.width, bottomY + kInsetHorizontal, (frame.size.width - kInsetHorizontal*3)/2, kHeightBill) parentVC:parent];
        [_tvAccumulate setTitleName:@"我的积分"];
        [self addSubview:_tvAccumulate];
        
        bottomY = [_tvAccumulate getBottomY];
        
        //
        _tvServices = [[MyServices alloc] initWithFrame:CGRectMake(kInsetHorizontal, bottomY + kInsetHorizontal, (frame.size.width - kInsetHorizontal*2), kHeightServices) parentVC:parent];
        [_tvServices setTitleName:@"我的业务"];
        [self addSubview:_tvServices];
        
        bottomY = [_tvServices getBottomY];
        
        //
        UILabel *labelMore = [@"更多信息查询及办理>>" createFontedLabel:DefaultFontBySize(13)];
        labelMore.textColor = [UIColor colorWithRed:97/255.0 green:127/255.0 blue:61/255.0 alpha:1];  //97,127,61
        labelMore.center = CGPointMake(self.frame.size.width - 10 - labelMore.frame.size.width/2, bottomY + kInsetVertical/2 + labelMore.frame.size.height/2);
        [self addSubview:labelMore];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma UITableView datasource
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 2;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSString *cellID = @"cellid";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//    }
//    
//    cell.textLabel.text = @"test";
//    return cell;
//}

@end
