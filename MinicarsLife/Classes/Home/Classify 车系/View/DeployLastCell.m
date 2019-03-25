//
//  DeployLastCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "DeployLastCell.h"

@implementation DeployLastCell

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
        UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH / 2 - 15, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        label1.tag = 1000;
//        label1.text = @"·底挂";
        [self addSubview:label1];
        
        UILabel * label2 = [UILabel labelWithFrame:CGRectMake(SCREEN_WIDTH / 2, 0, SCREEN_WIDTH / 2 - 15, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        label2.tag = 1001;
//        label2.text = @"·2气";
        [self addSubview:label2];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15,44 , SCREEN_WIDTH-30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
    }
    return self;
}
-(void)setDeployModels:(NSMutableArray *)DeployModels{
    _DeployModels = DeployModels;
//    UILabel * label1 = [self viewWithTag:1001];
//    label1.text = DeployModels[0];
    for (int i = 0; i < DeployModels.count; i++) {
        UILabel * label1 = [self viewWithTag:1000 + i];
        DeployModel * model = [DeployModel mj_objectWithKeyValues:DeployModels[i]];
        label1.text = [NSString stringWithFormat:@"·%@",model.config[@"name"]];
    }
}
@end
