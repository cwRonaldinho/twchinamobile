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
    _internalRemainFlow = 0;
    _localRemainFlow = 0;
    _local4GFlow = 0;
    _localIdleRemainFlow = 0;
    return self;
}

- (void)setTotalRemainFlow:(unsigned int)totalRemainFlow
{
    _totalRemainFlow = totalRemainFlow;
    self.totalUsedFlow = self.totalFlow - totalRemainFlow;
}

- (void)testUpdateData
{
    // 获取系统当前时间
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY年MM月dd日hh时mm分ss秒"];
    date = [formatter stringFromDate:[NSDate date]];
    _lastQueryTime = date;
    
    self.totalRemainFlow = _totalRemainFlow - 100;
    self.internalRemainFlow = _internalRemainFlow - 100;
    
    if (self.totalRemainFlow > self.totalFlow) {
        self.internalRemainFlow = 100;
        self.totalRemainFlow =_totalFlow - self.internalRemainFlow;
    }
}

@end
