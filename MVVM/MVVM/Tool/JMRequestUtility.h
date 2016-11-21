//
//  JMRequestUtility.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/7.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@class JMRequestUtility;
typedef void (^requestSuccessHandleBlock)(NSDictionary *responseDict);
typedef void (^requestProgressHandleBlock)(NSProgress *progress);
typedef void (^requestFailedHandleBlock)(NSError *error);
@interface JMRequestUtility : NSObject
/**
 请求任务
 */
@property (nonatomic, strong) NSURLSessionTask *sessionTask;
- (void)start;
- (void)stop;
- (JMRequestUtility *)get:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                 progress:(requestProgressHandleBlock)progress
                  success:(requestSuccessHandleBlock)sucess
                  failure:(requestFailedHandleBlock)failure;
+ (JMRequestUtility *)post:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                 progress:(requestProgressHandleBlock)progress
                  success:(requestSuccessHandleBlock)sucess
                  failure:(requestFailedHandleBlock)failure;
@end
