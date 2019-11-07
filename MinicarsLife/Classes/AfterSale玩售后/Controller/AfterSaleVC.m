//
//  AfterSaleVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "AfterSaleVC.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "TelephoneView.h"
#import "ConsultingZoneVC.h"
@interface AfterSaleVC ()
{
    NSDictionary *dataDic;
}

@property (nonatomic, strong) SelVideoPlayer *player;

@property (nonatomic, strong)UILabel *nameLbl;

@property (nonatomic , strong)TelephoneView *telephoneView;

@property (nonatomic , strong)NSMutableArray *videoAry;
@property (nonatomic , strong)NSDictionary *videoDic;
@property (nonatomic , strong)NSMutableArray *imgAry;

@end

@implementation AfterSaleVC

-(TelephoneView *)telephoneView
{
    if (!_telephoneView) {
        _telephoneView = [[TelephoneView alloc]initWithFrame:CGRectMake(0, 0, 300, 187 + 41)];
    }
    return _telephoneView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.player _pauseVideo];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"玩售后";
    titleLbl.font = HGboldfont(18);
    titleLbl.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLbl;
    
    self.view.backgroundColor = kWhiteColor;
//    [self videoView];
    self.videoAry = [NSMutableArray array];
    [self loadData];
    
    
    
    
}

-(void)btnClick:(UIButton *)sender
{
    if (sender.tag == 0) {
        ConsultingZoneVC *vc = [ConsultingZoneVC new];
        vc.type = @"1";
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"售后问答";
        [self.navigationController pushViewController:vc animated:YES];
    }else
    {
        ConsultingZoneVC *vc = [ConsultingZoneVC new];
        vc.type = @"2";
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = @"用车咨询";
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)loadData
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630587";
    http.showView = self.view;
    http.parameters[@"bizCode"] = @"RT201911011052453667232";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
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
        [self videoView];
//        _scrollView.data = _imgAry;
        
        
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)playBtnClick
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630588";
    http.parameters[@"code"] = _videoDic[@"code"];
    [http postWithSuccess:^(id responseObject) {
        
        
        
    } failure:^(NSError *error) {
        
    }];
    
    SelPlayerConfiguration *configuration = [[SelPlayerConfiguration alloc]init];
    configuration.shouldAutoPlay = YES;
    configuration.supportedDoubleTap = YES;
    configuration.shouldAutorotate = NO;
    configuration.repeatPlay = NO;
    configuration.statusBarHideState = SelStatusBarHideStateAlways;
    configuration.sourceUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[_videoDic[@"url"] convertImageUrl]]];
    configuration.videoGravity = SelVideoGravityResize;
    
    //    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(15, 7.5, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200) configuration:configuration];
    //    _player.backgroundColor = kWhiteColor;
    kViewRadius(_player, 4);
    [self.view addSubview:_player];
}


