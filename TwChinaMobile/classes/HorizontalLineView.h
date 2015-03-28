//
//  HorizontalLineView.h
//  TwChinaMobile
//
//  Created by tw on 15-3-23.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalLineView : UIView
@property (nonatomic, assign) unsigned int totalAmount;     // 总量
@property (nonatomic, assign) unsigned int curAmount;       // 当前剩余总量
@property(nonatomic)dispatch_source_t animateTimer;     // 动画定时器

- (instancetype)initWithFrame:(CGRect)frame totalAmount:(unsigned int)totalAmount;

- (void)startAnimate:(unsigned int)curAmount;
@end
