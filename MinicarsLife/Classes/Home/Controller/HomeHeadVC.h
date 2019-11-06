//
//  HomeHeadVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"
#import "CarModel.h"
#import "SelVideoPlayer.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ClickBtn <NSObject>

-(void)ClickBtn:(UIButton *)sender;
-(void)ClickCollectionClassify:(NSIndexPath *)index;
-(void)ClickCollectionClassify:(NSIndexPath *)index withmodels:(CarModel *)models;
-(void)bannerUrl:(NSDictionary *)advertisingDic;
-(void)clickImage:(NSInteger)inter;

@end
@interface HomeHeadVC : UIView
@property (nonatomic,weak) id<ClickBtn> delegate;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarBrandModels;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarClassifyModels;
@property (nonatomic, strong) SelVideoPlayer *player;
@property (nonatomic , strong)HW3DBannerView *scrollView;

@property (nonatomic,strong) UICollectionView *collection;
@end

NS_ASSUME_NONNULL_END
