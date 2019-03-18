//
//  BrandCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/18.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "BrandCell.h"

@implementation BrandCell

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
        self.logo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 50, 25)];
        [self.logo sizeToFit];
        self.logo.frame = CGRectMake(65 - self.logo.width, 15, self.logo.width, 25);
        [self addSubview:self.logo];
        
        self.namelab = [UILabel labelWithFrame:CGRectMake(65, 20, SCREEN_WIDTH - 65 - 15, 17) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kBlackColor];
        [self addSubview:self.namelab];
        
    }
    return self;
}

@end
