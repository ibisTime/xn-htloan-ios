//
//  PopularBrandCell.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol PopularBrandCellClick<NSObject>

//-(void)ClickBtn:(UIButton *)sender;
-(void)PopularBrandCellClickCollection:(NSInteger)index;

@end

@interface PopularBrandCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) id<PopularBrandCellClick> delegate;
@property (nonatomic,strong) NSMutableArray<CarModel *> * HotCarBrands;
@property (nonatomic , strong)UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END
