//
//  HighQualityCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "HighQualityCell.h"

@implementation HighQualityCell
{
    UIImageView *iconImg;
    UILabel *nameLbl;
    UILabel *optionsLbl;
    UILabel * heatLbl;
    UILabel *dynamicLbl;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 120, 90)];
        kViewRadius(iconImg, 4);
        [self addSubview:iconImg];
        
        nameLbl = [UILabel labelWithFrame:CGRectMake(144, 20, SCREEN_WIDTH - 144 - 15, 18) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGboldfont(16) textColor:kBlackColor];
        nameLbl.text = @"天津利隆行国际贸易有限天津利隆行国际贸易有限";
        [self addSubview:nameLbl];
        
        optionsLbl = [UILabel labelWithFrame:CGRectMake(144, 46, 100, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:RGB(253, 246, 237) font:Font(12) textColor:kHexColor(@"#F89C44")];
        optionsLbl.frame = CGRectMake(144, 46, 100 ,16.5);
        optionsLbl.text = @"车源：10893";
        [optionsLbl sizeToFit];
        optionsLbl.frame = CGRectMake(144, 46, optionsLbl.width + 14, 16.5);
        kViewRadius(optionsLbl, 16/2);
        [self addSubview:optionsLbl];
        
//        heatLbl= [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#F85F44")];
//        NSString *heat = @"热度 233";
//        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:heat];
//        [attrStr addAttribute:NSForegroundColorAttributeName
//                        value:kHexColor(@"#999999")
//                        range:NSMakeRange(0, 2)];
//        heatLbl.attributedText = attrStr;
//        [self addSubview:heatLbl];
//        [heatLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(144);
//            make.top.mas_equalTo(88);
//            make.height.mas_equalTo(12);
//        }];
        
        dynamicLbl= [UILabel labelWithFrame:CGRectZero textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#F85F44")];
        NSString *dynamic = @"动态 233";
        NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:dynamic];
        [attrStr1 addAttribute:NSForegroundColorAttributeName
                        value:kHexColor(@"#999999")
                        range:NSMakeRange(0, 2)];
        dynamicLbl.attributedText = attrStr1;
        [self addSubview:dynamicLbl];
        [dynamicLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(144);
            make.top.mas_equalTo(88);
            make.height.mas_equalTo(12);
        }];
        
        
    }
    return self;
}

-(void)setModel:(CarModel *)model
{
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[model.shopLogo convertImageUrl]]];
    nameLbl.text = model.abbrName;
//    optionsLbl.text = model.
    
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
