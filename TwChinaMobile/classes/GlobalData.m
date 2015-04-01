//
//  GlobalData.m
//  TwChinaMobile
//
//  Created by tw on 15-2-8.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData

+ (GlobalData *)sharedSingleton
{
    static GlobalData *sharedSingleton;
    
    @synchronized(self)
    {
        if (!sharedSingleton)
        {
            sharedSingleton = [[GlobalData alloc] init];
        }
        
        return sharedSingleton;
    }
}

- (instancetype)init
{
    _account = @"";
    _totalFlow = 0;
    _totalRemainFlow = 0;
    _totalUsedFlow = 0;
    _internalTotalFlow = 0;
    _internalRemainFlow = 0;
    _localTotalFlow = 0;
    _localRemainFlow = 0;
    _local4GTotalFlow = 0;
    _local4GRemainFlow = 0;
    _localIdleTotalFlow = 0;
    _localIdleRemainFlow = 0;
    return self;
}

// 计算总量
- (void)calc
{
    _totalFlow = _internalTotalFlow + _localTotalFlow + _local4GTotalFlow + _localIdleTotalFlow;
    _totalRemainFlow = _internalRemainFlow + _localRemainFlow + _local4GRemainFlow + _localIdleRemainFlow;
    _totalUsedFlow = _totalFlow - _totalRemainFlow;
}

- (void)testUpdateData
{
    // 获取系统当前时间
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY年MM月dd日hh时mm分ss秒"];
    date = [formatter stringFromDate:[NSDate date]];
    _lastQueryTime = date;
    
    unsigned nCost = 10;
    self.internalRemainFlow -= nCost;
    
    [self calc];
}

@end
