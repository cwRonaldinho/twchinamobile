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


@end
