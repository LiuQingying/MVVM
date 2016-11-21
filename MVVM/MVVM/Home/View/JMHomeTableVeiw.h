//
//  JMHomeTableVeiw.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JMHomeTableViewModel;
@class JMHomeTableVeiw;
@protocol JMHomeTableVeiwDelegate <NSObject,UIScrollViewDelegate>

@optional

@end
@interface JMHomeTableVeiw : UITableView
/**
 代理
 */
@property (nonatomic, weak) id<JMHomeTableVeiwDelegate> JM_delegate;
/**
 viewModel
 */
@property (nonatomic, strong) JMHomeTableViewModel *viewModel;
@end
