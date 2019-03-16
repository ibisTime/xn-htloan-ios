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
@interface BrandListVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView * collection;
@end

@implementation BrandListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择品牌";
    
    
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat  width = (SCREEN_WIDTH - 1) / 3;
    layout.itemSize = CGSizeMake(width, 0.8 * width);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0.1;
    layout.minimumLineSpacing = 0.1;
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
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";

    BrandCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:rid forIndexPath:indexPath];

    cell.layer.borderColor = kLineColor.CGColor;
    cell.layer.borderWidth = 1;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyListVC * vc = [ClassifyListVC new];
    [self.navigationController pushViewController:vc animated:YES];
}



@end
