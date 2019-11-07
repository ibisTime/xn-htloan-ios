//
//  HomeHeadVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "HomeHeadVC.h"
#import "HotCarCollectionCell.h"
#import "NewsModel.h"
#import "ChooseCarVC.h"
#import "SelectCarCell.h"
#import "SelectcarFootCell.h"
#import "SelectBrandCell.h"
#import "SelVideoPlayer.h"
#import "SelPlayerConfiguration.h"
@interface HomeHeadVC ()<HW3DBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *advertisingArray;
    UILabel * label;
    UIView *backView;
}
@property (nonatomic,strong)NSArray *urlArray;
@property (nonatomic,assign) int classifycount;
@property (nonatomic,assign) int carBrandcount;
@property (nonatomic,strong) UICollectionViewFlowLayout * layout;



@end

@implementation HomeHeadVC

-(void)btnClick:(UIButton *)sender
{
    [_delegate ClickBtn:sender];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.classifycount = 3;
//        self.carBrandcount = 4;
//        [self loadData];
//        self.backgroundColor = kWhiteColor;
        [self addSubview:self.scrollView];
//        [self createbtn];
//        [self addSubview:self.collection];

        _videoAry = [NSMutableArray array];
        
        backView = [[UIView alloc]initWithFrame:CGRectMake(0, _scrollView.yy - 16, SCREEN_WIDTH, 400)];
        backView.backgroundColor = kWhiteColor;
        [self addSubview:backView];
        
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:backView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 16)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = backView.bounds;
        maskLayer.path = maskPath.CGPath;
        backView.layer.mask = maskLayer;
        
        UIButton *merchantsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        merchantsBtn.frame = CGRectMake(9, 22, SCREEN_WIDTH/2 - 9 - 1.5, 112);
        [merchantsBtn setImage:kImage(@"优质商家") forState:(UIControlStateNormal)];
        [merchantsBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        merchantsBtn.tag = 0;
        [backView addSubview:merchantsBtn];
        
        
//        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(21, 19, merchantsBtn.width - 21, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(14) textColor:kWhiteColor];
//        nameLbl.text = @"优质商家";
//        [merchantsBtn addSubview:nameLbl];
//
//        UILabel *infomationLbl = [UILabel labelWithFrame:CGRectMake(21, nameLbl.yy + 6, merchantsBtn.width - 21, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
//        infomationLbl.text = @"万千优质汽车经销商";
//        [merchantsBtn addSubview:infomationLbl];
//
//        UIButton *moreBtn = [UIButton buttonWithTitle:@"查看更多" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:11];
//        moreBtn.frame = CGRectMake(21, infomationLbl.yy + 13, merchantsBtn.width - 21, 12);
//        [moreBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:0 imagePositionBlock:^(UIButton *button) {
//            [button setImage:kImage(@"查看更多") forState:(UIControlStateNormal)];
//        }];
//        moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [moreBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        moreBtn.tag = 0;
//        [merchantsBtn addSubview:moreBtn];
        
        UIButton *carsBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        carsBtn.frame = CGRectMake(merchantsBtn.xx + 3, 22, SCREEN_WIDTH/2 - 9 - 1.5, 112);
        [carsBtn setImage:kImage(@"名车展") forState:(UIControlStateNormal)];
        [carsBtn addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        carsBtn.tag = 1;
        [backView addSubview:carsBtn];
        
//        UILabel *nameLbl1 = [UILabel labelWithFrame:CGRectMake(21, 19, carsBtn.width - 21, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(14) textColor:kWhiteColor];
//        nameLbl1.text = @"名车展";
//        [carsBtn addSubview:nameLbl1];
//
//        UILabel *infomationLbl1 = [UILabel labelWithFrame:CGRectMake(21, nameLbl1.yy + 6, carsBtn.width - 21, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
//        infomationLbl1.text = @"所有车型一应俱全";
//        [carsBtn addSubview:infomationLbl1];
//
//        UIButton *moreBtn1 = [UIButton buttonWithTitle:@"查看更多" titleColor:kWhiteColor backgroundColor:kClearColor titleFont:11];
//        moreBtn1.frame = CGRectMake(21, infomationLbl1.yy + 13, carsBtn.width - 21, 12);
//        moreBtn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [moreBtn1 SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:3 imagePositionBlock:^(UIButton *button) {
//            [button setImage:kImage(@"查看更多") forState:(UIControlStateNormal)];
//        }];
//        [moreBtn1 addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
//        moreBtn1.tag = 1;
//        [carsBtn addSubview:moreBtn1];
        
        
        label = [UILabel labelWithFrame:CGRectMake(15, carsBtn.yy + 11, 100, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        label.text = @"玩车视频";
        [backView addSubview:label];
        
        UIButton * button = [UIButton buttonWithTitle:@"全部" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
//        [button addTarget:self action:@selector(morenews) forControlEvents:(UIControlEventTouchUpInside)];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        button.tag = 2;
        button.frame = CGRectMake(SCREEN_WIDTH - 15 - 50, carsBtn.yy + 11, 50, 22.5);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [backView addSubview:button];
        
        [self loadData];

    }
    return self;
}

-(void)loadData
{
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630587";
    http.showView = self;
    http.parameters[@"bizCode"] = @"RT201911011052313086637";
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
    configuration.sourceUrl = [NSURL URLWithString:[_videoDic[@"url"] convertImageUrl]];
    configuration.videoGravity = SelVideoGravityResize;
    
    //    CGFloat width = self.view.frame.size.width;
    _player = [[SelVideoPlayer alloc]initWithFrame:CGRectMake(15, label.yy + 10, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200) configuration:configuration];
    //    _player.backgroundColor = kWhiteColor;
    kViewRadius(_player, 4);
    [backView addSubview:_player];
    
}

-(void)videoView
{
    UIImageView *thumbnailImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, label.yy + 10, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30)/345*200)];
    kViewRadius(thumbnailImg, 4);
    //    thumbnailImg.backgroundColor = [UIColor redColor];
    [thumbnailImg sd_setImageWithURL:[NSURL URLWithString:[_videoDic[@"thumbnail"] convertImageUrl]]];
    [backView addSubview:thumbnailImg];
    
    UIButton *playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    playBtn.frame = CGRectMake(SCREEN_WIDTH/2 - 32.5, label.yy + 10 + (SCREEN_WIDTH - 30)/345*200/2 - 32.5, 65, 65);
    [playBtn setImage:kImage(@"btn_play") forState:(UIControlStateNormal)];
    [playBtn addTarget:self action:@selector(playBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [backView addSubview:playBtn];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(15, label.yy + 10 + (SCREEN_WIDTH - 30)/345*200 - 80, SCREEN_WIDTH - 30, 80);
    gl.startPoint = CGPointMake(0.5, 0);
    gl.endPoint = CGPointMake(0.5, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.0].CGColor, (__bridge id)[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5].CGColor];
    gl.locations = @[@(0), @(1.0f)];
    [backView.layer addSublayer:gl];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(30, label.yy + 10 + thumbnailImg.height - 27.5 - 20 + 7.5, SCREEN_WIDTH - 60, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
    nameLbl.text = _videoDic[@"name"];
    [backView addSubview:nameLbl];
    
    UILabel *timeLbl = [UILabel labelWithFrame:CGRectMake(30, nameLbl.yy + 2.5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    timeLbl.text = [_videoDic[@"pushDatetime"] convertDate];
    [backView addSubview:timeLbl];
    
    UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(timeLbl.xx, nameLbl.yy + 2.5, (SCREEN_WIDTH - 60)/2, 16.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
    numberLbl.text = [NSString stringWithFormat:@"%@次播放",_videoDic[@"visitNumber"]];
    [backView addSubview:numberLbl];
}

//-(void)setCarBrandModels:(NSMutableArray<CarModel *> *)CarBrandModels{
//
//    _CarBrandModels = CarBrandModels;
//
//    if (self.CarClassifyModels && self.CarBrandModels) {
//        [self bannerLoadData];
//        [self.collection reloadData];
//    }
//}
//-(void)setCarClassifyModels:(NSMutableArray<CarModel *> *)CarClassifyModels{
//    _CarClassifyModels = CarClassifyModels;
//    if (self.CarClassifyModels && self.CarBrandModels) {
//        [self.collection reloadData];
//    }
//
//}

#pragma mark -- 滑动试图懒加载
-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        MJWeakSelf;
//        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 300.00/750.00 * (SCREEN_WIDTH - 30)) imageSpacing:0 imageWidth:SCREEN_WIDTH - 30];
//        _scrollView.userInteractionEnabled=YES;
//        _scrollView.autoScrollTimeInterval = 3;
//        _scrollView.placeHolderImage = kImage(@"default_pic"); // 设置占位图片
        
        
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*(189 - 64)) imageSpacing:0 imageWidth:SCREEN_WIDTH];
        _scrollView.initAlpha = 0; // 设置两边卡片的透明度
        _scrollView.imageRadius = 0; // 设置卡片圆角
        //        _scrollView.imageHeightPoor = 20;// 设置占位图片
        _scrollView.delegate = self;
        _scrollView.autoScrollTimeInterval = 0;
        _scrollView.backgroundColor = MainColor;
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            //            NSLog(@"%ld",currentIndex);
            [weakSelf clickImage:currentIndex];
        };
//        _scrollView.delegate = self;
        
        
        
    }
    return _scrollView;
}

