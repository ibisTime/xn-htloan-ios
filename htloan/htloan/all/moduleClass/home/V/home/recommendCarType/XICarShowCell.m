//
//  XICarShowCell.m
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XICarShowCell.h"

#import <UIImageView+WebCache.h>


#import "CoinHeader.h"
#import "homeCarShowModel.h"
@interface XICarShowCell()
//汽车照片
@property (nonatomic, strong) UIImageView *carImageView;
//汽车品牌
@property (nonatomic, strong) UILabel * carName;
//首付款
@property (nonatomic, strong) UILabel * carPayment;

@end

@implementation XICarShowCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.carImageView = [[UIImageView alloc] init];
        self.carImageView.backgroundColor =kWhiteColor;
        [self.contentView addSubview:self.carImageView];
        
    
        self .carImageView.image = [UIImage imageNamed:@"1"];
        self.carImageView.clipsToBounds = YES;
        self.carImageView.contentMode = UIViewContentModeScaleAspectFill;
     
        [self.carImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(12);
            make.left.offset(5);
            make.right.offset(-5);
            make.bottom.offset(-43);
            
        }];
    
        
        self.carName =[[UILabel alloc ] init];
        [self.contentView addSubview: self.carName];
        
        self.carName.backgroundColor = kWhiteColor;
        
        [self.carName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.carImageView.mas_bottom).offset(5);
            make.centerX.equalTo(self.carImageView.mas_centerX);
        }];
        
        self.carPayment =[[UILabel alloc ] init];
        [self.contentView addSubview: self.carPayment];
        
        self.carPayment.backgroundColor = kWhiteColor;
        
        [self.carPayment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom);
            make.centerX.equalTo(self.carImageView.mas_centerX);
        }];

        
        
        
        
        
    }
    return  self;
}

//数据
-(void)setCarShowModel:(homeCarShowModel*)carShowModel
{   _carShowModel =carShowModel;
//    self.carImageView.image = [UIImage imageNamed:carShowModel.advPic];
    
    self.code = carShowModel.code;
    [self.carImageView sd_setImageWithURL:[NSURL URLWithString:carShowModel.pic]];
    
    self.carName.text = carShowModel.name;
//    self.carName.text = @"宝马";
    self.carPayment.text =[NSString stringWithFormat:@"首付%@万",carShowModel.originalPrice] ;
    

}


@end
