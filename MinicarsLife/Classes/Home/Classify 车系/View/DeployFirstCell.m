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
        for (int i = 0; i < 4; i++) {
            UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(((SCREEN_WIDTH / 4) - 40) / 2 + (SCREEN_WIDTH / 4) * i, 0, 40, 40)];
            logo.tag = 1000 + i;
            [self addSubview:logo];
            UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
            button.frame = CGRectMake(0 + (SCREEN_WIDTH / 4) * i, logo.yy, (SCREEN_WIDTH / 4), 20);
            button.tag = 100 + i;
            [self addSubview:button];
        }
    }
    return self;
}
-(void)setDeployModels:(NSMutableArray<DeployModel *> *)DeployModels{
    _DeployModels = DeployModels;
    
    
    for (int i = 0; i < DeployModels.count; i++) {
        UIButton * button1 = [self viewWithTag:i + 100];
        DeployModel* model = [DeployModel mj_objectWithKeyValues:DeployModels[i]];
        [button1 setTitle:model.config[@"name"] forState:(UIControlStateNormal)];
        
        UIImageView * logo = [self viewWithTag:1000 + i];
        [logo sd_setImageWithURL:[NSURL URLWithString:[model.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
//        button1.titleLabel.uiin
//        [button1 SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:1 imagePositionBlock:^(UIButton *button) {
//            [button setImage:model.config[@"pic"] forState:(UIControlStateNormal)];
//        }];
    }
    
}
@end
