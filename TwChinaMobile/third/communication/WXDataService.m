//
//  WXDataService.m
//  MyWeibo
//
//  Created by zsm on 14-9-29.
//  Copyright (c) 2014年 zsm. All rights reserved.
//

#import "WXDataService.h"
#import "AppDelegate.h"
/*
    post请求
     MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:@"192.168.2.176:3000" customHeaderFields:nil];
     NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
     [dic setValue:@"admin" forKey:@"username"];
     [dic setValue:@"123" forKey:@"password"];
     
     MKNetworkOperation *op = [engine operationWithPath:@"/login" params:dic httpMethod:@"POST"];
     [op addCompletionHandler:^(MKNetworkOperation *operation) {
     NSLog(@"[operation responseData]-->>%@", [operation responseString]);
     }errorHandler:^(MKNetworkOperation *errorOp, NSError* err) {
     NSLog(@"MKNetwork request error : %@", [err localizedDescription]);
     }];
     [engine enqueueOperation:op];
 */

//#define BaseUrl @"61.140.20.194:49015/"
//#define BaseUrl  @"http://api.wodm.cn/"
@implementation WXDataService
//    https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.005mi4VD1o1dvD661e0648ccGnnTyD
+ (MKNetworkOperation *)requestWithUrl:(NSString *)urlString
                               BaseUrl:(NSString *)baseUrl
                             hasHeader:(BOOL)hasHeader
                                params:(NSMutableDictionary *)params
                           finishBlock:(FinishBlock)finishBlock
                            errorBlock:(ErrorBlock)errorBlock
{
    

      MKNetworkEngine * engine =  nil;
    if (hasHeader) {
        
        NSMutableDictionary *header = [[NSMutableDictionary alloc]init];
//        [header setValue:SPID forKey:@"spid"];
//        [header setValue:PASSWORD forKey:@"password"];
//        [header setValue:SOURCE_TYPE forKey:@"sourcetype"];
        [header setValue:[self getTimerstamp] forKey:@"timestamp"];
        
//        [header setValue:@"text/xml; charset=utf-8" forKey:@"Content-Type"];
        engine = [[MKNetworkEngine alloc]initWithHostName:baseUrl customHeaderFields:header];
    } else {
        
        engine = [[MKNetworkEngine alloc] initWithHostName:baseUrl customHeaderFields:nil];
    }
    // 1.创建网络请求管理对象
//    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:baseUrl
//                                                     customHeaderFields:nil];
    // 2.获取新浪微博认证令牌
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    NSString *access_token = appDelegate.wbtoken;
//    if (access_token.length == 0) {
//        return nil;
//    }
    
     //3.拼接子url
     urlString = [NSString stringWithFormat:@"%@?",urlString];
    // 拼接传进来的参数
//    for (NSString *key in params) {
//        //&key=value
//        urlString = [NSString stringWithFormat:@"%@&%@=%@",urlString,key,params[key]];
//    }
    for(int i = 0; i < params.allKeys.count;i++){
        
        NSString * key = params.allKeys[i];
        if (i == 0) {
        
             urlString = [NSString stringWithFormat:@"%@%@=%@",urlString,key,params[key]];
        } else {
            
            urlString = [NSString stringWithFormat:@"%@&%@=%@",urlString,key,params[key]];
        }
    }
    // 4.创建请求列队
    MKNetworkOperation *operation = [engine operationWithPath:urlString
                                                       params:nil
                                                   httpMethod:@"GET"
                                                          ssl:NO];
    // 5.在请求中添加证书
    //operation.clientCertificate = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"client.p12"];
    //operation.clientCertificatePassword = @"test";
 
//    if (hasHeader) {
//        
//        [operation setHeader:@"spid" withValue:SPID];
//        [operation setHeader:@"password" withValue:PASSWORD];
//        [operation setHeader:@"sourcetype" withValue:SOURCE_TYPE];
//        [operation setHeader:@"timestamp" withValue:[self getTimerstamp]];
//        
//    }
    //   当服务器端证书不合法时是否继续访问
    //operation.shouldContinueWithInvalidCertificate=YES;

    // 6.在列队中添加请求完成的回调
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {

        // 回调我们传进来的block
    
        //finishBlock([completedOperation responseJSON]);
        finishBlock([completedOperation responseString]);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        // 回调我们传进来的block
        errorBlock(error);
    }];
    
    // 7.开始请求
    [engine enqueueOperation:operation];
    return operation;
}

+ (MKNetworkOperation *)requestWithUrl:(NSString *)urlString
                               BaseUrl:(NSString *)baseUrl
                                params:(NSMutableDictionary *)params
                            httpMethod:(NSString *)httpMethod
                               upImage:(NSMutableDictionary *)ImageDic
                           finishBlock:(FinishBlock)finishBlock
                            errorBlock:(ErrorBlock)errorBlock
{
    // 1.创建网络请求管理对象
    MKNetworkEngine *engine = [[MKNetworkEngine alloc] initWithHostName:baseUrl
                                                     customHeaderFields:nil];
//    NSString *access_token = appDelegate.wbtoken;
//    if (access_token.length == 0) {
//        return nil;
//    }
    
    // 3.拼接子url
//    urlString = [NSString stringWithFormat:@"%@?access_token=%@",urlString,access_token];
    // 拼接传进来的参数
    if ([httpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        for (NSString *key in params) {
            //&key=value
            urlString = [NSString stringWithFormat:@"%@&%@=%@",urlString,key,params[key]];
        }
    }
    
    NSMutableDictionary *dic = [httpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame ? nil : params;
    // 4.创建请求列队
    MKNetworkOperation *operation = [engine operationWithPath:urlString
                                                       params:dic
                                                   httpMethod:httpMethod
                                                          ssl:YES];
    
    // 上图片
    if (ImageDic != nil) {
        for (NSString *key in ImageDic) {
            [operation addFile:ImageDic[key] forKey:key];
        }
    }

    // 5.在请求中添加证书
    operation.clientCertificate = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"client.p12"];
    operation.clientCertificatePassword = @"test";
    //   当服务器端证书不合法时是否继续访问
    operation.shouldContinueWithInvalidCertificate=YES;
    
    // 6.在列队中添加请求完成的回调
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        // 回调我们传进来的block
        finishBlock([completedOperation responseJSON]);
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        
        // 回调我们传进来的block
        errorBlock(error);
    }];
    
    // 7.开始请求
    [engine enqueueOperation:operation];
    return operation;
}


//通过文件的名字解析出里面的内容
+ (id)getJsonDataWithFileName:(NSString *)fileName
{
    
    //获取json文件的路径
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    
    //获取文件里面的内容
    NSData *jsonData = [NSData dataWithContentsOfFile:path];
    
    //json解析
//    if (kVersion >= 5.0) {
//        //使用系统的方法解析
//        id result = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//        
//        return result;
//    }
    
    return nil;
}
+(NSString *)getTimerstamp{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //输出格式为：2010-10-27 10:22:13
    NSLog(@"%@",currentDateStr);
    
    return currentDateStr;
}
@end
