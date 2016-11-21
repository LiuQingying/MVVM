//
//  JMBaseViewModel.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/7.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^requestSuccess)(NSArray *responseArry);
typedef void(^requestFail)(NSError *error);
typedef void(^requestProgress)(NSProgress *progress);
@interface JMBaseViewModel : NSObject

@end
