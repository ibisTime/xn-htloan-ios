//
//  DeployFirstCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "DeployFirstCell.h"

@implementation DeployFirstCell

/**
 第一行配置cell
 */
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
        
    }
    return self;
}
-(void)setCaonfigList:(NSArray *)caonfigList{
    _caonfigList = caonfigList;
    
    
    for (int i = 0; i < caonfigList.count; i++) {
        
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(i % 4 * SCREEN_WIDTH/4, i / 4 * 70, SCREEN_WIDTH/4, 70)];
        [self addSubview:backView];
        
        
        UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4/2 - 20, 0, 40, 40)];
        logo.tag = 1000 + i;
        [backView addSubview:logo];
        
        
        UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        button.frame = CGRectMake(0 , logo.yy + 5 , (SCREEN_WIDTH / 4), 15);
        button.tag = 100 + i;
        [backView addSubview:button];

        
        [button setTitle:caonfigList[i][@"config"][@"name"] forState:(UIControlStateNormal)];
        [logo sd_setImageWithURL:[NSURL URLWithString:[caonfigList[i][@"config"][@"pic"] convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    }
    
}
@end
