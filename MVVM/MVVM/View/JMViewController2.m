//
//  JMViewController2.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMViewController2.h"

@interface JMViewController2 ()
@property (nonatomic, assign) int clickCount;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UIControl *popControl;
@end

@implementation JMViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupFooterView];
    _clickCount = 0;
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_clickCount%2==1) {
        _clickCount=0;
    }
    [self.view.layer setTransform:CATransform3DIdentity];
    
    self.parentViewController.view.backgroundColor = [UIColor whiteColor];
}

- (void)setupFooterView{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    bgView.hidden = YES;
    self.bgView = bgView;
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha =0.2;
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    UIControl *popControl = [[UIControl alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight)];
    self.popControl = popControl;
    popControl.backgroundColor = [UIColor clearColor];
    [popControl addTarget:self action:@selector(clickPopControl) forControlEvents:UIControlEventTouchUpInside];
    [[UIApplication sharedApplication].keyWindow addSubview:popControl];
    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight*0.3, kScreenWidth, kScreenHeight*0.7)];
    testView.backgroundColor = [UIColor whiteColor];
    testView.userInteractionEnabled = NO;
    [popControl addSubview:testView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    _clickCount++;
    if (_clickCount%2==1) {
        _bgView.hidden = NO;
        self.parentViewController.view.backgroundColor = [UIColor blackColor];
        [UIView animateWithDuration:0.2f animations:^{
            [self.view.layer setTransform:[self firstTransform]];
        } completion:^(BOOL finished){
            [UIView animateWithDuration:0.2f animations:^{
                [self.view.layer setTransform:[self secondTransformWithView:self.view]];
            } completion:^(BOOL finished){
            
            }];
        }];

    }else{
        _bgView.hidden = YES;
        [UIView animateWithDuration:0.2 animations:^{
            [self reAnimateForView:self.view];
        }];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.popControl.y = 0;
    }];
    
    
}
- (void)clickPopControl{
    [UIView animateWithDuration:0.2 animations:^{
        [self reAnimateForView:self.view];
    }];
    _clickCount++;
    _bgView.hidden = YES;
    [UIView animateWithDuration:0.4 animations:^{
        self.popControl.y = kScreenHeight;
    }];
}
- (void)reAnimateForView:(UIView *)view
{
    [UIView animateWithDuration:0.2f animations:^{
        [view.layer setTransform:[self firstTransform]];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.2f animations:^{
            [view.layer setTransform:CATransform3DIdentity];
        }];
    }];
}

-(CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    t1 = CATransform3DRotate(t1, 15.0f * M_PI/180.0f, 1, 0, 0);
    return t1;
    
}

-(CATransform3D)secondTransformWithView:(UIView*)view{
    
    CATransform3D t2 = CATransform3DIdentity;
    t2.m34 = [self firstTransform].m34;
    t2 = CATransform3DTranslate(t2, 0, view.frame.size.height*-0.08, 0);
    t2 = CATransform3DScale(t2, 0.8, 0.8, 1);
    return t2;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
