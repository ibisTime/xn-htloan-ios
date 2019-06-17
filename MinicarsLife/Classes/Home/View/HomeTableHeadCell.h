//
//  HomeTableHeadCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/19.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ClickBtn <NSObject>

//-(void)ClickBtn:(UIButton *)sender;
-(void)ClickCollection:(NSInteger)index;

@end
@interface HomeTableHeadCell : UITableViewCell<HW3DBannerViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
//@property (nonatomic , strong)HW3DBannerView *scrollView;

@property (nonatomic,strong) UICollectionView * collection;
@property (nonatomic,weak) id<ClickBtn> delegate;

@property (nonatomic,strong) NSMutableArray<CarModel *> * CarStyleModels;
@end

NS_ASSUME_NONNULL_END
