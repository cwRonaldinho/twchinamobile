//
//  BackCircleView.h
//  TwChinaMobile
//
//  Created by tw on 15-3-17.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackCircleView : UIView
@property (nonatomic, assign) unsigned int totalAmount;     // 总量
@property (nonatomic, assign) unsigned int curAmount;       // 当前剩余总量

- (instancetype)initWithFrame:(CGRect)frame totalAmount:(unsigned int)totalAmount;
@end
