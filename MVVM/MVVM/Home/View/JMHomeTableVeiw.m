//
//  JMHomeTableVeiw.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMHomeTableVeiw.h"
@interface JMHomeTableVeiw()

@property (nonatomic, strong) UITableView *tableView;
@end

@implementation JMHomeTableVeiw
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self = [super initWithFrame:frame style:style]) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = JMTableViewBackgroundColor;
        
    }
    return  self;
}
@end
