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
@interface HomeHeadVC ()<HW3DBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSArray *advertisingArray;
}
@property (nonatomic,strong)NSArray *urlArray;
@property (nonatomic,assign) int classifycount;
@property (nonatomic,assign) int carBrandcount;
@property (nonatomic,strong) UICollectionViewFlowLayout * layout;


@end

@implementation HomeHeadVC


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.classifycount = 3;
//        self.carBrandcount = 4;
//        [self loadData];
        self.backgroundColor = kWhiteColor;
        
        [self addSubview:self.scrollView];
//        [self createbtn];
        [self addSubview:self.collection];

    }
    return self;
}
-(void)setCarBrandModels:(NSMutableArray<CarModel *> *)CarBrandModels{
    
    if (_CarBrandModels.count > 0) {
        for (int i = 0; i < _CarBrandModels.count; i ++) {
            UIView *lineView = [self viewWithTag:i + 10000];
            [lineView removeFromSuperview];
        }
    }
    
    if (CarBrandModels.count > 0) {
        for (int i = 0; i < CarBrandModels.count - 1 ; i ++) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 + i % 3 * SCREEN_WIDTH/4, 50 + i % 3 * 30, 1, 20)];
            lineView.tag = 10000+i;
            lineView.backgroundColor =kLineColor;
            [_collection addSubview:lineView];
        }
    }
    _CarBrandModels = CarBrandModels;
    
    if (self.CarClassifyModels && self.CarBrandModels) {
        [self bannerLoadData];
        [self.collection reloadData];
    }
}
-(void)setCarClassifyModels:(NSMutableArray<CarModel *> *)CarClassifyModels{
    _CarClassifyModels = CarClassifyModels;
    if (self.CarClassifyModels && self.CarBrandModels) {
        [self.collection reloadData];
    }
    
}

#pragma mark -- 滑动试图懒加载
-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        MJWeakSelf;
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.00/750.00 * SCREEN_WIDTH) imageSpacing:0 imageWidth:SCREEN_WIDTH];
        _scrollView.userInteractionEnabled=YES;
        _scrollView.autoScrollTimeInterval = 3;
        _scrollView.placeHolderImage = kImage(@"default_pic"); // 设置占位图片
        
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
            //            NSLog(@"%ld",currentIndex);
            [weakSelf clickImage:currentIndex];
        };
        _scrollView.delegate = self;
    }
    return _scrollView;
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        layout.minimumLineSpacing = 10;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 24, 10, 24);
        
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.layout = layout;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.scrollView.yy + 10,SCREEN_WIDTH , self.bounds.size.height - self.scrollView.yy)collectionViewLayout:self.layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.scrollEnabled = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[SelectcarFootCell class] forCellWithReuseIdentifier:@"SelectcarFoot"];
        [_collection registerClass:[SelectCarCell class] forCellWithReuseIdentifier:@"cell"];
        [_collection registerClass:[SelectBrandCell class] forCellWithReuseIdentifier:@"SelectBrand"];
        
        for (int i = 0; i < 3 ; i ++) {
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 + i % 3 * SCREEN_WIDTH/4, 10, 1, 20)];
            lineView.backgroundColor =kLineColor;
            [_collection addSubview:lineView];
        }
        
    }
    return _collection;
}


#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return 4;
    }
    if (section == 1) {
        return self.CarBrandModels.count;
    }
    return self.CarClassifyModels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        SelectcarFootCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectcarFoot" forIndexPath:indexPath];
        cell.titlelab.text = self.CarClassifyModels[indexPath.row].name;
        
        
        
        NSArray * p= [self.CarClassifyModels[indexPath.row].advPic componentsSeparatedByString:@"||"];
        NSMutableArray *topImage = [NSMutableArray array];
        for (int i = 0; i < p.count; i ++) {
            [topImage addObject:[p[i] convertImageUrl]];
        }
        if (topImage.count > 0) {
            [cell.logo sd_setImageWithURL:[NSURL URLWithString:[topImage[0] convertImageUrl]] placeholderImage:kImage(@"default_pic")];
        }
        

        return cell;
    }
    if (indexPath.section == 0) {
        NSArray * titlearray = @[@"30-50万",@"50-70万",@"70万以上",@"更多"];
        SelectCarCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        cell.titlelab.text = titlearray[indexPath.row];
        return cell;
    }
    SelectBrandCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectBrand" forIndexPath:indexPath];

    if (self.CarBrandModels) {
        CarModel * model =[CarModel mj_objectWithKeyValues:self.CarBrandModels[indexPath.row]];
        cell.titlelab.text = model.name;
        
        
        
        [cell.titlelab sizeToFit];
        
        cell.logo.frame = CGRectMake(cell.width/2 - (cell.titlelab.width)/2 - 12, 2.5, 15, 15);
        
        cell.titlelab.frame = CGRectMake(cell.logo.xx + 5, 0, cell.frame.size.width - cell.logo.xx - 5, 20);
        
        
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:[model.logo convertImageUrl]] placeholderImage:kImage(@"default_pic")];
     
        
        cell.titlelab.frame = CGRectMake(cell.logo.xx + 5, 0, cell.titlelab.width, 20);
    }
    
    return cell;

}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake((SCREEN_WIDTH - 120) /4, 20);
    }else if (indexPath.section == 1){
        return CGSizeMake((SCREEN_WIDTH - 120) / 4  , 20);
    }
    return CGSizeMake((SCREEN_WIDTH - 96) /3, 80);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.delegate) {
            [self.delegate ClickCollectionClassify:indexPath];
        }
    }
    else if (indexPath.section == 1){
        if (self.delegate) {
            [self.delegate ClickCollectionClassify:indexPath withmodels:self.CarBrandModels[indexPath.row]];
        }
    }else{
        if (self.delegate) {
            [self.delegate ClickCollectionClassify:indexPath withmodels:self.CarClassifyModels[indexPath.row]];
        }
    }
}

#pragma mark - 点击事件
-(void)clickbtn:(UIButton *)sender{
    if (self.delegate) {
        [self.delegate ClickBtn:sender];
    }
    
}
- (void)clickImage:(NSInteger)inter
{
    
    
}
-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex{
//    NSLog(@"%ld",currentImageIndex);
    if (advertisingArray.count > 0) {
        [_delegate bannerUrl:advertisingArray[currentImageIndex]];
    }
    

}

#pragma mark - 获取数据

-(void)bannerLoadData
{
    //    MinicarsLifeWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"805806";
    http.parameters[@"location"] = @"index_banner";
    http.showView = self;
    
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        advertisingArray = responseObject[@"data"];
        NSMutableArray *muArray = [NSMutableArray array];
        NSMutableArray *urlArray = [NSMutableArray array];
        
        for (int i = 0; i < advertisingArray.count; i ++) {
            [muArray addObject:[NSString stringWithFormat:@"%@",[advertisingArray[i][@"pic"] convertImageUrl]]];
            [urlArray addObject:[NSString stringWithFormat:@"%@",advertisingArray[i][@"url"]]];
        }
        self.scrollView.data = muArray;
        self.urlArray = urlArray;
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


@end
