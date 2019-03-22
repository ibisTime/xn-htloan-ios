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
//        NSArray * titlearray = @[@"定速巡航",@"多功能方向盘",@"无钥匙进入",@"胎压监测"];
//        NSArray * imagearray = @[@"1",@"2",@"3",@"2"];
        for (int i = 0; i < 4; i++) {
            UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
            button.frame = CGRectMake(0 + (SCREEN_WIDTH / 4) * i, 0, (SCREEN_WIDTH / 4), 80);
//            [button setTitle:titlearray[i] forState:(UIControlStateNormal)];
            button.tag = 100 + i;
//            [button SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:0 imagePositionBlock:^(UIButton *button) {
//                [button setImage:imagearray[i] forState:(UIControlStateNormal)];
//            }];
            
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
//        button1.titleLabel.uiin
//        [button1 SG_imagePositionStyle:(SGImagePositionStyleTop) spacing:1 imagePositionBlock:^(UIButton *button) {
//            [button setImage:model.config[@"pic"] forState:(UIControlStateNormal)];
//        }];
    }
    
}
@end
