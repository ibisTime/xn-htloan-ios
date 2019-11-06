//
//  MainProductsCell.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol MainProductsSelectRowDelegate <NSObject>

//-(void)ClickBtn:(UIButton *)sender;
-(void)MainProductsSelectRow:(NSInteger)index;

@end

@interface MainProductsCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) id<MainProductsSelectRowDelegate> delegate;
@property (nonatomic , strong)UICollectionView *collection;
@property (nonatomic , strong)CarModel *dealersModel;

@end

NS_ASSUME_NONNULL_END
