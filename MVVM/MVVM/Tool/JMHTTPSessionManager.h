//
//  JMHTTPSessionManager.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/7.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface JMHTTPSessionManager : AFHTTPSessionManager
+ (instancetype)shareInstance;
@end
