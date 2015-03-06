//
//  CustomNavBar.m
//  TwChinaMobile
//
//  Created by tw on 15-2-5.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "CustomNavBar.h"
#import "UIImage+UIImageExt.h"
#import "GlobalData.h"

#include "constant.h"

@implementation CustomNavBar

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        // 背景图
		self.backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
        // TOOD: 使用正确背景图，暂时该图片将就
        [self.backgroundView setImage:[UIImage imageNamed:@"selected_line.png"]];
        //
        //self.backgroundView.backgroundColor = [UIColor clearColor];
		[self addSubview:_backgroundView];
        
        // 添加 logo
        self.logoView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.logoView setImage:[UIImage imageNamed:@"logo.png"]];
        self.logoView.frame = CGRectMake(kLogoInset, (kTabBarHeight -  kLogoHeight) / 2, kLogoWidth, kLogoHeight);
		[self addSubview:self.logoView];
        
        // 账号
        // 传统方式
        NSString *phoneNumber = [[GlobalData sharedSingleton] account];
        UILabel *accountLabel = [[UILabel alloc] init];
        UIFont *font =[UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
//        NSDictionary *attributes = @{NSFontAttributeName: font};
//        CGSize titleSize = [phoneNumber sizeWithAttributes:attributes]; // 获取字符串size
//
//        accountLabel.text = phoneNumber;
//        //accountLabel.backgroundColor = [UIColor redColor];
//        accountLabel.font = font;
//        accountLabel.textColor = [UIColor whiteColor];
//        accountLabel.textAlignment = NSTextAlignmentLeft;
//        accountLabel.frame = CGRectMake(kLogoWidth + kLogoInset * 2 , (kTabBarHeight - titleSize.height) / 2 , titleSize.width, titleSize.height);
//
        // 属性字符串方式
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:phoneNumber];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [str length])];
        [str addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, [str length])];
        accountLabel.attributedText = str;
        accountLabel.frame = CGRectMake(kLogoWidth + kLogoInset * 2 , (kTabBarHeight - str.size.height) / 2 , str.size.width, str.size.height);
        
        [self addSubview:accountLabel];
        
        // 通话按钮
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.showsTouchWhenHighlighted = YES;
        CGSize btnSize = CGSizeMake(kCommBtnWeight, kCommBtnHeight);
        btn.frame = CGRectMake(g_applicationFrame.size.width - kCommBtnWeight - kLogoInset, (kTabBarHeight - kCommBtnHeight) /  2, btnSize.width, btnSize.height);
        [btn setImage:[[UIImage imageNamed:@"icon_comm.png"] imageByScalingAndCroppingForSize: btnSize] forState:UIControlStateNormal];
        [btn setImage:[[UIImage imageNamed:@"icon_comm.png"] imageByScalingAndCroppingForSize: btnSize] forState:UIControlStateHighlighted];
        [btn setImage:[[UIImage imageNamed:@"icon_comm.png"] imageByScalingAndCroppingForSize: btnSize] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(navCommButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = kCommBtnTag;
        [self addSubview:btn];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)navCommButtonClicked:(id)sender
{
	UIButton *btn = sender;
    //NSLog(@"Select index: %d",btn.tag);
    if ([_delegate respondsToSelector:@selector(navBar:didClickButton:)])
    {
        [_delegate navBar:self didClickButton:btn.tag];
    }
}

@end
