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
            sharedSingleton = [[GlobalData alloc] init];
        
        return sharedSingleton;
    }
}

- (void)setTotalRemainFlow:(unsigned int)totalRemainFlow
{
    _totalRemainFlow = totalRemainFlow;
    self.totalUsedFlow = self.totalFlow - totalRemainFlow;
}

@end
