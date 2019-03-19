//
//  CarCell.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarCell : UICollectionViewCell
@property (nonatomic,strong) UILabel * TitleLab;
@property (nonatomic,assign) BOOL * isselect;
@end

NS_ASSUME_NONNULL_END
