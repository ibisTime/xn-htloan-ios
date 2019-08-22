//
//  CarDetailsDealersCell.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CarDetailsDealersCell.h"

@implementation CarDetailsDealersCell
{
    UIImageView *iconImg;
    UIButton *nameBtn;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 20, 50, 38)];
        [self addSubview:iconImg];
        
        nameBtn = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:14];
        nameBtn.frame = CGRectMake(iconImg.xx + 6, 29, SCREEN_WIDTH - iconImg.xx + 6 - 40, 20);
        nameBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self addSubview:nameBtn];
        

        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 6, 33.5, 6, 11)];
        img.image = kImage(@"you");
        [self addSubview:img];

        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        [self addSubview:backView];
        
    }
    
    return self;
}

-(void)setCarDealer:(CarModel *)carDealer
{
    [iconImg sd_setImageWithURL:[NSURL URLWithString:[carDealer.shopLogo convertImageUrl]]];
    [nameBtn setTitle:carDealer.fullName forState:(UIControlStateNormal)];
    if ([carDealer.isHighQuality integerValue] == 1) {
        [nameBtn SG_imagePositionStyle:(SGImagePositionStyleRight) spacing:3 imagePositionBlock:^(UIButton *button) {
            [nameBtn setImage:kImage(@"优质") forState:(UIControlStateNormal)];
        }];
    }
    
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
