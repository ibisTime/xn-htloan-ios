//
//  CarsHeadView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CarsHeadView.h"

@implementation CarsHeadView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 164 - 64)];
        topView.backgroundColor = MainColor;
        [self addSubview:topView];
        
        SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
        configuration.shouldAutoPlay = NO;
        configuration.supportedDoubleTap = YES;
        configuration.shouldAutorotate = NO;
        configuration.repeatPlay = NO;
        configuration.statusBarHideState = SelStatusBarHideStateAlways;
        configuration.sourceUrl = [NSURL URLWithString:[@"ltRc65IOy2glJ6O4TpIIzAuI5qtC" convertImageUrl]];
        configuration.videoGravity = SelVideoGravityResize;
        
        //    CGFloat width = self.view.frame.size.width;
        _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(15, 7.5, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200) configuration:configuration];
        //    _player.backgroundColor = kWhiteColor;
        kViewRadius(_player, 4);
        [self addSubview:_player];
    }
    return self;
}

@end
