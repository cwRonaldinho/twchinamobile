//
//  GlobalData.h
//  TwChinaMobile
//
//  Created by tw on 15-2-8.
//  Copyright (c) 2015年 tw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject

@property (nonatomic, copy) NSString *account;                            // 账户信息，即用户手机号
@property (nonatomic, assign) unsigned int totalFlow;                   // 总流量
@property (nonatomic, assign) unsigned int totalRemainFlow;       // 剩余总流量
@property (nonatomic, assign) unsigned int totalUsedFlow;           // 剩余总流量
@property (nonatomic, assign) unsigned int internalRemainFlow;  // 国内通用剩余流量
@property (nonatomic, assign) unsigned int localRemainFlow;       // 本地通用剩余流量
@property (nonatomic, assign) unsigned int local4GFlow;               // 本地4G剩余流量
@property (nonatomic, assign) unsigned int localIdleRemainFlow;  // 本地闲时剩余流量
@property (nonatomic, copy) NSString *lastQueryTime;                 // 最后一次查询时间

+ (GlobalData *)sharedSingleton;

// 测试用类方法
- (void)testUpdateData;

@end
