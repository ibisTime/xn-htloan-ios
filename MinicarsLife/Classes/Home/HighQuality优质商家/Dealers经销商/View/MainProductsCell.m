//
//  MainProductsCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "MainProductsCell.h"
#import "MainProductsCollCell.h"
@implementation MainProductsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kWhiteColor;
        
        
        [self addSubview:self.collection];
        
    }
    return self;
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = 130.00;
        // 设置每个item的大小
        layout.itemSize = CGSizeMake((SCREEN_WIDTH - 60)/5, 80);
        // 设置列间距
        layout.minimumInteritemSpacing = 15;
        // 设置行间距
        //        layout.minimumLineSpacing = 1;
        //每个分区的四边间距UIEdgeInsetsMake
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
        //        layout.estimatedItemSize = CGSizeMake(width , 338.00 / 226.00 * width);
        // 设置布局方向(滚动方向)
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 80 )collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[MainProductsCollCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dealersModel.brandList.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainProductsCollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.model = self.models[indexPath.row];
    cell.brand = self.dealersModel.brandList[indexPath.row];
    return cell;
    
}

-(void)setDealersModel:(CarModel *)dealersModel
{
    _dealersModel = dealersModel;
    [self.collection reloadData];
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"%ld",indexPath.row);
    if (self.delegate) {
        [self.delegate MainProductsSelectRow:indexPath.row];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
