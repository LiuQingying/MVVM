//
//  JMWaveVeiw.m
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/10.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import "JMWaveVeiw.h"

@interface JMWaveVeiw()
@property (nonatomic,assign)CGFloat yHeight;/**< 当前进度对应的y值,由于y是向下递增,所以要注意 */
@property (nonatomic,assign)CGFloat offset;/**< 偏移量,决定了这个点在y轴上的位置,以此来实现动态效果*/
@property (nonatomic,assign)CGFloat offset1;
@property (nonatomic,strong)CADisplayLink * link;/**< 定时器*/
@property (nonatomic,strong)CAShapeLayer * waveLayer;/**< 水波的layer */
@property (nonatomic,strong)UILabel * label;
/**
 头像
 */
@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation JMWaveVeiw
- (UIView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 25, 60, 60)];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.layer.cornerRadius = 30;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.centerX = 0.5*kScreenWidth;
        _headImageView.image = [UIImage imageNamed:@"mingren"];
        
    }
    return _headImageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.headImageView];
        self.waveHeight = 5.0;
        self.waveColor = [UIColor colorWithWhite:1 alpha:0.5];
        self.yHeight = self.bounds.size.height-20;
        self.waveLayer = [CAShapeLayer layer];
        self.waveLayer.frame = self.bounds;
        [self.layer addSublayer:self.waveLayer];
        self.speed = 1.0;
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        self.label.font = [UIFont boldSystemFontOfSize:20];
        self.label.textAlignment = 1;
        self.label.textColor = [UIColor orangeColor];
        [self addSubview:self.label];
        self.label.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

        [self stopWaveAnimation];
        [self startWaveAnimation];
        
        
    }
    return self;
}
- (void)drawRect:(CGRect)rect
{
    CGContextRef context2 = UIGraphicsGetCurrentContext();
    CGMutablePathRef path2 = CGPathCreateMutable();
    
    CGContextSetFillColorWithColor(context2, [[UIColor orangeColor] CGColor]);
    CGFloat waveHeight = self.waveHeight;
//    self.offset1 += self.speed;

    CGFloat orignOffY = 0.0;
    CGFloat startOffY = waveHeight * cosf((self.offset+60) * M_PI * 2 / self.bounds.size.width);
    CGPathMoveToPoint(path2, NULL, 0, startOffY);
    for(float i = 0;i <= self.bounds.size.width;i++){
        orignOffY = waveHeight * cosf(2 * M_PI / self.bounds.size.width * i + (self.offset+60) * M_PI * 2 / self.bounds.size.width) + self.yHeight;
        CGPathAddLineToPoint(path2, NULL, i, orignOffY);
    }
    CGPathAddLineToPoint(path2, NULL, self.bounds.size.width, orignOffY);
    CGPathAddLineToPoint(path2, nil, self.bounds.size.width, rect.size.height);
    CGPathAddLineToPoint(path2, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path2, nil, 0, startOffY);
    
    CGContextAddPath(context2, path2);
    CGContextFillPath(context2);
    CGPathRelease(path2);
    
}

-(void)setProgress:(CGFloat)progress
{
    _progress = progress;
    //将进度转成百分比.
    self.label.text = [NSString stringWithFormat:@"%ld%%",[[NSNumber numberWithFloat:progress * 100] integerValue]];
    [self.label sizeToFit];
    //由于y坐标轴的方向是由上向下,逐渐增加的,所以这里对于y坐标进行处理
    self.yHeight = self.bounds.size.height * (1 - progress);
    //先停止动画,然后在开始动画,保证不会有什么冲突和重复.
    [self stopWaveAnimation];
    [self startWaveAnimation];
}

#pragma mark -- 开始波动动画
- (void)startWaveAnimation
{
    
    //相对于NSTimer CADisplayLink更准确,每一帧调用一次.
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(waveAnimation)];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark -- 停止波动动画
- (void)stopWaveAnimation
{
    [self.link invalidate];
    self.link = nil;
}


#pragma mark -- 波动动画实现
- (void)waveAnimation
{
    
    

    
    //如果是0或者1,则不需要wave的高度,否则会看出来一个小的波动.
//    if (self.progress == 0.0f || self.progress == 1.0f) {
//        waveHeight = 0.f;
//    }
    //累加偏移量,这样就可以通过speed来控制波动的速度了.对于正弦函数中的各个参数,你可以通过上面的注释进行了解.
    CGFloat waveHeight = self.waveHeight;
    self.offset += self.speed;
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGFloat startOffY = waveHeight * sinf(self.offset * M_PI * 2 / self.bounds.size.width);
    CGFloat orignOffY = 0.0;
    CGPathMoveToPoint(pathRef, NULL, 0, startOffY);
    for (CGFloat i = 0.f; i <= self.bounds.size.width; i++) {
        orignOffY = waveHeight * sinf(2 * M_PI / self.bounds.size.width * i + self.offset * M_PI * 2 / self.bounds.size.width) + self.yHeight;
        CGPathAddLineToPoint(pathRef, NULL, i, orignOffY);
    }
    //连接四个角和以及波浪,共同组成水波.
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, orignOffY);
    CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, self.bounds.size.height);
    CGPathAddLineToPoint(pathRef, NULL, 0, startOffY);
    CGPathCloseSubpath(pathRef);
    self.waveLayer.path = pathRef;
    self.waveLayer.fillColor = self.waveColor.CGColor;
    CGPathRelease(pathRef);
    [self setNeedsDisplay];
   
}


@end
