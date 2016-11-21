//
//  HomeModel.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface HomeModel : JSONModel
@property (nonatomic, copy) NSString *author; // 发帖人
@property (nonatomic, strong) NSNumber *author_id; // 发帖人Id

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
 关注状态 0：未关注 1：已关注
 */
@property (nonatomic, assign) NSInteger if_focus;
@property (nonatomic, strong) NSNumber *ID; // 帖子id
@property (nonatomic, strong) NSNumber *detail_refparam; // 关联id
/**
 图片数量
 */
@property (nonatomic, assign) NSInteger images_count;
/**
 类型
 */
@property (nonatomic, strong) NSString *sdata_type;
/**
 来自哪里
 */
@property (nonatomic, strong) NSString *detail_type_from;
@property (nonatomic, strong) NSString *detail_type; // 帖子类型
@property (nonatomic, copy) NSString *transformDate;// 发帖时间（转换过的）
@property (nonatomic, assign) NSInteger replies; // 回复数
@property (nonatomic, assign) NSInteger upvotes; // 点赞数
@property (nonatomic, assign) NSInteger favorites; // 收藏数
@property (nonatomic, assign) NSInteger favoritenum; // 收藏数 晒图详情
@property (nonatomic, assign) NSInteger hits; // 点击数
@property (nonatomic, copy) NSString *authorportrait; // 头像
@property (nonatomic, strong) NSArray *images; // 图像
@property (nonatomic, strong) NSArray *tags; // 标签
/**
 标签标题数组
 */
@property (nonatomic, strong) NSMutableArray *tagsTitleArr;
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *publish_date;// 发帖时间
// ---------关注标签
@property (nonatomic, copy) NSString *name; // 标题
@property (nonatomic, assign) NSInteger focus; // 关注数
@property (nonatomic, assign) NSInteger sdata_total_num; // 话题总数
@property (nonatomic, assign) NSInteger sdata_today_num; // 今天话题数
@property (nonatomic, assign) NSInteger subject_id; // 话题id
@property (nonatomic, copy) NSString *type; // 标签类型
//------------------
/**
 回复内容
 */
@property (nonatomic, copy) NSString *content;
/**
 回复内容高度
 */
@property (nonatomic, assign) CGFloat contentHeight;

/**
 分享网址
 */
@property (nonatomic, copy) NSString *m_url;
/**
 标签id
 */
@property (nonatomic, strong) NSDictionary *tagIDDic;
/**
 标签类型
 */
@property (nonatomic, strong) NSDictionary *tagTypeDic;
@property (nonatomic, strong) NSNumber *if_favorite; // 收藏 数字,0表示未收藏，1表示收藏
@property (nonatomic, strong) NSNumber *if_upvotes; // 数字,0表示未点赞，1表示点赞
/** cell的高度 */
@property (nonatomic, assign) CGFloat cellHeight;
/** 图片的height */
@property (nonatomic, assign) CGFloat pictureHeight;
/** 标签的总高度 */
@property (nonatomic, assign) CGFloat allTagsHeight;
@property (nonatomic, assign,getter=isPraiseBtnSelected) BOOL praiseBtnSelected;
@property (nonatomic, assign,getter=isCollectionBtnSelected) BOOL collectionBtnSelected;
/**
 简要描述
 */
@property (nonatomic, copy) NSString *description_;


@end
