//
//  GlobalData.h
//  TwChinaMobile
//
//  Created by tw on 15-2-8.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

@property (nonatomic, copy) NSString *account;              // 账户信息，即用户手机号
@property (nonatomic, assign) unsigned int totalFlow;      // 总流量
@property (nonatomic, assign) unsigned int totalRemainFlow;   // 剩余总流量
@property (nonatomic, assign) unsigned int totalUsedFlow;   // 剩余总流量
@property (nonatomic, copy) NSString *lastQueryTime;    // 最后一次查询时间

+ (GlobalData *)sharedSingleton; 

@end
