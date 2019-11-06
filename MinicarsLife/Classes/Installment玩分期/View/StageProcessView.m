//
//  StageProcessView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "StageProcessView.h"

#import "UIView+Banner.h"
#define ZXMainScrollViewWidth (self.mainScrollView.frame.size.width)
#define ZXMainScrollViewHeight self.mainScrollView.frame.size.height
@interface StageProcessView ()
{
    UILabel *centerLbl;
    UILabel *centerDetailsLbl;
    UILabel *leftLbl;
    UILabel *leftDetailsLbl;
    UILabel *rightLbl;
    UILabel *rightDetailsLbl;
}

/** 页码指示器 */
@property (nonatomic,strong) UIPageControl *pageControl;
@property (nonatomic,strong) UIScrollView *mainScrollView;
@property (nonatomic,strong) UIView *leftIV;
@property (nonatomic,strong) UIView *centerIV;
@property (nonatomic,strong) UIView *rightIV;
@property (nonatomic,assign) NSUInteger currentImageIndex;
@property (nonatomic,assign) CGFloat imgWidth;//图片宽度
@property (nonatomic,assign) CGFloat itemMargnPadding;//间距 2张图片间的间距  默认0
@property (nonatomic,assign) NSInteger imgCount;//数量
@property (nonatomic,weak) NSTimer *timer;

@end
@implementation StageProcessView

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imgWidth = ZXMainScrollViewWidth;
        [self initialization];
        [self setUpUI];
    }
    return self;
}
+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth {
    StageProcessView *scrollView = [[self alloc] initWithFrame:frame];
    scrollView.imgWidth = imageWidth;
    scrollView.itemMargnPadding = imageSpacing;
    return scrollView;
}


+(instancetype)initWithFrame:(CGRect)frame
                imageSpacing:(CGFloat)imageSpacing
                  imageWidth:(CGFloat)imageWidth
                        data:(NSArray *)data{
    StageProcessView *scrollView = [[self alloc] initWithFrame:frame];
    scrollView.imgWidth = imageWidth;
    scrollView.itemMargnPadding = imageSpacing;
    scrollView.data = data;
    return scrollView;
}

-(void)initialization{
    _initAlpha = 1;
    _autoScrollTimeInterval = 2.0;
    _imageHeightPoor = 0;
    self.otherPageControlColor = [UIColor grayColor];
    self.curPageControlColor = [UIColor whiteColor];
    _showPageControl = YES;
    _hidesForSinglePage = YES;
    _autoScroll = YES;
    //    self.data = [NSArray array];
}

