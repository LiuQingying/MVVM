//
//  HomeModel.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/4.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return YES;
}
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id": @"ID",
                                                       @"description" : @"description_"
                                                       }];
}
- (CGFloat)cellHeight{
    if (_cellHeight) {
        return _cellHeight;
    }
    NSString *imagStr = self.images[0][@"small"];
    NSString *str = [imagStr substringFromIndex:imagStr.length - 16];
    NSString *str1 = [str substringToIndex:str.length - 4];
    __block CGFloat height = 0;
    __block CGFloat width = 0;
    if([str rangeOfString:@"_h"].location !=NSNotFound &&[str rangeOfString:@"_w"].location !=NSNotFound){
        NSRange heightRange = [str rangeOfString:@"_h"];
        if (str1.length > heightRange.location + 2) {
            
            NSString *hStr = [str1 substringFromIndex:heightRange.location + 2];
            height = [hStr floatValue]; // 通过截取字符串获得图片的高度
            NSRange widthRange = [str rangeOfString:@"_w"];
            NSInteger length = heightRange.location-widthRange.location-2;
            width = [[str1 substringWithRange:NSMakeRange(widthRange.location+2, length)]  floatValue];
    
            _cellHeight = (kScreenWidth-10)/width*height +45;
            return _cellHeight;
        }else{
            return 345;

        }
    }else{
        return 345;
    }
    
}
@end
