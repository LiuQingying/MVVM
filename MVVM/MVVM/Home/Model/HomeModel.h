//
//  HomeModel.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HomeModel : JSONModel
/**
 发帖人
 */
@property (nonatomic, copy) NSString *author;
/**
 发帖人Id
 */
@property (nonatomic, strong) NSNumber *author_id;
/**
 同好人Id
 */
@property (nonatomic, strong) NSString *uid;

/**
 同好人名字
 */
@property (nonatomic, strong) NSString *username;
/**
 同好活跃于
 */
@property (nonatomic, strong) NSString *active;
/**
 同好签名
 */
@property (nonatomic, strong) NSString *signature;
/**
 同好标签
 */
@property (nonatomic, strong) NSArray *subjects;
/**
 同好头像
 */
@property (nonatomic, strong) NSString *portrait;
/**
 图片数量
 */
@property (nonatomic, assign) NSInteger images_count;
/**
 类型
 */
@property (nonatomic, strong) NSString *sdata_type;
/**
 发帖时间（转换过的）
 */
@property (nonatomic, copy) NSString *transformDate;
/**
 头像
 */
@property (nonatomic, copy) NSString *authorportrait;
/**
 图片
 */
@property (nonatomic, strong) NSArray *images;
/**
 发帖时间
 */
@property (nonatomic, copy) NSString *publish_date;

/** 
 cell的高度 
 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 
 图片的height
 */
@property (nonatomic, assign) CGFloat pictureHeight;

@end