-(void)videoView
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 164 - 64)];
    topView.backgroundColor = MainColor;
    [self.view addSubview:topView];
    
    UIImageView *thumbnailImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 7.5, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200)];
    kViewRadius(thumbnailImg, 4);
    //    thumbnailImg.backgroundColor = [UIColor redColor];
    [thumbnailImg sd_setImageWithURL:[NSURL URLWithString:[_videoDic[@"thumbnail"] convertImageUrl]]];
    [self.view addSubview:thumbnailImg];
    
    UIButton *playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    playBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 32.5, 7.5 + (SCREEN_WIDTH - 30)/345*200/2 - 32.5, 65, 65);
    [playBtn setImage:kImage(@"btn_play") forState:(UIControlStateNormal)];
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:playBtn];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(15, 7.5 + (SCREEN_WIDTH - 30)/345*200 - 80, SCREEN_WIDTH - 30, 80);
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [self.view.layer addSublayer:gl];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(30, thumbnailImg.height - 27.5 - 20 + 7.5, SCREEN_WIDTH - 60, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
    nameLbl.text = _videoDic[@"name"];
    [self.view addSubview:nameLbl];
    
    UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(30, nameLbl.yy + 2.5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    timeLbl.text = [_videoDic[@"pushDatetime"] convertDate];
    [self.view addSubview:timeLbl];
    
    UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, nameLbl.yy + 2.5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    numberLbl.text = [NSString stringWithFormat:@"%@次播放",_videoDic[@"visitNumber"]];
    [self.view addSubview:numberLbl];
    
    
    _nameLbl = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH/2 - 33, thumbnailImg.yy + 30, 66, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGboldfont(16) textColor:kBlackColor];
    _nameLbl.text = @"咨询专区";
    [self.view addSubview:_nameLbl];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (33 + 4 + 14), thumbnailImg.yy + 35, 14, 12.5)];
    leftImg.image = kImage(@"左");
    [self.view addSubview:leftImg];
    
    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 + (33 + 4), thumbnailImg.yy + 35, 14, 12.5)];
    rightImg.image = kImage(@"右");
    [self.view addSubview:rightImg];
    
    NSArray *ary = @[@"售后问答",@"用车咨询"];
    NSArray *contentAry = @[@"咨询进度及结果",@"咨询车辆使用等"];
    
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(15 + i % 2 * ((SCREEN_WIDTH - 40)/2 + 10), _nameLbl.yy + 15, (SCREEN_WIDTH - 40)/2, 80);
        btn.backgroundColor = kHexColor(@"#F5F5F5");
        kViewRadius(btn, 4);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        btn.tag = i;
        [self.view addSubview:btn];
        
        UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 25, 30, 30)];
        iconImg.image = kImage(ary[i]);
        [btn addSubview:iconImg];
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(52, 20, (SCREEN_WIDTH - 40)/2 - 52, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        nameLbl.text = ary[i];
        [btn addSubview:nameLbl];
        
        UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(52, 43.5, (SCREEN_WIDTH - 40)/2 - 52, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        contentLbl.text = contentAry[i];
        [btn addSubview:contentLbl];
        
    }
    
    
    TLNetworking *http = [TLNetworking new];
    http.code = @"630048";
    http.parameters[@"type"] = @"shouhou";
    http.showView = self.view;
    
    [http postWithSuccess:^(id responseObject) {
        
        dataDic = responseObject[@"data"];
        
        //        _telephoneView.lbl = dataDic[@"customerServicePhone"];
        NSArray *introduceAry = @[[NSString stringWithFormat:@"在线客服业务范围：%@",responseObject[@"data"][@"serviceRange"]],
                                  [NSString stringWithFormat:@"在线客服工作时间工作日 %@",responseObject[@"data"][@"workDatetime"]]];
        
        for (int i = 0 ; i < 2; i ++) {
            UIView *point = [[UIView alloc]initWithFrame:CGRectMake(15, _nameLbl.yy + 95 + 19 + i % 2 * (18 + 4), 4, 4)];
            kViewRadius(point, 2);
            point.backgroundColor = kHexColor(@"#D8D8D8");
            [self.view addSubview:point];
            
            UILabel *lbl = [UILabel labelWithFrame:CGRectMake(25, _nameLbl.yy + 95 + 15 + i % 2 * (18 + 4), SCREEN_WIDTH - 25, 12) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
            lbl.text = introduceAry[i];
            [self.view addSubview:lbl];
            
            if ( i == 1) {
                UIButton *applyBtn = [UIButton buttonWithTitle:@"客服电话" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:4];
                applyBtn.titleLabel.font = HGboldfont(16);
                applyBtn.frame = CGRectMake(15, lbl.yy + 52, SCREEN_WIDTH - 30, 45);
                [applyBtn addTarget:self action:@selector(applyBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
                [self.view addSubview:applyBtn];
            }
            
            
            
        }
        
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
        
    }];
    
    
}

-(void)applyBtnClick
{
    [[USERXX user] showPopAnimationWithAnimationStyle:1 showView:self.telephoneView BGAlpha:0.5 isClickBGDismiss:NO];
    _telephoneView.tele = dataDic[@"customerServicePhone"];;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
