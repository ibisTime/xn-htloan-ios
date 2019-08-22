//
//  DealersTableViewCell.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol CollectionSelectRowDelegate <NSObject>

//-(void)ClickBtn:(UIButton *)sender;
-(void)DealersCollectionSelectRow:(NSInteger)index;

@end
@interface DealersTableViewCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) id<CollectionSelectRowDelegate> delegate;
@property (nonatomic , strong)UICollectionView *collection;
@property (nonatomic , strong)NSMutableArray <CarModel *>*models;
@end

NS_ASSUME_NONNULL_END
