//
//  CategoryDetailView.m
//  TwChinaMobile
//
//  Created by tw on 15-3-18.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "CategoryDetailView.h"
#import "NSString+NSStringExt.h"
#import "constant.h"
#import "UIView+UIViewExt.h"
#import "HorizontalLineView.h"
#import "THProgressView.h"
#import "common_util.h"

#define kFontSizeTitle                  22
//#define kInsetTopTitle                  35
#define kWidthMainImage           140
#define kHeightMainImage          140
//#define kInsetTopMainImage       100
#define kFontSizeDesp                 14
#define kFontSizeQueryTime                 12
#define kWidthAreaTimeImage    30
#define kHeightAreaTimeImage   30
//#define kInsetTopAreaTimeImage 240
////#define kInsetTopSeparateLine      260
//#define kInsetTopAnimateLine       280
//#define kInsetTopAmountTitle       300
//#define kInsetTopAmountValue      320
#define kInsetHorizontalATImage  10
#define kInsetHorizontalAmount   14
#define kFontSizeAmountTitle       12
#define kInsetHorizontalAnimateLine 20
#define kWidthProgress                 10

#define kTagProgress                      2000

@implementation CategoryDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = kColor_RGB(238);
    }
    return self;
}

- (void)loadItems
{
    float largeDistanceVertical = (g_screenHeight - kStatusBarHeight - kNavBarHeight) / 30.0;   // 纵向大间距
    float smallDistanceVertical = (g_screenHeight - kStatusBarHeight - kNavBarHeight) / 50.0;   // 纵向大间距
    
    // 标题
    UILabel *labelTitle = [_title createFontedLabel:[UIFont fontWithName:@"HelveticaNeue-Bold" size:kFontSizeTitle]];
    labelTitle.center = CGPointMake(self.bounds.size.width / 2, largeDistanceVertical + labelTitle.frame.size.height/2);
    [self addSubview:labelTitle];
    
    float bottomY = [labelTitle getBottomY]; // 上一元素的bottom y坐标
    
    // 类型图
    UIImageView *imageViewType = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_mainImageName]];
    imageViewType.frame = CGRectMake((g_screenWidth - kWidthMainImage) / 2, bottomY + largeDistanceVertical, kWidthMainImage, kHeightMainImage);
    [self addSubview:imageViewType];
    bottomY = [imageViewType getBottomY];
    
    // 描述
    UILabel *despTitle = [_desp createFontedLabel:[UIFont systemFontOfSize:kFontSizeDesp]];
    despTitle.frame = CGRectMake(kInsetHorizontalAmount, bottomY + largeDistanceVertical, g_screenWidth - kInsetHorizontalAmount * 2, despTitle.frame.size.height * 2);
    despTitle.lineBreakMode = NSLineBreakByWordWrapping;
    despTitle.numberOfLines = 0;
    despTitle.textAlignment = NSTextAlignmentCenter;
    //despTitle.center = CGPointMake(self.bounds.size.width/2, bottomY + largeDistanceVertical + despTitle.frame.size.height/2);
    [self addSubview:despTitle];
    bottomY = [despTitle getBottomY];
    
    // 时段、区别说明图
    int nATCount = (int)[_arrayDetailImageName count];
    float yATImage = bottomY + largeDistanceVertical + kHeightAreaTimeImage/2.0;
    float xStartATImage = self.bounds.size.width/2.0 - (kInsetHorizontalATImage * (nATCount - 1) + kWidthAreaTimeImage*nATCount)/2.0;
    for (int i = 0; i < nATCount; i++) {
        float xATImage = xStartATImage + (kWidthAreaTimeImage + kInsetHorizontalATImage) * i;
        UIImageView *imageViewAT = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[_arrayDetailImageName objectAtIndex:i]]];
        imageViewAT.frame = CGRectMake(xATImage, yATImage, kWidthAreaTimeImage, kHeightAreaTimeImage);
        [self addSubview:imageViewAT];
        bottomY = [imageViewAT getBottomY];
    }
    
    // 分隔线
    UILabel *labelSeperateLine = [[UILabel alloc] initWithFrame:CGRectMake(0, bottomY + 30, g_screenWidth, 1)];
    labelSeperateLine.backgroundColor = [UIColor grayColor];
    [self addSubview:labelSeperateLine];
    bottomY = [labelSeperateLine getBottomY];
    
    // 图形条
    THProgressView *progressLine = [[THProgressView alloc] initWithFrame:CGRectMake(kInsetHorizontalAnimateLine, bottomY + 30, g_screenWidth - kInsetHorizontalAnimateLine*2, kWidthProgress)];
    TRACE_RECT(progressLine.frame);
    progressLine.progressTintColor = kColorBackCircle;
    progressLine.borderTintColor = [UIColor grayColor];
    progressLine.tag = kTagProgress;
    [self addSubview:progressLine];
    bottomY = [progressLine getBottomY];
    
    // 剩余量标题
    NSString *name = @"本月剩余流量";
    UILabel *labelRemainTitle = [name createFontedLabel:[UIFont systemFontOfSize:kFontSizeAmountTitle]];
    labelRemainTitle.center = CGPointMake(kInsetHorizontalAmount + labelRemainTitle.frame.size.width/2, bottomY + 20 + labelRemainTitle.frame.size.height/2);
    [self addSubview:labelRemainTitle];
    bottomY = [labelRemainTitle getBottomY];
    
    // 总量标题
    name  = @"总量";
    UILabel *labelTotalTitle = [name createFontedLabel:[UIFont systemFontOfSize:kFontSizeAmountTitle]];
    labelTotalTitle.center = CGPointMake(g_screenWidth - kInsetHorizontalAmount - labelTotalTitle.frame.size.width*2, labelRemainTitle.center.y);
    [self addSubview:labelTotalTitle];
    
    // 剩余量值
    NSArray *arrayFonts = [NSArray arrayWithObjects:[UIFont systemFontOfSize:20], [UIFont systemFontOfSize:12], nil];
    int arrayLens[] = {(int)[[NSString stringWithFormat:@"%d", _remain] length], 1};
    NSArray *arrayColors = [NSArray arrayWithObjects:kColorBackCircle, [UIColor blackColor], nil];
    NSString *remainValue = [NSString stringWithFormat:@"%dM", _remain];
    UILabel *labelRemainValue = [remainValue createSpecLabel:arrayFonts lens:arrayLens colors:arrayColors];
    labelRemainValue.center = CGPointMake(kInsetHorizontalAmount + labelRemainValue.frame.size.width/2, bottomY + smallDistanceVertical + labelRemainValue.frame.size.height/2);
    [self addSubview:labelRemainValue];
    bottomY = [labelRemainValue getBottomY];
    
    // 总量值
    arrayLens[0] = (int)[[NSString stringWithFormat:@"%d", _total] length];
    NSString *totalValue = [NSString stringWithFormat:@"%dM", _total];
    UILabel *labelTotalValue = [totalValue createSpecLabel:arrayFonts lens:arrayLens colors:arrayColors];
    labelTotalValue.frame = CGRectMake(labelTotalTitle.frame.origin.x, labelRemainValue.frame.origin.y, labelTotalValue.frame.size.width, labelTotalValue.frame.size.height);
    [self addSubview:labelTotalValue];
    
    // 查询时间
    UILabel *labelQueryTime = [_queryTime createFontedLabel:[UIFont systemFontOfSize:kFontSizeQueryTime]];
    labelQueryTime.center = CGPointMake(self.bounds.size.width/2, bottomY + smallDistanceVertical + labelQueryTime.frame.size.height/2);
    [self addSubview:labelQueryTime];
    bottomY = [labelQueryTime getBottomY];
    
    // 触发动画，用定时器或直接调用的方式均可
    [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(startAnimation) userInfo:nil repeats:NO];
    //[self startAnimation];
}

- (void)startAnimation
{
    THProgressView *progressView = (THProgressView *)[self viewWithTag:kTagProgress];
    
    float ration = 0.0f;
    if (_total != 0) {
        ration = _remain*1.0/_total;
    }
    
    [progressView setProgress:ration animated:YES];
    
    [progressView setProgressTintColor:kColorBackCircle];
    [progressView setBorderWidth:0.5];
    [progressView setBBorder:YES];
    [progressView setBorderTintColor:[UIColor grayColor]];
}

@end
