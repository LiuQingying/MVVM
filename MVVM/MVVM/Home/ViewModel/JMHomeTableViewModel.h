//
//  JMHomeTableViewModel.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JMBaseViewModel.h"
#import "JMRequestUtility.h"
#import "HomeModel.h"

@protocol JMHomeTableViewModelDelegate <NSObject>

@required
- (void)handleRequestSucceed:(NSArray *)dataArr;
- (void)handleRequestFailed:(NSError *)err;

@end

@interface JMHomeTableViewModel : JMBaseViewModel
/**
 请求任务
 */
@property (nonatomic, strong) JMRequestUtility *requestProxy;
/**
 请求数据页数
 */
@property (nonatomic, strong) NSString *page;
/**
 模型数组
 */
@property (nonatomic, strong) NSMutableArray<HomeModel*> *homeModelsArr;
/**
 代理
 */
@property (nonatomic, weak) id<JMHomeTableViewModelDelegate> delegate;
- (void)fetchData;
- (void)fetchNewData;
- (void)fetchMoreData;
- (void)fetchDataWithProgress:(requestProgress)requestProgress success:(requestSuccess)success failureWithFailure:(requestFail)fail;
@end
