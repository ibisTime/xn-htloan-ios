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
        
        
        
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630587";
        http.showView = self;
        http.parameters[@"bizCode"] = @"RT201911011052313086637";
        http.parameters[@"status"] = @"1";
        [http postWithSuccess:^(id responseObject) {
            
            NSMutableArray *_videoAry = [NSMutableArray array];
            NSDictionary *_videoDic;
            NSArray *dataAry = responseObject[@"data"];
            for (int i = 0; i < dataAry.count; i ++) {
                if ([dataAry[i][@"kind"] isEqualToString:@"1"]) {
                    [_videoAry addObject:dataAry[i]];
                }
            }
            for (int i = 0;  i < _videoAry.count; i ++) {
                if ([_videoAry[i][@"location"] isEqualToString:@"1"]) {
                    if ([USERXX isBlankString:_videoDic[@"code"]] == YES) {
                        _videoDic = _videoAry[i];
                    }
                }
            }
            SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
            configuration.shouldAutoPlay = NO;
            configuration.supportedDoubleTap = YES;
            configuration.shouldAutorotate = NO;
            configuration.repeatPlay = NO;
            configuration.statusBarHideState = SelStatusBarHideStateAlways;
            configuration.sourceUrl = [NSURL URLWithString:[_videoDic[@"url"] convertImageUrl]];
            configuration.videoGravity = SelVideoGravityResize;
            
            _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(15, 7.5, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200) configuration:configuration];
            kViewRadius(_player, 4);
            [self addSubview:_player];
            //        _scrollView.data = _imgAry;
            
        } failure:^(NSError *error) {
            
        }];
        
        
        
    }
    return self;
}

@end
