//
//  JMTipView.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/14.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMTipView.h"

@implementation JMTipView
+ (void)showTipsOnView:(UIView*)view
               message:(NSString*)message
                 times:(CGFloat)second
               yoffset:(CGFloat)offsetY{
    
    MBProgressHUD *HUD;
    if (offsetY == 0) {
        offsetY = -30.0;
    }
    HUD = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:HUD];
    HUD.detailsLabel.text = message;
    HUD.detailsLabel.font = [UIFont systemFontOfSize:16];
    HUD.mode = MBProgressHUDModeText;
    HUD.userInteractionEnabled = YES;
    CGPoint offset = HUD.offset;
    offset.y = offsetY;
    HUD.offset = offset;
    [HUD showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(second * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [HUD removeFromSuperview];
    });
    
}

@end
