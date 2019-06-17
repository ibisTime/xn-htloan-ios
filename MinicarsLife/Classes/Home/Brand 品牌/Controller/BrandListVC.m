//
//  BrandListVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandListVC.h"
#import "BrandCell.h"
#import "ClassifyListVC.h"
#import "CarModel.h"
@interface BrandListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collection;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;
@end

@implementation BrandListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
    self.title = @"选择品牌";
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat  width = (SCREEN_WIDTH - 0.0004) / 3;
    layout.itemSize = CGSizeMake(width, 0.8 * width);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0.0001;
    layout.minimumLineSpacing = 0.0001;
    layout.estimatedItemSize = CGSizeMake(width , 0.8 * width);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collection.backgroundColor = kWhiteColor;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[BrandCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.collection];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.CarModels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";

    BrandCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:rid forIndexPath:indexPath];
    cell.carmodel = self.CarModels[indexPath.row];
    cell.layer.borderColor = kLineColor.CGColor;
    cell.layer.borderWidth = 1;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    [self getClassifyListData:self.CarModels[indexPath.row].code];
    ClassifyListVC * vc = [ClassifyListVC new];
    vc.brandcode = self.CarModels[indexPath.row].code;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getClassifyListData:(NSString *)code{
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630416";
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"brandCode"] = code;
    [http2 postWithSuccess:^(id responseObject) {
        ClassifyListVC * vc = [ClassifyListVC new];
        vc.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.brandcode = code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)getdata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630406";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.collection reloadData];
    } failure:^(NSError *error) {
    }];
}

@end
