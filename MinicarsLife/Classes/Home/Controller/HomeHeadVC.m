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
        [self bannerLoadData];
        [self addSubview:self.scrollView];
//        [self createbtn];
        [self addSubview:self.collection];
        
//        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.collection.yy + 20 , SCREEN_WIDTH, 20)];
//        v1.backgroundColor = kLineColor;
//        [self addSubview:v1];
    }
    return self;
}

#pragma mark -- 滑动试图懒加载
-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        MJWeakSelf;
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300.00/750.00 * SCREEN_WIDTH) imageSpacing:0 imageWidth:SCREEN_WIDTH];
        _scrollView.userInteractionEnabled=YES;
        _scrollView.autoScrollTimeInterval = 3;
        _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
        
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
//        CGFloat width = 130 / 375.00 * SCREEN_WIDTH;
        // 设置每个item的大小
//        layout.itemSize = CGSizeMake(width, 338.00 / 226.00 * width);
        // 设置列间距
//        layout.minimumInteritemSpacing = 15;
        // 设置行间距
        layout.minimumLineSpacing = 5;
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(10, 24, 10, 24);
        // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
//        layout.estimatedItemSize = CGSizeMake(width , 338.00 / 226.00 * width);
        // 设置布局方向(滚动方向)
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
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:[self.CarClassifyModels[indexPath.row].advPic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
        cell.logo.contentMode =UIViewContentModeScaleAspectFill;
        //超出容器范围的切除掉
        cell.logo.clipsToBounds = YES;
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
        cell.titlelab.frame = CGRectMake(((SCREEN_WIDTH - 75) / 4 + cell.titlelab.width)/2.5, 0, cell.titlelab.width, 20);
        [cell.logo sd_setImageWithURL:[NSURL URLWithString:[model.logo convertImageUrl]] placeholderImage:kImage(@"default_pic")];
        cell.logo.contentMode =UIViewContentModeScaleAspectFill;
        //超出容器范围的切除掉
        cell.logo.clipsToBounds = YES;
        cell.logo.frame = CGRectMake(cell.titlelab.x - 20, 0.5, 19, 19);
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
        NSArray *array = responseObject[@"data"];
        NSMutableArray *muArray = [NSMutableArray array];
        NSMutableArray *urlArray = [NSMutableArray array];
        
        for (int i = 0; i < array.count; i ++) {
            [muArray addObject:[NSString stringWithFormat:@"%@",[array[i][@"pic"] convertImageUrl]]];
            [urlArray addObject:[NSString stringWithFormat:@"%@",array[i][@"url"]]];
            
        }
        self.scrollView.data = muArray;
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}
-(void)setCarBrandModels:(NSMutableArray<CarModel *> *)CarBrandModels{
    _CarBrandModels = CarBrandModels;
    if (self.CarClassifyModels && self.CarBrandModels) {
        [self.collection reloadData];
    }
}
-(void)setCarClassifyModels:(NSMutableArray<CarModel *> *)CarClassifyModels{
    _CarClassifyModels = CarClassifyModels;
    if (self.CarClassifyModels && self.CarBrandModels) {
        [self.collection reloadData];
    }
    
}
//-(void)loadData{
//    //列表查询品牌
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.showView = self;
//    http.code = @"630406";
//    http.parameters[@"isReferee"] = @"1";
//    [http postWithSuccess:^(id responseObject) {
//        
//        self.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        if (self.carBrandcount > self.CarBrandModels.count) {
//            self.carBrandcount = (int)self.CarBrandModels.count;
//        }
//        [self.collection reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
//    
//    //列表查询车系
//    TLNetworking * http1 = [[TLNetworking alloc]init];
//    http1.showView = self;
//    http1.code = @"630416";
//    http1.parameters[@"isReferee"] = @"1";
//    [http1 postWithSuccess:^(id responseObject) {
//        self.CarClassifyModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        if (self.classifycount > self.CarClassifyModels.count) {
//            self.classifycount = (int)self.CarClassifyModels.count;
//        }
//        [self.collection reloadData];
//    } failure:^(NSError *error) {
//        
//    }];
    
//}

//
//#pragma mark - 十一个按钮
//-(void)createbtn{
//    NSArray * titlearray = @[@"30-50万",@"50-70万",@"70万以上",@"更多",@"奔驰",@"保时捷",@"丰田",@"奥迪"];
//    NSArray * logoarray = @[@"1",@"2",@"3",@"1"];
//    
//    for (int j = 0; j < 4; j ++) {
//        UIButton * button = [UIButton buttonWithTitle:titlearray[j] titleColor:kBlackColor backgroundColor:kClearColor titleFont:13 cornerRadius:0];
//        button.tag = j;
//        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
//        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/4 * j, self.scrollView.yy + 17, (SCREEN_WIDTH-30)/4, 16.5);
//        
//        if (j < 3) {
//            UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15 + (SCREEN_WIDTH-30)/4 * (j+1), self.scrollView.yy + 15, 1, 20)];
//            v1.backgroundColor = kLineColor;
//            [self addSubview:v1];
//        }
//        [self addSubview:button];
//    }
//    for (int j = 0; j < 4; j ++) {
//        UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:13 cornerRadius:0];
//        button.tag = j + 4;
//        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
//        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/4 * j, self.scrollView.yy + 3.5 + 50, (SCREEN_WIDTH-30)/4, 20);
//        [button setTitle:titlearray[j + 4] forState:(UIControlStateNormal)];
//        
//        //        [button SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:5 imagePositionBlock:^(UIButton *button) {
//        //            [button setImage:kImage(logoarray[j]) forState:(UIControlStateNormal)];
//        //        }];
//        
//        [self addSubview:button];
//        
//        if (j < 3) {
//            UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15 + (SCREEN_WIDTH-30)/4 * (j+1), self.scrollView.yy + 3.5 + 50, 1, 20)];
//            v1.backgroundColor = kLineColor;
//            [self addSubview:v1];
//        }
//    }
//    NSLog(@"%@",self.CarStyleModels);
//    NSArray * titlelab = @[@"雷克萨斯LX5",@"奔驰S级",@"霸道3000"];
//    NSArray * imgarray = @[@"1",@"2",@"3"];
//    for (int j = 0; j < 3; j++) {
//        UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:14 cornerRadius:0];
//        button.tag = j + 8;
//        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
//        [button setTitle:titlelab[j] forState:(UIControlStateNormal)];
//        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/3 * j, self.scrollView.yy + 90, (SCREEN_WIDTH-30)/3, 76.5);
//        [button SG_imagePositionStyle:SGImagePositionStyleTop spacing:0 imagePositionBlock:^(UIButton *button) {
//            [button setImage:kImage(imgarray[j]) forState:(UIControlStateNormal)];
//        }];
//        [self addSubview:button];
//    }
//    UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.scrollView.yy + 185, SCREEN_WIDTH, 10)];
//    v1.backgroundColor = kLineColor;
//    [self addSubview:v1];
//    
//    
//    UILabel * label = [UILabel labelWithFrame:CGRectMake(15, v1.yy + 20, 70, 22.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
//    label.text = @"精选车源";
//    [self addSubview:label];
//    
//}
@end
