//
//  HorizontalLineView.m
//  TwChinaMobile
//
//  Created by tw on 15-3-23.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "HorizontalLineView.h"
#import "constant.h"

@implementation HorizontalLineView

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
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画线
//    CGPoint aPoints[2];//坐标点
//    aPoints[0] =CGPointMake(0, 0);//坐标1
//    aPoints[1] =CGPointMake((self.bounds.size.width * (_curAmount*1.0/_totalAmount)), 0);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    
    CGContextSetLineWidth(context, 5.0);//线的宽度
    
    CGContextSetRGBStrokeColor(context,0,1,0,1.0);//画笔线的颜色
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, self.bounds.size.width, 0);
    
    
    CGContextSetRGBStrokeColor(context,1,0,0,1.0);//画笔线的颜色
    //CGContextAddLines(context, aPoints, 2);//添加线
    //CGContextDrawPath(context, kCGPathStroke); //根据坐标绘制路径
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, (int)(self.bounds.size.width * (_curAmount*1.0/_totalAmount)), 0);
    NSLog(@"%f", self.bounds.size.width * (_curAmount*1.0/_totalAmount));
    
    CGContextStrokePath(context);
}

// 开启动画
- (void)startAnimate:(unsigned int)curAmount
{
    __block unsigned int nCurShow = _totalAmount;
    _animateTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,dispatch_get_main_queue()); // 只能用主线程队列才有效果
    dispatch_source_set_timer(_animateTimer, dispatch_walltime(DISPATCH_TIME_NOW, 0), USEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_animateTimer, ^{
        NSLog(@"%d, %d", nCurShow, curAmount);
        if (nCurShow >= curAmount) {
            [self setCurAmount:nCurShow];
            nCurShow-=5;
        }
        else {
            dispatch_source_cancel(_animateTimer);
        }
    });
    
    dispatch_resume(_animateTimer);
}


@end
