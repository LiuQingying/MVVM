//
//  JMTabBarController.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMTabBarController.h"
#import "JMHomeViewController.h"
#import "JMViewController2.h"
#import "JMViewController3.h"
#import "JMViewController4.h"
@interface JMTabBarController ()

@end

@implementation JMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:15],NSFontAttributeName, nil] forState:UIControlStateSelected];
    [self setupChildViewControllers];
}
- (void)setupChildViewControllers{
    [self addChildViewController:@"JMHomeViewController" title:@"首页" imageName:@"home"];
    [self addChildViewController:@"JMViewController3" title:@"微淘" imageName:@"community"];
    [self addChildViewController:@"JMViewController2" title:@"购物车" imageName:@"shangcheng"];
    [self addChildViewController:@"JMViewController4" title:@"我的" imageName:@"my"];
}
- (void)addChildViewController:(NSString *)vcClass title:(NSString *)title imageName:(NSString *)imageName{
    UIViewController *vc = [[NSClassFromString(vcClass) alloc] init];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_helighted",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:vc];
    navc.navigationBarHidden = YES;
    [self addChildViewController:navc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
