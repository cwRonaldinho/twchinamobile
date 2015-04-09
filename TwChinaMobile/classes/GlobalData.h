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
@property (nonatomic, assign) unsigned int internalTotalFlow;       // 国内通用总流量
@property (nonatomic, assign) unsigned int internalRemainFlow;  // 国内通用剩余流量
@property (nonatomic, assign) unsigned int localTotalFlow;           // 本地通用总流量
@property (nonatomic, assign) unsigned int localRemainFlow;       // 本地通用剩余流量
@property (nonatomic, assign) unsigned int local4GTotalFlow;        // 本地4G总流量
@property (nonatomic, assign) unsigned int local4GRemainFlow;    // 本地4G剩余流量
@property (nonatomic, assign) unsigned int localIdleTotalFlow;  // 本地闲时剩余流量
@property (nonatomic, assign) unsigned int localIdleRemainFlow;  // 本地闲时剩余流量
@property (nonatomic, copy) NSString *lastQueryTime;                 // 最后一次查询时间
@property (nonatomic, assign) unsigned int msgCount;                    // 短信
@property (nonatomic, assign) unsigned int remainMsgCount;
@property (nonatomic, assign) unsigned int voiceCount;
@property (nonatomic, assign) unsigned int remainVoiceCount;
@property (nonatomic, assign) unsigned int mmsgCount;
@property (nonatomic, assign) unsigned int remainMmsgCount;
@property (nonatomic, copy) NSMutableArray *subscribedPackeges;            // 已订阅套餐名


+ (GlobalData *)sharedSingleton;

- (void)calc;

// 测试用类方法
- (void)testUpdateData;

@end
