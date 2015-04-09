//
//  BaseMineTableView.m
//  TwChinaMobile
//
//  Created by tw on 15-4-1.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "BaseMyMobileTableView.h"
#import "constant.h"
#import "CircleProgress.h"
#import "MainTabBarController.h"
#import "ValidPackagesViewController.h"

#define kInsetLeftTitle  8
#define kHeightFirstCell  34
#define kWidthTitle 80
#define kHeightTitle 22
#define kStrCellID @"mymobile"
#define kBorderWidthPoint 5
//#define kFontDetails [UIFont fontWithName:@"HelveticaNeue" size:13]
//#define kFontDetails [UIFont fontWithName:@"Thonburi" size:13]
#define kFontSizeDetails 13
#define kLengthCircle          52
#define kInsetHorizontalCircle       16
#define kInsetVerticalCircle            4
#define kInsetVetrticalPackagesItem 2
#define kFontSizePackagesRemainLabel  12
#define kSizeBusiness                     40
#define kInsetLeftBusiness              20
#define kFontSizeBusinessName    11

@implementation BaseMyMobileTableView

- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parent
{
    if (self = [super initWithFrame:frame style:UITableViewStylePlain]) {
        _parent = parent;
        hasDisclosureAccessoriesInFirstLine = YES;
        
        self.delegate = self;
        self.dataSource = self;
        
        // 设置圆角
        self.layer.cornerRadius = gkCornerRadius;
        self.layer.masksToBounds = YES;
        
        // 分隔线满屏A
        [self setSeparatorInset:UIEdgeInsetsZero];
        [self setLayoutMargins:UIEdgeInsetsZero];
        
        // 变量初始化
        _titleName = @"";
        titleBackgoundImageName = @"mymobile_blue.png";
        
        //
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma table view delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// 各子类需要实现该方法
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 3;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = kStrCellID;
    NSInteger cellStyle = UITableViewCellStyleDefault;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        // 基类中只处理第一行数据，其它行数据由各子类提供
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
        }
        
        // 左侧标题
        UIImageView *titleView = [[UIImageView alloc] initWithFrame:CGRectMake(kInsetLeftTitle, 0, kWidthTitle, kHeightTitle)];
        titleView.image = [UIImage imageNamed:titleBackgoundImageName];
        UILabel *labelName = [_titleName createFontedLabel:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15]];
        labelName.center = CGPointMake(titleView.bounds.size.width/2, titleView.bounds.size.height/2);
        labelName.textColor = [UIColor whiteColor];
        [titleView addSubview:labelName];
        [cell.contentView addSubview:titleView];
        
        // 右侧指示箭头
        if (hasDisclosureAccessoriesInFirstLine) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        // 分隔线满屏B
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
        // 行选中时无高亮显示
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kHeightFirstCell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSLog(@"select section:%ld,row:%ld", indexPath.section, indexPath.row);
//}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 我的套餐
@implementation MyPackages

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma table view delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = kStrCellID;
    NSInteger cellStyle = UITableViewCellStyleDefault;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        // 基类中只处理第一行数据，其它行数据由各子类提供
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
        }
        
        if (indexPath.row == 1) {
            NSArray *types = [NSArray arrayWithObjects:@"语音", @"流量", @"短信", @"彩信", nil];
            NSArray *unitNames = [NSArray arrayWithObjects:@"分钟", @"M", @"条", @"条", nil];
            unsigned int remainValues[4];
            remainValues[0] = [[GlobalData sharedSingleton] remainVoiceCount];
            remainValues[1] = [[GlobalData sharedSingleton] totalRemainFlow];
            remainValues[2] = [[GlobalData sharedSingleton] remainMsgCount];
            remainValues[3] = [[GlobalData sharedSingleton] remainMmsgCount];
            unsigned int totalValues[4];
            totalValues[0] = [[GlobalData sharedSingleton] voiceCount];
            totalValues[1] = [[GlobalData sharedSingleton] totalFlow];
            totalValues[2] = [[GlobalData sharedSingleton] msgCount];
            totalValues[3] = [[GlobalData sharedSingleton] mmsgCount];
            
            float insetBetweenCircles = (self.bounds.size.width - kInsetHorizontalCircle * 2 - kLengthCircle * 4) / 3;
            for (int i=0; i<4; i++) {
                CircleProgress *cp = [[CircleProgress alloc] initWithFrame:CGRectMake(kInsetHorizontalCircle + (kLengthCircle + insetBetweenCircles)*i, kInsetVerticalCircle, kLengthCircle, kLengthCircle) totalAmount:totalValues[i]];
                [cp setCurAmount:remainValues[i]];
                
                // 圈内标题
                NSString *name = (NSString *)[types objectAtIndex:i];
                UILabel *label = [name createFontedLabel:DefaultFontBySize(kFontSizeDetails)];
                label.center = CGPointMake(cp.bounds.size.width/2, cp.bounds.size.height/2);
                label.textColor = gkColorDarkPink;
                [cp addSubview:label];
                [cell.contentView addSubview:cp];
                float bottomY = [cp getBottomY];
                
                // 剩余 label
                name = totalValues[i] == 0 ? @"总量" : @"剩余";
                label = [name createFontedLabel:DefaultFontBySize(kFontSizePackagesRemainLabel)];
                label.textColor = gkColorDarkGray;
                label.center = CGPointMake(cp.center.x, bottomY + kInsetVetrticalPackagesItem + label.frame.size.height/2);
                [cell.contentView addSubview:label];
                bottomY = [label getBottomY];
                
                // 剩余值
                name = [NSString stringWithFormat:@"%d%@", remainValues[i], unitNames[i]];
                label = [name createFontedLabel:DefaultFontBySize(kFontSizePackagesRemainLabel)];
                label.textColor = remainValues[i] == 0 ? gkColorDarkPink : kColorBackCircle;
                label.center = CGPointMake(cp.center.x, bottomY + kInsetVetrticalPackagesItem + label.frame.size.height/2);
                [cell.contentView addSubview:label];
            }
        }
    }
    
    // 行选中时无高亮显示
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else if (indexPath.row == 1) {
        return self.frame.size.height - kHeightFirstCell;
    }
    
    return kHeightFirstCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row) {
        // 有效套餐
        ValidPackagesViewController *vpvc = [[ValidPackagesViewController alloc] init];
        [[MainTabBarController mainTabBarController].navigationController pushViewController:vpvc animated:YES];
    }
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 我的账单
@implementation MyBill

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma table view delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = kStrCellID;
    NSInteger cellStyle = UITableViewCellStyleDefault;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        // 基类中只处理第一行数据，其它行数据由各子类提供
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
        }
        
        // 第2行内容
        // 余额
        NSString *key = @"账户余额: ";
        NSString *value = [NSString stringWithFormat:@"%.2f元", 99.88f];
        NSString *line = [NSString stringWithFormat:@"%@%@", key, value];
        NSArray *arrayFonts = [NSArray arrayWithObjects:DefaultFontBySize(kFontSizeDetails), DefaultFontBySize(kFontSizeDetails), nil];
        int arrayLens[] = {(int)[key length], (int)[value length]};
        NSArray *arrayColors = [NSArray arrayWithObjects:[UIColor blackColor], gkColorDarkPink, nil];
        UILabel *line1 = [line createSpecLabel:arrayFonts lens:arrayLens colors:arrayColors];
        float insetVertical = (cell.frame.size.height - line1.frame.size.height*2) / 3;
        line1.center = CGPointMake(kInsetLeftTitle + kBorderWidthPoint*2 + line1.frame.size.width/2, insetVertical + line1.frame.size.height/2);
        [cell.contentView addSubview:line1];
        
        //
        key = @"本月消费: ";
        value = [NSString stringWithFormat:@"%.2f元", 0.12f];
        line = [NSString stringWithFormat:@"%@%@", key, value];
        int arrayLens2[] = {(int)[key length], (int)[value length]};
        arrayColors = [NSArray arrayWithObjects:[UIColor blackColor], gkColorDarkPink, nil];
        UILabel *line2 = [line createSpecLabel:arrayFonts lens:arrayLens2 colors:arrayColors];
        line2.center = CGPointMake(kInsetLeftTitle + kBorderWidthPoint*2 + line2.frame.size.width/2, insetVertical*2 + line1.frame.size.height*3/2);
        [cell.contentView addSubview:line2];
        
        // 项目符号1
        UIImageView *iv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graypoint.png"]];
        iv1.frame = CGRectMake(0, 0, kBorderWidthPoint, kBorderWidthPoint);
        iv1.center = CGPointMake(kInsetLeftTitle + iv1.frame.size.width/2, line1.center.y);
        [cell.contentView addSubview:iv1];
        // 项目符号2
        UIImageView *iv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graypoint.png"]];
        iv2.frame = CGRectMake(0, 0, kBorderWidthPoint, kBorderWidthPoint);
        iv2.center = CGPointMake(kInsetLeftTitle + iv2.frame.size.width/2, line2.center.y);
        [cell.contentView addSubview:iv2];
    }
    
    // 行选中时无高亮显示
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else if (indexPath.row == 1) {
        return self.frame.size.height - kHeightFirstCell;
    }
    
    return kHeightFirstCell;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 我的积分
