//
//  HomeTableHeadCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/19.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "HomeTableHeadCell.h"
#import "HotCarCollectionCell.h"
#import "NewsModel.h"
#import "ChooseCarVC.h"
@implementation HomeTableHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
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
        layout.itemSize = CGSizeMake(width, 170);
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
        
        _collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , 170 )collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.showsVerticalScrollIndicator = NO;
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerClass:[HotCarCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collection;
}



#pragma mark - 十一个按钮


#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.CarStyleModels.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    HotCarCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.model =[CarModel mj_objectWithKeyValues: self.CarStyleModels[indexPath.row]];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //    NSLog(@"%ld",indexPath.row);
    if (self.delegate) {
        [self.delegate ClickCollection:indexPath.row];
    }
}

#pragma mark - 点击事件
-(void)clickbtn:(UIButton *)sender{
    if (self.delegate) {
//        [self.delegate ClickBtn:sender];
    }
    
}
- (void)clickImage:(NSInteger)inter
{
    
    
}
-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex{
    //    NSLog(@"%ld",currentImageIndex);
}

#pragma mark - 获取数据



-(void)setCarStyleModels:(NSMutableArray<CarModel *> *)CarStyleModels{
    _CarStyleModels = CarStyleModels;
    [self.collection reloadData];
}
@end
