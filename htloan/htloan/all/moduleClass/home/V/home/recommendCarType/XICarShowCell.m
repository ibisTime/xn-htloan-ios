//
//  XICarShowCell.m
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XICarShowCell.h"

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
        self.carImageView.backgroundColor =[UIColor greenColor];
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
        
        self.carName.backgroundColor = [UIColor yellowColor];
        
        [self.carName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.offset(10);
            make.centerX.equalTo(self.carImageView.mas_centerX);
        }];
        
        self.carPayment =[[UILabel alloc ] init];
        [self.contentView addSubview: self.carPayment];
        
        self.carPayment.backgroundColor = [UIColor yellowColor];
        
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
    self.carImageView.image = [UIImage imageNamed:carShowModel.carImgName];
    self.carName.text = carShowModel.carName;
    self.carPayment.text =[NSString stringWithFormat:@"首付%@万",carShowModel.carPayment] ;
    

}


@end
