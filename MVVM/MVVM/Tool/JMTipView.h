//
//  JMTipView.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/14.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JMTipView : NSObject
+ (void)showTipsOnView:(UIView*)view
               message:(NSString*)message
                 times:(CGFloat)second
               yoffset:(CGFloat)offsetY;
@end
