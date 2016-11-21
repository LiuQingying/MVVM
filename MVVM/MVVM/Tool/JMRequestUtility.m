//
//  JMRequestUtility.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/7.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMRequestUtility.h"
#import "JMHTTPSessionManager.h"

@interface JMRequestUtility()

@end

@implementation JMRequestUtility
- (void)start{
    
    if (self.sessionTask) {
        [self.sessionTask resume];
    }
}
- (void)stop{
    if (self.sessionTask) {
        [self.sessionTask cancel];
    }
}
- (JMRequestUtility *)get:(NSString *)urlString
               parameters:(NSDictionary *)parameters
                 progress:(requestProgressHandleBlock)progress
                  success:(requestSuccessHandleBlock)sucess
                  failure:(requestFailedHandleBlock)failure{
    
    JMRequestUtility *requestProxy = [[JMRequestUtility alloc] init];
    JMHTTPSessionManager *manager = [JMHTTPSessionManager shareInstance];
    manager.requestSerializer.timeoutInterval = 15;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestProxy.sessionTask = [manager GET:urlString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"progress---%@",progress);

        if (progress) {
            progress(downloadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dict = responseObject;
        if (sucess) {
            sucess(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    return requestProxy;
}
+ (JMRequestUtility *)post:(NSString *)urlString
                parameters:(NSDictionary *)parameters
                  progress:(requestProgressHandleBlock)progress
                   success:(requestSuccessHandleBlock)sucess
                   failure:(requestFailedHandleBlock)failure{
    JMRequestUtility *requestProxy = [[JMRequestUtility alloc] init];
    JMHTTPSessionManager *manager = [JMHTTPSessionManager shareInstance];
    manager.requestSerializer.timeoutInterval = 15;
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    requestProxy.sessionTask = [manager POST:urlString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = responseObject;
        if (sucess) {
            sucess(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }

    }];
    return requestProxy;
}


@end