@implementation MyAccumulate

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

#pragma table view delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = kStrCellID;
    NSInteger cellStyle = UITableViewCellStyleDefault;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        // 基类中只处理第一行数据，其它行数据由各子类提供
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
        }
        
        // 第2行内容
        //
        NSString *key = @"我的积分: ";
        NSString *value = [NSString stringWithFormat:@"%d分", 9988];
        NSString *line = [NSString stringWithFormat:@"%@%@", key, value];
        NSArray *arrayFonts = [NSArray arrayWithObjects:DefaultFontBySize(kFontSizeDetails), DefaultFontBySize(kFontSizeDetails), nil];
        int arrayLens[] = {(int)[key length], (int)[value length]};
        NSArray *arrayColors = [NSArray arrayWithObjects:[UIColor blackColor], gkColorDarkPink, nil];
        UILabel *line1 = [line createSpecLabel:arrayFonts lens:arrayLens colors:arrayColors];
        float insetVertical = (cell.frame.size.height - line1.frame.size.height*2) / 3;
        line1.center = CGPointMake(kInsetLeftTitle + kBorderWidthPoint*2 + line1.frame.size.width/2, insetVertical + line1.frame.size.height/2);
        [cell.contentView addSubview:line1];
        
        // 项目符号1
        UIImageView *iv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"graypoint.png"]];
        iv1.frame = CGRectMake(0, 0, kBorderWidthPoint, kBorderWidthPoint);
        iv1.center = CGPointMake(kInsetLeftTitle + iv1.frame.size.width/2, line1.center.y);
        [cell.contentView addSubview:iv1];
    }
    
    // 行选中时无高亮显示
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else if (indexPath.row == 1) {
        return self.frame.size.height - kHeightFirstCell;
    }
    
    return kHeightFirstCell;
}

