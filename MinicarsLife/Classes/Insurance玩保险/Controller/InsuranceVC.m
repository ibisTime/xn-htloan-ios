//
//  InsuranceVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "InsuranceVC.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
#import "StageProcessView.h"
#import "DetailsView.h"
@interface InsuranceVC ()<ChooseSuperNodeViewDelegate>

@property (nonatomic, strong) SelVideoPlayer *player;
@property (nonatomic, strong)DetailsView *detailsView;
@property (nonatomic, strong)StageProcessView *scrollView;

@property (nonatomic, strong)UILabel *nameLbl;
@property (nonatomic , strong)NSMutableArray *videoAry;
@property (nonatomic , strong)NSDictionary *videoDic;
@property (nonatomic , strong)NSMutableArray *imgAry;
@property (nonatomic , assign)NSInteger indexRow;
@end

@implementation InsuranceVC

-(DetailsView *)detailsView
{
    if (!_detailsView) {
        _detailsView = [[DetailsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _detailsView;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.player _pauseVideo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"玩保险";
    titleLbl.font = HGboldfont(18);
    titleLbl.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLbl;
    self.view.backgroundColor = kWhiteColor;
    [self loadData];
    _videoAry = [NSMutableArray array];
    _imgAry = [NSMutableArray array];
}

-(void)loadData
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630587";
    http.showView = self.view;
    http.parameters[@"bizCode"] = @"RT201911011052165353997";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
        NSArray *dataAry = responseObject[@"data"];
        for (int i = 0; i < dataAry.count; i ++) {
            if ([dataAry[i][@"kind"] isEqualToString:@"1"]) {
                [_videoAry addObject:dataAry[i]];
            }else
            {
                [_imgAry addObject:dataAry[i]];
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
        _scrollView.data = _imgAry;
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)playBtnClick
{
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
    gl.frame = CGRectMake(15, 7.5 + (SCREEN_WIDTH - 30)/345*200 - 80, SCREEN_WIDTH - 30, 76);
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
    _nameLbl.text = @"车险流程";
    [self.view addSubview:_nameLbl];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - (33 + 4 + 14), thumbnailImg.yy + 35, 14, 12.5)];
    leftImg.image = kImage(@"左");
    [self.view addSubview:leftImg];
    
    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 + (33 + 4), thumbnailImg.yy + 35, 14, 12.5)];
    rightImg.image = kImage(@"右");
    [self.view addSubview:rightImg];
    
    [self.view addSubview:self.scrollView];
    
    UIButton *applyBtn = [UIButton buttonWithTitle:@"车险咨询" titleColor:kWhiteColor backgroundColor:MainColor titleFont:16 cornerRadius:4];
    applyBtn.titleLabel.font = HGboldfont(16);
    applyBtn.frame = CGRectMake(15, self.scrollView.yy + 28, SCREEN_WIDTH - 30, 45);
    [self.view addSubview:applyBtn];
    
}

-(StageProcessView *)scrollView
{
    if (!_scrollView) {
        //        CoinWeakSelf;
        [_scrollView removeFromSuperview];
        _scrollView = [StageProcessView initWithFrame:CGRectMake(0, _nameLbl.yy + 15, SCREEN_WIDTH, 182) imageSpacing:1 imageWidth:SCREEN_WIDTH - 130 ];
        _scrollView.initAlpha = 0.5; // 设置两边卡片的透明度
        _scrollView.imageRadius = 4; // 设置卡片圆角
        _scrollView.imageHeightPoor = 34;//
        _scrollView.delegate = self;
        _scrollView.curPageControlColor = [UIColor redColor];
        _scrollView.otherPageControlColor = kHexColor(@"#D6D6D6");
        _scrollView.autoScroll = NO;

        [_scrollView.centerBtn addTarget:self action:@selector(centerIVBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        _scrollView.centerBtn.tag = 0;

        MJWeakSelf;
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            //            selectNum = currentIndex;
            //            weakSelf.clickImageBlock(currentIndex);
            weakSelf.indexRow = currentIndex;
        };
    }
    return _scrollView;
}

-(void)centerIVBtnClick
{
    [[USERXX user]showPopAnimationWithAnimationStyle:1 showView:self.detailsView BGAlpha:0.5 isClickBGDismiss:YES];
    self.detailsView.url = self.imgAry[_indexRow][@"url"];
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
