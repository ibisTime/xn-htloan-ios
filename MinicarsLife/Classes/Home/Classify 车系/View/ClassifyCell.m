//
//  ClassifyCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyCell.h"
@interface ClassifyCell()
@property (nonatomic,strong) UIImageView * ClassifyLogo;
@property (nonatomic,strong) UILabel * ClassifyName;
@property (nonatomic,strong) UILabel * ClassiftType;
@property (nonatomic,strong) UILabel * ClassifyPrice;
@end
@implementation ClassifyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.ClassifyLogo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 110, 82.5)];
        self.ClassifyLogo.image = kImage(@"1");
        [self addSubview:self.ClassifyLogo];
        
        self.ClassifyName = [UILabel labelWithFrame:CGRectMake(self.ClassifyLogo.xx + 15, 15, SCREEN_WIDTH - 30 - 85, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
        self.ClassifyName.text = @"奔驰SUV 600";
        [self addSubview:self.ClassifyName];
        
        self.ClassiftType = [UILabel labelWithFrame:CGRectMake(self.ClassifyLogo.xx + 15, self.ClassifyName.yy +9, SCREEN_WIDTH - 30 - 85, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        self.ClassiftType.text = @"中大型SUV";
        [self addSubview:self.ClassiftType];
        
        self.ClassifyPrice = [UILabel labelWithFrame:CGRectMake(self.ClassifyLogo.xx + 15, self.ClassiftType.yy +9, SCREEN_WIDTH - 30 - 85, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kHexColor(@"#028EFF")];
        self.ClassifyPrice.text = @"54.9-108万";
        [self addSubview:self.ClassifyPrice];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 109, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
    }
    return self;
}
@end