-(void)setUpUI{
    [self addSubview:self.mainScrollView];
    //图片视图；左边
    //    self.leftIV = [[UIImageView alloc] init];
    //    self.leftIV.contentMode = UIViewContentModeScaleToFill;
    //    self.leftIV.userInteractionEnabled = YES;
    //    [self.leftIV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftTapGes)]];
    //    [self.mainScrollView addSubview:self.leftIV];
    
    UIView *leftBackView = [[UIView alloc]initWithFrame:CGRectZero];
    leftBackView.backgroundColor =kHexColor(@"#FFBD64");
    leftBackView.layer.cornerRadius=4;
    self.leftIV = leftBackView;
    [self.mainScrollView addSubview:leftBackView];
    
    UIView *centerIVBackView = [[UIView alloc]initWithFrame:CGRectZero];
    centerIVBackView.backgroundColor =kHexColor(@"#FFBD64");;
    self.centerIV = centerIVBackView;
    centerIVBackView.layer.cornerRadius=4;
    [self.mainScrollView addSubview:centerIVBackView];
    
    
    UIView *rightIVBackView = [[UIView alloc]initWithFrame:CGRectZero];
    rightIVBackView.backgroundColor =kHexColor(@"#FFBD64");;
    rightIVBackView.layer.cornerRadius=4;
    self.rightIV = rightIVBackView;
    [self.mainScrollView addSubview:rightIVBackView];
    
    
    [self updateViewFrameSetting];
    
    UIImageView *leftImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 130)/2 - 17.5, 21, 35, 35)];
    leftImg.image = kImage(@"流程头图");
    [leftBackView addSubview:leftImg];

    leftLbl = [UILabel labelWithFrame:CGRectMake(0, leftImg.yy + 5.5, (SCREEN_WIDTH - 130), 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
    leftLbl.text = @"购车流程";
    [leftBackView addSubview:leftLbl];

    leftDetailsLbl = [UILabel labelWithFrame:CGRectMake(15, leftLbl.yy + 13, (SCREEN_WIDTH - 130) - 30, 0) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    leftDetailsLbl.numberOfLines = 3;
    leftDetailsLbl.text = @"选择心意车型，填写姓名，手机号、身份证等相关x资料即可申请";
    [leftDetailsLbl sizeToFit];
    [leftBackView addSubview:leftDetailsLbl];

    UIButton *leftBtn = [UIButton buttonWithTitle:@"点击查看详情" titleColor:kHexColor(@"#FFF0DB") backgroundColor:kHexColor(@"#EBA342") titleFont:12 cornerRadius:11];
    leftBtn.frame = CGRectMake((SCREEN_WIDTH - 130) / 2 - 50, 145, 100, 22);
    [leftBackView addSubview:leftBtn];

    
    
//    CGFloat centerIVBackViewHeight = 320;
    
    UIImageView *centerImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 130)/2 - 17.5, 21, 35, 35)];
    centerImg.image = kImage(@"流程头图");
    [centerIVBackView addSubview:centerImg];
    
    centerLbl = [UILabel labelWithFrame:CGRectMake(0, centerImg.yy + 5.5, (SCREEN_WIDTH - 130), 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
    centerLbl.text = @"购车流程";
    [centerIVBackView addSubview:centerLbl];
    
    
    centerDetailsLbl = [UILabel labelWithFrame:CGRectMake(15, centerLbl.yy + 13, SCREEN_WIDTH - 160, 0) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    centerDetailsLbl.numberOfLines = 3;
    centerDetailsLbl.text = @"选择心意车型，填写姓名，手机号、身份证等相关x资料即可申请";
    [centerDetailsLbl sizeToFit];
    [centerIVBackView addSubview:centerDetailsLbl];
    
    UIButton *centerBtn = [UIButton buttonWithTitle:@"点击查看详情" titleColor:kHexColor(@"#FFF0DB") backgroundColor:kHexColor(@"#EBA342") titleFont:12 cornerRadius:11];
    centerBtn.frame = CGRectMake((SCREEN_WIDTH - 130) / 2 - 50, 145, 100, 22);
    [centerIVBackView addSubview:centerBtn];
    self.centerBtn = centerBtn;


    UIImageView *rightImg = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 130)/2 - 17.5, 21, 35, 35)];
    rightImg.image = kImage(@"流程头图");
    [rightIVBackView addSubview:rightImg];

    rightLbl = [UILabel labelWithFrame:CGRectMake(0, rightImg.yy + 5.5, (SCREEN_WIDTH - 130), 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
    rightLbl.text = @"购车流程";
    [rightIVBackView addSubview:rightLbl];

    rightDetailsLbl = [UILabel labelWithFrame:CGRectMake(15, rightLbl.yy + 13, (SCREEN_WIDTH - 130) - 30, 0) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    rightDetailsLbl.numberOfLines = 3;
    rightDetailsLbl.text = @"选择心意车型，填写姓名，手机号、身份证等相关x资料即可申请";
    [rightDetailsLbl sizeToFit];
    [rightIVBackView addSubview:rightDetailsLbl];

    UIButton *rightBtn = [UIButton buttonWithTitle:@"点击查看详情" titleColor:kHexColor(@"#FFF0DB") backgroundColor:kHexColor(@"#EBA342") titleFont:12 cornerRadius:11];
    rightBtn.frame = CGRectMake((SCREEN_WIDTH - 130) / 2 - 50, 145, 100, 22);
    [rightIVBackView addSubview:rightBtn];
    
    
}



- (void)setImageHeightPoor:(CGFloat)imageHeightPoor {
    _imageHeightPoor = imageHeightPoor;
    [self updateViewFrameSetting];
}

//创建页码指示器
-(void)createPageControl{
    if (_pageControl) [_pageControl removeFromSuperview];
    if (self.data.count == 0) return;
    if ((self.data.count == 1) && self.hidesForSinglePage) return;
    
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((self.frame.size.width - 200)/2, ZXMainScrollViewHeight + 20, 200, 30)];
    _pageControl.userInteractionEnabled = NO;
    _pageControl.currentPage = 0;
    _pageControl.numberOfPages = self.data.count;
    [self addSubview:_pageControl];
    _pageControl.pageIndicatorTintColor = kHexColor(@"#D6D6D6");
    _pageControl.currentPageIndicatorTintColor = kHexColor(@"#F05555");
    _pageControl.hidden = !_showPageControl;
}

#pragma mark - 设置初始尺寸
-(void)updateViewFrameSetting{
    //设置偏移量
    self.mainScrollView.contentSize = CGSizeMake(ZXMainScrollViewWidth * 3, ZXMainScrollViewHeight);
    self.mainScrollView.contentOffset = CGPointMake(ZXMainScrollViewWidth, 0.0);
    //图片视图；左边
    self.leftIV.frame = CGRectMake(self.itemMargnPadding/2, self.imageHeightPoor, self.imgWidth, ZXMainScrollViewHeight-self.imageHeightPoor*2);
    //图片视图；中间
    self.centerIV.frame = CGRectMake(ZXMainScrollViewWidth + self.itemMargnPadding/2, 0.0, self.imgWidth, ZXMainScrollViewHeight);
    //图片视图；右边
    self.rightIV.frame = CGRectMake(ZXMainScrollViewWidth * 2.0 + self.itemMargnPadding/2, self.imageHeightPoor, self.imgWidth, ZXMainScrollViewHeight-self.imageHeightPoor*2);
}


- (void)setImageRadius:(CGFloat)imageRadius {
    _imageRadius = imageRadius;
    [self.leftIV addRoundedCornersWithRadius:imageRadius];
    [self.centerIV addRoundedCornersWithRadius:imageRadius];
    [self.rightIV addRoundedCornersWithRadius:imageRadius];
    [self.leftIV addProjectionWithShadowOpacity:0.4];
    [self.centerIV addProjectionWithShadowOpacity:0.4];
    [self.rightIV addProjectionWithShadowOpacity:0.4];
}


- (void)setData:(NSArray *)data{
    if (data.count < _data.count) {
        [_mainScrollView setContentOffset:CGPointMake(ZXMainScrollViewWidth, 0) animated:NO];
    }
    _data = data;
    //    self.currentImageIndex = 0;
    self.imgCount = data.count;
    self.pageControl.numberOfPages = self.imgCount;
    [self setInfoByCurrentImageIndex:self.currentImageIndex];
    
    if (data.count != 1) {
        self.mainScrollView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    } else {
        [self invalidateTimer];
        // ZXMainScrollViewWidth < self.frame.size.width    这样的 说明是 图片有间距 卡片 翻页效果那种布局
        self.mainScrollView.scrollEnabled = ZXMainScrollViewWidth < self.frame.size.width ?YES : NO;
    }
    
    [self createPageControl];
}



- (void)setInfoByCurrentImageIndex:(NSUInteger)currentImageIndex {
    if(self.self.imgCount == 0){
        return;
    }
    
    
    centerLbl.text = self.data[currentImageIndex][@"name"];
    centerDetailsLbl.text = self.data[currentImageIndex][@"synopsis"];
    [centerDetailsLbl sizeToFit];
    centerDetailsLbl.frame = CGRectMake(15, leftLbl.yy + 13, (SCREEN_WIDTH - 130) - 30, centerDetailsLbl.height);
    
    NSInteger leftIndex = (unsigned long)((_currentImageIndex - 1 + self.imgCount) % self.imgCount);
    
    leftLbl.text = self.data[leftIndex][@"name"];
    leftDetailsLbl.text = self.data[leftIndex][@"synopsis"];
    [leftDetailsLbl sizeToFit];
    leftDetailsLbl.frame = CGRectMake(15, leftLbl.yy + 13, (SCREEN_WIDTH - 130) - 30, centerDetailsLbl.height);
    
    NSInteger rightIndex = (unsigned long)((_currentImageIndex + 1) % self.imgCount);
    rightLbl.text = self.data[rightIndex][@"name"];
    rightDetailsLbl.text = self.data[rightIndex][@"synopsis"];
    [rightDetailsLbl sizeToFit];
    rightDetailsLbl.frame = CGRectMake(15, leftLbl.yy + 13, (SCREEN_WIDTH - 130) - 30, centerDetailsLbl.height);
    
    
//    if (self.data[currentImageIndex].nodeRank.length == 1) {
//        centerIVRightLbl.text = [NSString stringWithFormat:@"0%@",self.data[currentImageIndex].nodeRank];
//    }else
//    {
//        centerIVRightLbl.text = self.data[currentImageIndex].nodeRank;
//    }
//    [centerIVLbl setTitle:[NSString stringWithFormat:@"%@%@",self.data[currentImageIndex].orderNo,[LangSwitcher switchLang:@"号超级节点" key:nil]] forState:(UIControlStateNormal)];
//
//    //    centerIVLbl.text.text = [NSString stringWithFormat:@"%@号超级节点",self.data[currentImageIndex].orderNo];
//    centerIVAmountLbl.text = [NSString stringWithFormat:@"%@",[CoinUtil convertToRealCoin:self.data[currentImageIndex].expectIncome coin:self.data[currentImageIndex].symbol]];
//    centerIVVotesLbl.text = [NSString stringWithFormat:@"%@：%@",[LangSwitcher switchLang:@"已有票数" key:nil],[CoinUtil convertToRealCoin:self.data[currentImageIndex].nowAmount coin:self.data[currentImageIndex].symbol]];
//
//    if ([self.data[currentImageIndex].nowAmount floatValue] > 0) {
//        conterStatusLbl.text = @"已参赛";
//        conterStatusLbl.backgroundColor = kHexColor(@"#F9874A");
//    }else
//    {
//        conterStatusLbl.text = @"未参赛";
//        conterStatusLbl.backgroundColor = kHexColor(@"#B3B3B3");
//
//    }
//
//
//    if ([self.data[currentImageIndex].nodeRank isEqualToString:@"1"]) {
//        centerIVRightImg.image = kImage(@"图1");
//        //        [centerIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"金牌") forState:(UIControlStateNormal)];
//        //        }];
//        centerLeftImg.image = kImage(@"大金牌");
//    }else if ([self.data[currentImageIndex].nodeRank isEqualToString:@"2"])
//    {
//        //        [centerIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"银牌") forState:(UIControlStateNormal)];
//        //        }];
//        centerLeftImg.image = kImage(@"大银牌");
//        centerIVRightImg.image = kImage(@"图2");
//    }else if ([self.data[currentImageIndex].nodeRank isEqualToString:@"3"])
//    {
//        //        [centerIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"铜牌") forState:(UIControlStateNormal)];
//        //        }];
//        centerLeftImg.image = kImage(@"大铜牌");
//        centerIVRightImg.image = kImage(@"图3");
//    }else
//    {
//        //        [centerIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"") forState:(UIControlStateNormal)];
//        //        }];
//        centerLeftImg.image = kImage(@"");
//        centerIVRightImg.image = kImage(@"图4");
//    }
//
    
//    //    leftRightLbl.text = self.data[leftIndex].orderNo;
//
//
//
//
//    if ([self.data[leftIndex].nodeRank integerValue] < 10) {
//        leftRightLbl.text = [NSString stringWithFormat:@"0%@",self.data[leftIndex].nodeRank];
//    }else
//    {
//        leftRightLbl.text = self.data[leftIndex].nodeRank;
//    }
//
//    [leftLbl setTitle:[NSString stringWithFormat:@"%@%@",self.data[leftIndex].orderNo,[LangSwitcher switchLang:@"号超级节点" key:nil]] forState:(UIControlStateNormal)];
//
//    //    leftLbl.text = [NSString stringWithFormat:@"%@号超级节点",self.data[leftIndex].orderNo];
//    leftAmountLbl.text = [NSString stringWithFormat:@"%@",[CoinUtil convertToRealCoin:self.data[leftIndex].expectIncome coin:self.data[leftIndex].symbol]];
//    leftVotesLbl.text = [NSString stringWithFormat:@"%@：%@",[LangSwitcher switchLang:@"已有票数" key:nil],[CoinUtil convertToRealCoin:self.data[leftIndex].nowAmount coin:self.data[leftIndex].symbol]];
//
//    if ([self.data[leftIndex].nowAmount floatValue] > 0) {
//        leftStatusLbl.text = @"已参赛";
//        leftStatusLbl.backgroundColor = kHexColor(@"#F9874A");
//    }else
//    {
//        leftStatusLbl.text = @"未参赛";
//        leftStatusLbl.backgroundColor = kHexColor(@"#B3B3B3");
//
//    }
//
//    if ([self.data[leftIndex].nodeRank isEqualToString:@"1"]) {
//        leftRightImg.image = kImage(@"图1");
//        //        [leftLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"金牌") forState:(UIControlStateNormal)];
//        //        }];
//
//        leftLeftImg.image = kImage(@"大金牌");
//    }else if ([self.data[leftIndex].nodeRank isEqualToString:@"2"])
//    {
//        //        [leftLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"银牌") forState:(UIControlStateNormal)];
//        //        }];
//        leftLeftImg.image = kImage(@"大银牌");
//        leftRightImg.image = kImage(@"图2");
//    }else if ([self.data[leftIndex].nodeRank isEqualToString:@"3"])
//    {
//        //        [leftLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"铜牌") forState:(UIControlStateNormal)];
//        //        }];
//
//        leftLeftImg.image = kImage(@"大铜牌");
//        leftRightImg.image = kImage(@"图3");
//    }else
//    {
//        //        [leftLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"") forState:(UIControlStateNormal)];
//        //        }];
//        leftLeftImg.image = kImage(@"");
//        leftRightImg.image = kImage(@"图4");
//    }
//    //    if([self isHttpString:self.data[leftIndex]]){
//    //        [self.leftIV sd_setImageWithURL:[NSURL URLWithString:self.data[leftIndex]] placeholderImage:self.placeHolderImage];
//    //    }else {
//    //        self.leftIV.image = kImage(self.data[leftIndex]);
//    //    }
//
    
//    //    rightIVRightLbl.text = self.data[rightIndex].orderNo;
//
//    if ([self.data[rightIndex].nodeRank integerValue] < 10) {
//        rightIVRightLbl.text = [NSString stringWithFormat:@"0%@",self.data[rightIndex].nodeRank];
//    }else
//    {
//        rightIVRightLbl.text = self.data[rightIndex].nodeRank;
//    }
//
//    [rightIVLbl setTitle:[NSString stringWithFormat:@"%@%@",self.data[rightIndex].orderNo,[LangSwitcher switchLang:@"号超级节点" key:nil]] forState:(UIControlStateNormal)];
//    //    rightIVLbl.text = [NSString stringWithFormat:@"%@号超级节点",self.data[rightIndex].orderNo];
//    rightIVAmountLbl.text = [NSString stringWithFormat:@"%@",[CoinUtil convertToRealCoin:self.data[rightIndex].expectIncome coin:self.data[rightIndex].symbol]];
//    rightIVVotesLbl.text = [NSString stringWithFormat:@"%@：%@",[LangSwitcher switchLang:@"已有票数" key:nil],[CoinUtil convertToRealCoin:self.data[rightIndex].nowAmount coin:self.data[rightIndex].symbol]];
//
//    if ([self.data[rightIndex].nowAmount floatValue] > 0) {
//        rightStatusLbl.text = @"已参赛";
//        rightStatusLbl.backgroundColor = kHexColor(@"#F9874A");
//    }else
//    {
//        rightStatusLbl.text = @"未参赛";
//        rightStatusLbl.backgroundColor = kHexColor(@"#B3B3B3");
//
//    }
//
//
//
//    if ([self.data[rightIndex].nodeRank isEqualToString:@"1"]) {
//        rightIVRightImg.image = kImage(@"图1");
//        //        [rightIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"金牌") forState:(UIControlStateNormal)];
//        //        }];
//        rightLeftImg.image = kImage(@"大金牌");
//    }else if ([self.data[rightIndex].nodeRank isEqualToString:@"2"])
//    {
//        //        [rightIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"银牌") forState:(UIControlStateNormal)];
//        //        }];
//        rightLeftImg.image = kImage(@"大银牌");
//        rightIVRightImg.image = kImage(@"图2");
//    }else if ([self.data[rightIndex].nodeRank isEqualToString:@"3"])
//    {
//        //        [rightIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"铜牌") forState:(UIControlStateNormal)];
//        //        }];
//        rightLeftImg.image = kImage(@"大铜牌");
//        rightIVRightImg.image = kImage(@"图3");
//    }else
//    {
//        //        [rightIVLbl SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(@"") forState:(UIControlStateNormal)];
//        //        }];
//        rightLeftImg.image = kImage(@"");
//        rightIVRightImg.image = kImage(@"图4");
//    }
//    //    if([self isHttpString:self.data[rightIndex]]){
//    //        [self.rightIV sd_setImageWithURL:[NSURL URLWithString:self.data[rightIndex]] placeholderImage:self.placeHolderImage];
//    //    }else {
//    //        self.rightIV.image = kImage(self.data[rightIndex]);
//    //    }
//
//    _pageControl.currentPage = currentImageIndex;
}

- (void)reloadImage {
    //~~ 避免0
    if(self.imgCount == 0) {
        return;
    }
    CGPoint contentOffset = [self.mainScrollView contentOffset];
    if (contentOffset.x > ZXMainScrollViewWidth) { //向左滑动
        _currentImageIndex = (_currentImageIndex + 1) % self.imgCount;
    } else if (contentOffset.x < ZXMainScrollViewWidth) { //向右滑动
        _currentImageIndex = (_currentImageIndex - 1 + self.imgCount) % self.imgCount;
    }
    [self setInfoByCurrentImageIndex:_currentImageIndex];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.autoScroll) {
        [self invalidateTimer];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self reloadImage];
    [self.mainScrollView setContentOffset:CGPointMake(ZXMainScrollViewWidth, 0) animated:NO] ;
    self.pageControl.currentPage = self.currentImageIndex;
    if (self.clickImageBlock) {
        self.clickImageBlock(self.currentImageIndex);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self createTimer];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}


