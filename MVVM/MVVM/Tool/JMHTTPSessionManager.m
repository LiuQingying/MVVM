//
//  JMHTTPSessionManager.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/7.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMHTTPSessionManager.h"

@implementation JMHTTPSessionManager
+ (instancetype)shareInstance{
    static JMHTTPSessionManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [JMHTTPSessionManager manager];
    });
    return instance;
}
@end
