//
//  CircleProgress.h
//  TwChinaMobile
//
//  Created by tw on 15-4-2.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleProgress : UIView
@property (nonatomic, assign) unsigned int totalAmount;     // 总量
@property (nonatomic, assign) unsigned int curAmount;       // 当前剩余总量
@property (nonatomic) UIColor *backgroundCirlceColor;                // 背景色
@property (nonatomic) UIColor *foregroundCircleColor;                 // 前景色
@property (nonatomic) float borderWidth;                              // 边框长

- (instancetype)initWithFrame:(CGRect)frame totalAmount:(unsigned int)totalAmount;
@end