#pragma mark -- action
-(void)leftTapGes{
    //    WGLog(@"1");
}

-(void)rightTapGes{
    //    WGLog(@"12");
}

-(void)centerTapGes{
    //    WGLog(@"123");
    //    [_delegate HW3DBannerViewClick];
}

-(void)createTimer {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    if(_timer){
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)automaticScroll {
    if (0 == _imgCount) return;
    if(self.mainScrollView.scrollEnabled == NO) return;
    [self.mainScrollView setContentOffset:CGPointMake(ZXMainScrollViewWidth*2, 0.0) animated:YES];
}

#pragma mark -- properties
-(void)setItemMargnPadding:(CGFloat)itemMargnPadding {
    _itemMargnPadding = itemMargnPadding;
    self.mainScrollView.frame = CGRectMake((ZXMainScrollViewWidth - (self.imgWidth + itemMargnPadding))/2, 0, self.imgWidth + itemMargnPadding, ZXMainScrollViewHeight);
    [self updateViewFrameSetting];
}

-(void)setCurPageControlColor:(UIColor *)curPageControlColor {
    _curPageControlColor = curPageControlColor;
    _pageControl.currentPageIndicatorTintColor = curPageControlColor;
}

-(void)setOtherPageControlColor:(UIColor *)otherPageControlColor {
    _otherPageControlColor = otherPageControlColor;
    _pageControl.pageIndicatorTintColor = otherPageControlColor;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval {
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [self setAutoScroll:self.autoScroll];
}

-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self createTimer];
    }
}

