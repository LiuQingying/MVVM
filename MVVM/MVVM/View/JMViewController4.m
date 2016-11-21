//
//  JMViewController4.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMViewController4.h"
#import "JMHomeTableViewModel.h"
#import "JMWaveVeiw.h"
@interface JMViewController4 ()
@property (nonatomic, strong) JMWaveVeiw *headView;
@end

@implementation JMViewController4

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.view.backgroundColor = [UIColor whiteColor];
    self.headView = [[JMWaveVeiw alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    _headView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_headView];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_headView) {
        [_headView startWaveAnimation];
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_headView stopWaveAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
