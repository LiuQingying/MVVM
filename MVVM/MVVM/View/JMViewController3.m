//
//  JMViewController3.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMViewController3.h"
#import "HomeModel.h"
#import "JMHomeTableViewModel.h"
#import "JMTaobaoCell.h"
@interface JMViewController3 ()<UITableViewDelegate,UITableViewDataSource,JMHomeTableViewModelDelegate>
@property (nonatomic,strong) UITableView *tableView;
/**
 view model
 */
@property (nonatomic, strong) JMHomeTableViewModel *homeViewModel;
/**
 模型数组
 */
@property (nonatomic, strong) NSMutableArray<HomeModel*> *homeModelsArr;
@end
static NSString *const taobaoCellID = @"JMTaobaoCell";
@implementation JMViewController3
- (NSMutableArray<HomeModel *> *)homeModelsArr{
    if (!_homeModelsArr) {
        _homeModelsArr = [NSMutableArray array];
    }
    return _homeModelsArr;
}
- (JMHomeTableViewModel *)homeViewModel{
    if (!_homeViewModel) {
        _homeViewModel = [[JMHomeTableViewModel alloc] init];
        _homeViewModel.delegate = self;
    }
    return _homeViewModel;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20) style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, kTabBarHeight, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = JMTableViewBackgroundColor;
        [_tableView registerClass:[JMTaobaoCell class] forCellReuseIdentifier:taobaoCellID];
    }
    return _tableView;
    
}
#pragma mark life circle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self.homeViewModel fetchData];
    
}
#pragma mark JMHomeTableViewModelDelegate
- (void)handleRequestSucceed:(NSArray *)dataArr{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [self.tableView reloadData];
}
- (void)handleRequestFailed:(NSError *)err{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [JMTipView showTipsOnView:self.view message:@"网络不给力☹️" times:2 yoffset:0];
}
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.homeViewModel.homeModelsArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    JMTaobaoCell *cell = [tableView dequeueReusableCellWithIdentifier:taobaoCellID forIndexPath:indexPath];
    HomeModel *model = self.homeViewModel.homeModelsArr[indexPath.row];
    cell.homeModel = model;
    return cell;
}
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [tableView fd_heightForCellWithIdentifier:taobaoCellID cacheByIndexPath:indexPath configuration:^(JMTaobaoCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
    
}

- (void)configureCell:(JMTaobaoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.fd_enforceFrameLayout = NO;
    cell.homeModel = self.homeViewModel.homeModelsArr[indexPath.row];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