-(void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    _placeHolderImage = placeHolderImage;
    //    self.centerIV.image = placeHolderImage;
    //    self.leftIV.image = placeHolderImage;
    //    self.rightIV.image = placeHolderImage;
}

-(void)setShowPageControl:(BOOL)showPageControl{
    _showPageControl = showPageControl;
    self.pageControl.hidden = !_showPageControl;
}

- (void)setInitAlpha:(CGFloat)initAlpha {
    _initAlpha = initAlpha;
    self.leftIV.alpha = self.initAlpha;
    self.centerIV.alpha = 1;
    self.rightIV.alpha = self.initAlpha;
}

-(UIScrollView *)mainScrollView {
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _mainScrollView.delegate = self;
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.clipsToBounds = NO;
        _mainScrollView.showsVerticalScrollIndicator = NO;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _mainScrollView;
}

-(BOOL)isHttpString:(NSString *)urlStr {
    
    if([urlStr hasPrefix:@"http:"] || [urlStr hasPrefix:@"https:"]){
        return YES;
    }else {
        return NO;
    }
}
#pragma mark - life circles
//解决当父View释放时，当前视图因为被Timer强引用而不能释放的问题
- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        [self invalidateTimer];
    }
}
//解决当timer释放后 回调scrollViewDidScroll时访问野指针导致崩溃
- (void)dealloc {
    _mainScrollView.delegate = nil;
    [self invalidateTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.itemMargnPadding > 0) {
        CGFloat currentX = scrollView.contentOffset.x - ZXMainScrollViewWidth;
        CGFloat bl = currentX/ZXMainScrollViewWidth*(1-self.initAlpha);
        CGFloat variableH = currentX/ZXMainScrollViewWidth*self.imageHeightPoor*2;
        if (currentX > 0) { //左滑
            self.centerIV.alpha = 1 - bl;
            self.rightIV.alpha = self.initAlpha + bl;
            self.centerIV.height = ZXMainScrollViewHeight - variableH;
            self.centerIV.y = currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
            self.rightIV.height = ZXMainScrollViewHeight-2*self.imageHeightPoor+variableH;
            self.rightIV.y = self.imageHeightPoor-currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
        } else if (currentX < 0){  // 右滑
            self.centerIV.alpha = 1 + bl;
            self.leftIV.alpha = self.initAlpha - bl;
            self.centerIV.height = ZXMainScrollViewHeight + variableH;
            self.centerIV.y = -currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
            self.leftIV.height = ZXMainScrollViewHeight-2*self.imageHeightPoor-variableH;
            self.leftIV.y = self.imageHeightPoor+currentX/ZXMainScrollViewWidth*self.imageHeightPoor;
        } else {
            self.leftIV.alpha = self.initAlpha;
            self.centerIV.alpha = 1;
            self.rightIV.alpha = self.initAlpha;
            self.leftIV.height = ZXMainScrollViewHeight-2*self.imageHeightPoor;
            self.centerIV.height = ZXMainScrollViewHeight;
            self.rightIV.height = ZXMainScrollViewHeight-2*self.imageHeightPoor;
            self.leftIV.y = self.imageHeightPoor;
            self.centerIV.y = 0;
            self.rightIV.y = self.imageHeightPoor;
        }
    }
}


@end
