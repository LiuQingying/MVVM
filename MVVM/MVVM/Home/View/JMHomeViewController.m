//
//  JMHomeViewController.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMHomeViewController.h"
#import "JMHomeTableVeiw.h"
#import "JMHomeTableViewModel.h"
#import "HomeModel.h"
#import "JMHomeCell.h"
@interface JMHomeViewController ()<UITableViewDelegate,UITableViewDataSource,JMHomeTableViewModelDelegate>

@property (nonatomic,strong) JMHomeTableVeiw *homeTableView;
/**
 view model
 */
@property (nonatomic, strong) JMHomeTableViewModel *homeTableViewViewModel;
/**
 模型数组
 */
@property (nonatomic, strong) NSMutableArray<HomeModel*> *homeModelsArr;
@end
static NSString *const homeCellID = @"homeCellID";
@implementation JMHomeViewController
- (JMHomeTableViewModel *)homeTableViewViewModel{
    if (!_homeTableViewViewModel) {
        _homeTableViewViewModel = [[JMHomeTableViewModel alloc] init];
        _homeTableViewViewModel.delegate = self;
    }
    return _homeTableViewViewModel;
}
- (NSMutableArray<HomeModel *> *)homeModelsArr{
    if (!_homeModelsArr) {
        _homeModelsArr = [NSMutableArray array];
    }
    return _homeModelsArr;
}
- (UITableView *)homeTableView{
    if (!_homeTableView) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        _homeTableView = [[JMHomeTableVeiw alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) style:UITableViewStylePlain];
        _homeTableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        [_homeTableView registerClass:[JMHomeCell class] forCellReuseIdentifier:homeCellID];
        _homeTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [_homeTableViewViewModel fetchNewData];
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        }];
        MJRefreshAutoFooter *footer =[MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [_homeTableViewViewModel fetchMoreData];
        }];
        footer.triggerAutomaticallyRefreshPercent = -20;
        _homeTableView.mj_footer = footer ;
        
    }
    return _homeTableView;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.homeTableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.homeTableViewViewModel fetchData];
}
#pragma mark JMHomeTableViewDelegate
- (void)handleRequestSucceed:(NSArray *)dataArr{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self endRefresh];
    [self.homeTableView reloadData];
}
- (void)handleRequestFailed:(NSError *)err{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [JMTipView showTipsOnView:self.view message:@"网络不给力☹️" times:2 yoffset:0];
    [self endRefresh];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _homeTableViewViewModel.homeModelsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellID];
    HomeModel *model = _homeTableViewViewModel.homeModelsArr[indexPath.row];
    cell.homeModel = model;
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeModel *model = _homeTableViewViewModel.homeModelsArr[indexPath.row];
    return model.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)endRefresh{
    [_homeTableView.mj_footer endRefreshing];
    [_homeTableView.mj_header endRefreshing];
}

@end