@end

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// 我的业务
@implementation MyServices

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        hasDisclosureAccessoriesInFirstLine = NO;
        titleBackgoundImageName = @"mymobile_green.png";
    }
    return self;
}

#pragma table view delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellID = kStrCellID;
    NSInteger cellStyle = UITableViewCellStyleDefault;
    UITableViewCell *cell;
    
    if (indexPath.row == 0) {
        // 基类中只处理第一行数据，其它行数据由各子类提供
        cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:cellID];
        }
        
        if (indexPath.row == 1) {
            NSString *value = @"已订购5项业务: 和娱乐体验包、新华每日E刊...";
            UILabel *l = [value createFontedLabel:DefaultFontBySize(kFontSizeDetails)];
            l.center = CGPointMake(kInsetLeftTitle + l.frame.size.width/2, cell.frame.size.height/3);
            [cell.contentView addSubview:l];
        }
        else if (indexPath.row == 2) {
            UILabel *l = [@"推荐您使用" createFontedLabel:DefaultFontBySize(kFontSizeDetails)];
            l.center = CGPointMake(kInsetLeftTitle + l.frame.size.width/2, kInsetLeftTitle + l.frame.size.height/2);
            [cell.contentView addSubview:l];
            float bottomY = [l getBottomY];
            
            // 推荐业务图
            NSArray *businessNames = [NSArray arrayWithObjects:@"和4G", @"副号码", @"彩印", @"亲情通", nil];
            NSArray *businessImages = [NSArray arrayWithObjects:@"business8.png", @"business1.png", @"business3.png", @"business6.png", nil];
            for (int i=0; i<4; i++) {
                UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:businessImages[i]]];
                iv.frame = CGRectMake(kInsetLeftBusiness + (kInsetLeftBusiness + kSizeBusiness) * i, bottomY + kInsetLeftTitle/2, kSizeBusiness, kSizeBusiness);
                [cell.contentView addSubview:iv];
                
                UILabel *l = [[NSString stringWithFormat:@"  %@  ", businessNames[i]] createFontedLabel:DefaultFontBySize(kFontSizeBusinessName)];
                l.center = CGPointMake(iv.center.x, [iv getBottomY] + kInsetLeftTitle/2 + l.frame.size.height/2);
                l.backgroundColor = kColorBackCircle;
                l.textColor = [UIColor whiteColor];
                l.layer.cornerRadius = 4;
                l.layer.masksToBounds = YES;
                
                [cell.contentView addSubview:l];
            }
        }
        else if (indexPath.row == 3) {
            NSString *value = @"可免费体验11项业务:短信连连发...";
            UILabel *l = [value createFontedLabel:DefaultFontBySize(kFontSizeDetails)];
            l.center = CGPointMake(kInsetLeftTitle + l.frame.size.width/2, cell.frame.size.height/3);
            [cell.contentView addSubview:l];
        }
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // 分隔线满屏
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    // 行选中时无高亮显示
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float heightFirstLine = [super tableView:tableView heightForRowAtIndexPath:indexPath];  // 第一行高度
    
    if (indexPath.row == 0) {
        return heightFirstLine;
    }
    else {
        // 其它行通过比例来分配高度
        float remainHeight = self.frame.size.height - heightFirstLine;
        if (indexPath.row == 1 || indexPath.row == 3) {
            return remainHeight / 5;
        }
        else
        {
            return remainHeight * 3 / 5;
        }
    }
    
    return kHeightFirstCell;
}

@end

