//
//  PopularBrandCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "PopularBrandCell.h"
#import "BrandCollectionCell.h"
@implementation PopularBrandCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = (SCREEN_WIDTH)/5.0;
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(width, 80);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80) collectionViewLayout:layout];
        self.collectionView.backgroundColor = kWhiteColor;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        self.collectionView.scrollEnabled = NO;
        [self.collectionView registerClass:[BrandCollectionCell class] forCellWithReuseIdentifier:@"cell"];
//        [self.collectionView registerClass:[BrandCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView"];
        [self addSubview:self.collectionView];
    }
    return self;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_delegate PopularBrandCellClickCollection:indexPath.row];
}

-(void)setHotCarBrands:(NSMutableArray *)HotCarBrands
{
    _HotCarBrands = HotCarBrands;
    float numberToRound;
    int result;
    numberToRound = (self.HotCarBrands.count)/5.0;
    result = (int)ceilf(numberToRound);
    
    self.collectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80 * result);
    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.HotCarBrands.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BrandCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.titlelab.text = self.HotCarBrands[indexPath.row].name;
    cell.logo.contentMode = UIViewContentModeScaleAspectFit;
    cell.logo.autoresizesSubviews = YES;
    cell.logo.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;;
    [cell.logo sd_setImageWithURL:[NSURL URLWithString:[self.HotCarBrands[indexPath.row].logo convertImageUrl]]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 0.01);
}


@end
