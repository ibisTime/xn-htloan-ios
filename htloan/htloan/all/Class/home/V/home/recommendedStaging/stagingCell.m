//
//  stagingCell.m
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "stagingCell.h"

#import "TLUIHeader.h"
#import "AppColorMacro.h"

//m
#import "stagingModel.h"

#import "UILabel+Extension.h"

@interface stagingCell ()

@property (nonatomic, strong) UIImageView *carImg;

@property (nonatomic, strong) UILabel * carTitle;

@property (nonatomic, strong) UILabel * carPayments;

@property (nonatomic, strong) UILabel * carMonthlyPayments;

@end



@implementation stagingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
        
    }
    return self;
    
}

-(void)initSubviews{
    
    //xiaotiao
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(@(kLineHeight));
        make.top.equalTo(self.mas_top);
    }];

    
    
    //car tu
    self.carImg = [[UIImageView alloc] init];
    self.carImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.carImg];
    //标题
    self.carTitle = [UILabel labelWithBackgroundColor:kClearColor textColor:RGB(51, 51, 51) font:15.0];
    self.carTitle.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.carTitle];
   //总额
    self.carPayments =[UILabel labelWithBackgroundColor:kClearColor textColor:RGB(252, 113, 42) font:16.0];
    self.carPayments.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.carPayments];
    
   //月供
    self.carMonthlyPayments =[UILabel labelWithBackgroundColor:kClearColor textColor:RGB(153, 153, 153) font:13.0];
    self.carPayments.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.carPayments];
    
   
}

- (void)setSubviewLayout {
    [self.carImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(25);
        make.left.offset(15);
        make.bottom.offset(10);


    }];

//    [self.carTitle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.offset(30);
//        make.left.equalTo(self.carImg.mas_right).offset(10);
//
//        }];
//
//    [self.carPayments mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.carImg.mas_right).offset(10);
//        make.bottom.offset(15);
//    }];
//
//
//    [self.carMonthlyPayments mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.offset(-64);
//        make.bottom.offset(15);
//    }];
//
}
//shuju
- (void)setStaModel:(stagingModel *)staModel {
    
    _staModel =staModel;
    
    self.carImg.image = [UIImage imageNamed:staModel.carImg];
    self.carTitle.text =staModel.carTitle;
    self.carPayments.text =staModel.carPayments;
    self.carMonthlyPayments.text = staModel.carMonthlyPayments;
        //布局
//    [self setSubviewLayout];
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
