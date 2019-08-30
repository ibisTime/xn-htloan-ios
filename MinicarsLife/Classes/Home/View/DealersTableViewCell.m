//
//  DealersTableViewCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DealersTableViewCell.h"
#import "HomeDealersCollCell.h"
@implementation DealersTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(16) textColor:kBlackColor];
        nameLbl.text = @"优质车商";
        [self addSubview:nameLbl];
        
        [self addSubview:self.collection];
        
    }
    return self;
}

-(UICollectionView *)collection{
    if (!_collection) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat width = 130.00;
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(90, 91);
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
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 54,SCREEN_WIDTH , 91 )collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[HomeDealersCollCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HomeDealersCollCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
    
}

-(void)setModels:(NSMutableArray<CarModel *> *)models
{
    _models = models;
    [self.collection reloadData];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"%ld",indexPath.row);
    if (self.delegate) {
        [self.delegate DealersCollectionSelectRow:indexPath.row];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
