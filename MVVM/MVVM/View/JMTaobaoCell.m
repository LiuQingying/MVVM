//
//  JMTaobaoCell.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/11.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMTaobaoCell.h"

@interface JMTaobaoCell()

/**
 用户名
 */
@property (strong, nonatomic) UILabel *userNameLabel;
/**
 时间
 */
@property (nonatomic, strong) UILabel *timeLabel;
/**
 图片
 */
@property (nonatomic, strong) UIImageView *pictureView;
/**
 头像
 */
@property (nonatomic, strong) UIButton *headButton;
@end

@implementation JMTaobaoCell
- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] init];
        _userNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _userNameLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
- (UIImageView *)pictureView{
    if (!_pictureView) {
        _pictureView = [[UIImageView alloc] init];
        _pictureView.clipsToBounds = YES;
        _pictureView.backgroundColor = [UIColor grayColor];
        _pictureView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _pictureView;
}
- (UIButton *)headButton{
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _headButton;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self loadViews];
    }
    return self;
}
- (void)loadViews{
    [self.contentView addSubview:self.headButton];
    [_headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    [self.contentView addSubview:self.userNameLabel];
    [_userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(5);
        make.top.equalTo(_headButton.mas_top).offset(-2);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        
    }];
    [self.contentView addSubview:self.timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_right).offset(5);
        make.bottom.equalTo(_headButton.mas_bottom);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        
    }];

    [self.contentView addSubview:self.pictureView];
    [_pictureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headButton.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.top.equalTo(_headButton.mas_bottom).offset(5);
        make.height.equalTo(@200);
        make.bottom.equalTo(self.contentView.mas_bottom).priorityLow();

    }];
    UIView *view = [[UIView alloc] init];
    [self.contentView addSubview:view];

}
- (void)updateConstraints{
    [_pictureView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.equalTo(@(self.homeModel.pictureHeight));
        
    }];
    [super updateConstraints];
}
- (void)setHomeModel:(HomeModel *)homeModel{
    _homeModel = homeModel;
    _userNameLabel.text = homeModel.author;
    _timeLabel.text = homeModel.transformDate;
    if (!homeModel.pictureHeight) {
        NSString *imagStr = homeModel.images[0][@"small"];
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
                
                homeModel.pictureHeight = (kScreenWidth-10)/width*height;
                
            }else{
                homeModel.pictureHeight = 345;
                
            }
        }

    }
    [self setNeedsUpdateConstraints];
    
    [_headButton sd_setImageWithURL:[NSURL URLWithString:homeModel.authorportrait] forState:UIControlStateNormal];
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:homeModel.images[0][@"small"]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setFrame:(CGRect)frame{
    if (frame.origin.y==0) {
        return [super setFrame:frame];
    }
    frame.size.height-=5;
    frame.origin.y+=5;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