//-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex
//{

    
//}

//-

//-(UICollectionView *)collection{
//    if (!_collection) {
//        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
//        layout.minimumLineSpacing = 0;
//        layout.sectionInset = UIEdgeInsetsMake(0, 24, 0, 24);
//        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        self.layout = layout;
//        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.scrollView.yy + 15,SCREEN_WIDTH , self.bounds.size.height - self.scrollView.yy)collectionViewLayout:self.layout];
//        _collection.delegate = self;
//        _collection.dataSource = self;
//        _collection.showsVerticalScrollIndicator = NO;
//        _collection.showsHorizontalScrollIndicator = NO;
//        _collection.scrollEnabled = NO;
//        _collection.backgroundColor = [UIColor whiteColor];
//        [_collection registerClass:[SelectcarFootCell class] forCellWithReuseIdentifier:@"SelectcarFoot"];
//        [_collection registerClass:[SelectCarCell class] forCellWithReuseIdentifier:@"cell"];
//        [_collection registerClass:[SelectBrandCell class] forCellWithReuseIdentifier:@"SelectBrand"];
//
////        for (int i = 0; i < 3 ; i ++) {
////            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 + i % 3 * SCREEN_WIDTH/4, 10, 1, 20)];
////            lineView.backgroundColor =kLineColor;
////            [_collection addSubview:lineView];
////        }
//
//    }
//    return _collection;
//}
//
//
//#pragma mark - UICollectionViewDelegate
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    return 3;
//}
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (section == 0) {
//        return 4;
//    }
//    if (section == 1) {
//        return self.CarBrandModels.count;
//    }
//    return self.CarClassifyModels.count;
//}
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 2) {
//        SelectcarFootCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectcarFoot" forIndexPath:indexPath];
//        cell.titlelab.text = self.CarClassifyModels[indexPath.row].name;
//
//
//
//        NSArray * p= [self.CarClassifyModels[indexPath.row].advPic componentsSeparatedByString:@"||"];
//        NSMutableArray *topImage = [NSMutableArray array];
//        for (int i = 0; i < p.count; i ++) {
//            [topImage addObject:[p[i] convertImageUrl]];
//        }
//        if (topImage.count > 0) {
//            [cell.logo sd_setImageWithURL:[NSURL URLWithString:[topImage[0] convertImageUrl]] placeholderImage:kImage(@"default_pic")];
//        }
//
//
//        return cell;
//    }
//    if (indexPath.section == 0) {
//        NSArray * titlearray = @[@"30-50万",@"50-70万",@"70万以上",@"更多"];
//        SelectCarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//        cell.titlelab.text = titlearray[indexPath.row];
//        return cell;
//    }
//    SelectBrandCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectBrand" forIndexPath:indexPath];
//
//    if (self.CarBrandModels) {
//        CarModel * model =[CarModel mj_objectWithKeyValues:self.CarBrandModels[indexPath.row]];
//        cell.titlelab.text = model.name;
//        [cell.titlelab sizeToFit];
//        cell.logo.frame = CGRectMake(cell.width/2 - (cell.titlelab.width)/2 - 30/2 - 2, 0, 30, 30);
//        cell.titlelab.frame = CGRectMake(cell.logo.xx + 4 , 0, cell.frame.size.width - cell.logo.xx, 30);
//        [cell.logo sd_setImageWithURL:[NSURL URLWithString:[model.logo convertImageUrl]] placeholderImage:kImage(@"default_pic")];
//        cell.titlelab.frame = CGRectMake(cell.logo.xx + 4, 0, cell.titlelab.width, 30);
//    }
//    return cell;
//}
//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        return CGSizeMake((SCREEN_WIDTH - 120) /4, 30);
//    }else if (indexPath.section == 1){
//        return CGSizeMake((SCREEN_WIDTH - 120) / 4  , 40);
//    }
//    return CGSizeMake((SCREEN_WIDTH - 96) /3, 95);
//}
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        if (self.delegate) {
//            [self.delegate ClickCollectionClassify:indexPath];
//        }
//    }
//    else if (indexPath.section == 1){
//        if (self.delegate) {
//            [self.delegate ClickCollectionClassify:indexPath withmodels:self.CarBrandModels[indexPath.row]];
//        }
//    }else{
//        if (self.delegate) {
//            [self.delegate ClickCollectionClassify:indexPath withmodels:self.CarClassifyModels[indexPath.row]];
//        }
//    }
//}
//
//#pragma mark - 点击事件
//-(void)clickbtn:(UIButton *)sender{
//    if (self.delegate) {
//        [self.delegate ClickBtn:sender];
//    }
//
//}
- (void)clickImage:(NSInteger)inter
{
//    [_delegate clickImage:inter];
//    if (advertisingArray.count > 0) {
//        [_delegate clickImage:advertisingArray[currentImageIndex]];
//    }
}


-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex{
//    NSLog(@"%ld",currentImageIndex);
//    if (advertisingArray.count > 0) {
        [_delegate clickImage:currentImageIndex];
//    }
}
//
//#pragma mark - 获取数据
//
//-(void)bannerLoadData
//{
//    //    MinicarsLifeWeakSelf;
//}


@end
