//
//  THProgressView.h
//
//  Created by Tiago Henriques on 10/22/13.
//  Copyright (c) 2013 Tiago Henriques. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THProgressView : UIView

@property (nonatomic, strong) UIColor* progressTintColor;
@property (nonatomic, strong) UIColor* backgroundTintColor;
@property (nonatomic, strong) UIColor* borderTintColor;
@property (nonatomic) CGFloat progress;
@property (nonatomic, assign) BOOL bBorder;                     // 是否有边框
@property (nonatomic, assign) float borderWidth;                // 边框宽度

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end