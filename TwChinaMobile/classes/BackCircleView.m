//
//  BackCircleView.m
//  TwChinaMobile
//
//  Created by tw on 15-3-17.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "BackCircleView.h"
#import "NSString+NSStringExt.h"
#import "constant.h"

@implementation BackCircleView

- (instancetype)initWithFrame:(CGRect)frame totalAmount:(unsigned int)totalAmount
{
    self = [super initWithFrame:frame];
    if (self) {
        _totalAmount = totalAmount;
        _curAmount = _totalAmount;
        
        [self drawCircle];
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
    UIColor *backColor = kColorBackCircle;
    [backColor set];
    
    //CGContextRef context = UIGraphicsGetCurrentContext();
    
    float rationLeft = (_curAmount*1.0/_totalAmount) * 3 / 2;
    //UIBezierPath *innerCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:rect.size.width/2 - 15 startAngle:M_PI*3/4 endAngle:(3/4 + rationLeft)*M_PI clockwise:YES];
    UIBezierPath *innerCircle = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:rect.size.width/2 - 17 startAngle:M_PI*3/4 endAngle:M_PI * (3/4.0 +rationLeft)  clockwise:YES];
    
    innerCircle.lineWidth = 12.0;
    innerCircle.lineCapStyle = kCGLineCapRound;
    
    [innerCircle stroke];
    
    //CGContextStrokePath(context);
}

- (void)drawCircle
{
    CAShapeLayer *_trackLayer = [CAShapeLayer layer];//创建一个track shape layer
    _trackLayer.frame = CGRectMake(0, 0, 50, 50);
    [self.layer addSublayer:_trackLayer];
    _trackLayer.fillColor = [[UIColor clearColor] CGColor];
    _trackLayer.strokeColor = [UIColor redColor].CGColor;//指定path的渲染颜色
    _trackLayer.opacity = 0.25; //背景同学你就甘心做背景吧，不要太明显了，透明度小一点
    _trackLayer.lineCap = kCALineCapRound;//指定线的边缘是圆的
    _trackLayer.lineWidth = 4;//线的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(40, 40) radius:0 startAngle:0 endAngle:M_PI_2 clockwise:YES];//上面说明过了用来构建圆形
    _trackLayer.path =[path CGPath];
}


@end
