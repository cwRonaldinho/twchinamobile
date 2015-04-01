//
//  WXDataService.h
//  MyWeibo
//
//  Created by zsm on 14-9-29.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^FinishBlock) (id result);
typedef void(^ErrorBlock) (NSError *error);
@interface WXDataService : NSObject

+ (MKNetworkOperation *)requestWithUrl:(NSString *)urlString
                               BaseUrl:(NSString *)baseUrl
                             hasHeader:(BOOL)hasHeader
                                params:(NSMutableDictionary *)params
                           finishBlock:(FinishBlock)finishBlock
                            errorBlock:(ErrorBlock)errorBlock;

+ (MKNetworkOperation *)requestWithUrl:(NSString *)urlString
                               BaseUrl:(NSString *)baseUrl
                                params:(NSMutableDictionary *)params
                            httpMethod:(NSString *)httpMethod
                               upImage:(NSMutableDictionary *)ImageDic
                           finishBlock:(FinishBlock)finishBlock
                            errorBlock:(ErrorBlock)errorBlock;

+ (id)getJsonDataWithFileName:(NSString *)fileName;
@end
