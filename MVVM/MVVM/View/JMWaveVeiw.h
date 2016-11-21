//
//  JMWaveVeiw.h
//  MVVMDEMO
//
//  Created by LiuQingying on 16/11/10.
//  Copyright © 2016年 LiuQingying. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JMWaveVeiw : UIView
@property (nonatomic,assign)CGFloat progress;
@property (nonatomic,assign)CGFloat speed;/**< 波动的速度*/
@property (nonatomic,strong)UIColor * waveColor;
@property (nonatomic,assign)CGFloat waveHeight;
- (void)stopWaveAnimation;
- (void)startWaveAnimation;
@end
