//
//  JMHomeTableViewModel.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMHomeTableViewModel.h"
#import "HomeModel.h"
@implementation JMHomeTableViewModel
- (instancetype)init{
    if (self = [super init]) {
        _page = @"1";
    }
    return self;
}
- (NSMutableArray<HomeModel *> *)homeModelsArr{
    if (!_homeModelsArr) {
        _homeModelsArr = [NSMutableArray array];
    }
    return _homeModelsArr;
}
- (void)fetchDataWithProgress:(requestProgress)requestProgress success:(requestSuccess)success failureWithFailure:(requestFail)fail{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page_size"] = @10;
    parameters[@"page"] = self.page;
   self.requestProxy = [[[JMRequestUtility alloc] init] get:@"https://brandrelliance.actoys.net/socializationapiv2/web/index.php?r=index/playershow_index" parameters:parameters progress:^(NSProgress *progress) {
        NSLog(@"progress---%@",progress);
       
        requestProgress(progress);
    } success:^(NSDictionary *responseDict) {
        NSArray *modelsArr = [HomeModel arrayOfModelsFromDictionaries:responseDict[@"data"] error:nil];
        success(modelsArr);
        NSLog(@"%@",responseDict);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        fail(error);

    }];

}
- (void)fetchData{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page_size"] = @10;
    parameters[@"page"] = self.page;
    self.requestProxy = [[[JMRequestUtility alloc] init] get:@"https://brandrelliance.actoys.net/socializationapiv2/web/index.php?r=index/playershow_index" parameters:parameters progress:^(NSProgress *progress) {
        NSLog(@"progress---%@",progress);
    
    } success:^(NSDictionary *responseDict) {
        if ([self.page integerValue] ==1) {
            [self.homeModelsArr removeAllObjects];
        }
        NSArray *modelsArr = [HomeModel arrayOfModelsFromDictionaries:responseDict[@"data"] error:nil];
        [self.homeModelsArr addObjectsFromArray:modelsArr];
        if ([_delegate respondsToSelector:@selector(handleRequestSucceed:)]) {
            [_delegate handleRequestSucceed:self.homeModelsArr];
        }
        if (modelsArr.count<1) {
            [self resumePage];
            
        }
        NSLog(@"%@",responseDict);
    } failure:^(NSError *error) {
        if ([_delegate respondsToSelector:@selector(handleRequestFailed:)]) {
            [_delegate handleRequestFailed:error];
        }
        [self resumePage];
        
    }];

}
- (void)fetchNewData{
    self.page = @"1";
    [self fetchData];
}
- (void)fetchMoreData{
    NSInteger page = [_page integerValue];
    page++;
    _page = [NSString stringWithFormat:@"%ld",page];
    [self fetchData];

}
- (void)resumePage{
    NSInteger page = [_page integerValue];
    page--;
    _page = [NSString stringWithFormat:@"%ld",page];

}
@end
