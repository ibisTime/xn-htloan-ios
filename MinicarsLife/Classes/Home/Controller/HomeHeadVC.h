//
//  HomeHeadVC.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol ClickBtn <NSObject>

-(void)ClickBtn:(UIButton *)sender;
-(void)ClickCollection:(NSInteger)index;

@end
@interface HomeHeadVC : UIView
@property (nonatomic,weak) id<ClickBtn> delegate;
@end

NS_ASSUME_NONNULL_END
