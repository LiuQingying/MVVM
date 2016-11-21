//
//  JMHomeCell.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/7.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMHomeCell.h"
@interface JMHomeCell()<UIGestureRecognizerDelegate,MWPhotoBrowserDelegate>

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
@property (nonatomic, strong) NSMutableArray *photos;
@end

@implementation JMHomeCell
- (UILabel *)userNameLabel{
    if (!_userNameLabel) {
        _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 200, 20)];
        _userNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _userNameLabel;
}
- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 24, 200, 12)];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont systemFontOfSize:10];
    }
    return _timeLabel;
}
- (UIImageView *)pictureView{
    if (!_pictureView) {
        _pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 40, kScreenWidth-10, 300)];
        _pictureView.clipsToBounds = YES;
        _pictureView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(lookBigPicture)];
        [_pictureView addGestureRecognizer:tap];
    }
    return _pictureView;
}
- (UIButton *)headButton{
    if (!_headButton) {
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.frame = CGRectMake(5, 5, 30, 30);
        _headButton.layer.cornerRadius = 15;
        _headButton.layer.masksToBounds = YES;
    }
    return _headButton;
}
- (NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.userNameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.pictureView];
        [self.contentView addSubview:self.headButton];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (void)setHomeModel:(HomeModel *)homeModel{
    _homeModel = homeModel;
    _userNameLabel.text = homeModel.author;
    _timeLabel.text = homeModel.transformDate;
    [_headButton sd_setImageWithURL:[NSURL URLWithString:homeModel.authorportrait] forState:UIControlStateNormal];
    CGRect frame = _pictureView.frame;
    frame.size.height = homeModel.cellHeight-45;
    _pictureView.frame = frame;
    
    
    [_pictureView sd_setImageWithURL:[NSURL URLWithString:homeModel.images[0][@"small"]] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        [UIView transitionWithView:_pictureView duration:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            _pictureView.alpha = 1;
        } completion:nil];
    }];
    
}
- (void)setFrame:(CGRect)frame{
    if (frame.origin.y==0) {
        return [super setFrame:frame];
    }
    frame.size.height-=5;
    frame.origin.y+=5;
    [super setFrame:frame];
}
- (void)lookBigPicture{
    [self.photos removeAllObjects];
    for (int i=0; i<_homeModel.images.count; i++) {
        MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:_homeModel.images[i][@"big"]]];
        [self.photos addObject:photo];
    }
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = NO;
    BOOL startOnGrid = NO;
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    [browser setCurrentPhotoIndex:0];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.window.rootViewController presentViewController:nc animated:YES completion:nil];

}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}


@end
