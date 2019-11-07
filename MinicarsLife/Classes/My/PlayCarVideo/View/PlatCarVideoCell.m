//
//  PlatCarVideoCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "PlatCarVideoCell.h"

@implementation PlatCarVideoCell
{
    UIImageView *thumbnailImg;
    UILabel *nameLbl;
    UILabel *timeLbl;
    UILabel *numberLbl;
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        thumbnailImg = [[UIImageView alloc]initWithFrame:CGRectMake(15,  15, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200)];
        kViewRadius(thumbnailImg, 4);
        //    thumbnailImg.backgroundColor = [UIColor redColor];
        
        [self addSubview:thumbnailImg];
        
        UIButton *playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        playBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 32.5, 15 + (SCREEN_WIDTH - 30)/345*200/2 - 32.5, 65, 65);
        [playBtn setImage:kImage(@"btn_play") forState:(UIControlStateNormal)];
        [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:playBtn];
        
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(15, 15 + (SCREEN_WIDTH - 30)/345*200 - 80, SCREEN_WIDTH - 30, 76);
        gl.startPoint = CGPointMake(0.5, 0);
        gl.endPoint = CGPointMake(0.5, 1);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor];
        gl.locations = @[@(0), @(1.0f)];
        [self.layer addSublayer:gl];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(30, 15 + thumbnailImg.height - 27.5 - 20 + 7.5, SCREEN_WIDTH - 60, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
//        nameLbl.text = _videoDic[@"name"];
        [self addSubview:nameLbl];
        
        timeLbl = [UILabel labelWithFrame:CGRectMake(30, nameLbl.yy + 2.5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
//
        [self addSubview:timeLbl];
        
        numberLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, nameLbl.yy + 2.5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
//
        [self addSubview:numberLbl];
        
    }
    return self;
}

-(void)playBtnClick
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630588";
    http.parameters[@"code"] = _model.code;
    [http postWithSuccess:^(id responseObject) {
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    [_delegate clickVideo:_row + 1000];
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = NO;
    configuration.repeatPlay = NO;
    configuration.statusBarHideState = SelStatusBarHideStateAlways;
    configuration.sourceUrl = [NSURL URLWithString:[_model.url convertImageUrl]];
    configuration.videoGravity = SelVideoGravityResize;
    
    //    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200) configuration:configuration];
    //    _player.backgroundColor = kWhiteColor;
    kViewRadius(_player, 4);
    _player.tag = _row + 1000;
    [self addSubview:_player];
    
}

-(void)setRow:(NSInteger)row
{
    _row = row;
}

-(void)setModel:(PlayCarVideoModel *)model
{
    _model = model;
    [thumbnailImg sd_setImageWithURL:[NSURL URLWithString:[model.thumbnail convertImageUrl]]];
    nameLbl.text = model.name;
    timeLbl.text = [model.pushDatetime convertDate];
    numberLbl.text = [NSString stringWithFormat:@"%@次播放",model.visitNumber];
}

@end
