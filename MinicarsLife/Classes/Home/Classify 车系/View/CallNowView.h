//
//  CallNowView.h
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarModel.h"
#import "DeployModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol AskMoneyClickDelegate <NSObject>

-(void)askmoneyWithphone:(NSString *)phone name:(NSString*)name;
-(void)deleteBtnClickDelegate;

@end
@interface CallNowView : UIView
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * describdlab;
@property (nonatomic,strong) UILabel * timelab;
@property (nonatomic,strong) UILabel * moneylab;
@property (nonatomic,strong) UILabel * contentlab;
@property (nonatomic,strong) UIView * view;
@property (nonatomic,strong) UITextField * phone;
@property (nonatomic,strong) UITextField * name;
@property (nonatomic,weak) id<AskMoneyClickDelegate> delegate;
@property (nonatomic,strong) CarModel * carmodel;

@end

NS_ASSUME_NONNULL_END
