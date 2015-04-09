//
//  CircleProgress.m
//  TwChinaMobile
//
//  Created by tw on 15-4-2.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "CircleProgress.h"
#import "common_util.h"

@implementation CircleProgress

- (instancetype)initWithFrame:(CGRect)frame totalAmount:(unsigned int)totalAmount
{
    self = [super initWithFrame:frame];
    if (self) {
        _totalAmount = totalAmount;
        _curAmount = _totalAmount;
        
        // 默认参数
        _backgroundCirlceColor = COLOR_RGB(192, 210, 210);
        _foregroundCircleColor = COLOR_RGB(110, 150, 170);
        _borderWidth = 4;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setCurAmount:(unsigned int)curAmount
{
    _curAmount = curAmount;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // 背景
    //[self drawBackgroundCircle];
    [_backgroundCirlceColor set];
    UIBezierPath *backgroundCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:rect.size.width/2 - _borderWidth startAngle:0 endAngle:M_PI  * 2 clockwise:YES];
    backgroundCircle.lineWidth = _borderWidth;
    [backgroundCircle stroke];
    
    // 前景
    float rationLeft = _curAmount*1.0/_totalAmount;
    [_foregroundCircleColor set];
    UIBezierPath *foregroundCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:rect.size.width/2 - _borderWidth startAngle:M_PI_2 endAngle:M_PI  * (1/2.0 + rationLeft * 2) clockwise:YES];
    foregroundCircle.lineWidth = _borderWidth;
    foregroundCircle.lineCapStyle = kCGLineCapRound;
    [foregroundCircle stroke];
}

// 画背景圆
- (void)drawBackgroundCircle
{
    CAShapeLayer *_trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    _trackLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    _trackLayer.strokeColor = _backgroundCirlceColor.CGColor;//[UIColor redColor].CGColor;//指定path的渲染颜色
    _trackLayer.opacity = 1.0; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    //_trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _trackLayer.lineWidth = _borderWidth;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:self.bounds.size.width/2 - _borderWidth startAngle:0 endAngle:M_PI * 2 clockwise:YES];//上面说明过了用来构建圆形
    _trackLayer.path =[path CGPath];
}

@end
