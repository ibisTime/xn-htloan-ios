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
 
    }
    return self;
}
-(void)setConfigs:(NSArray *)configs{
    _configs = configs;
//    UILabel * label1 = [self viewWithTag:1001];
//    label1.text = DeployModels[0];
//    for (int i = 0; i < DeployModels.count; i++) {
//        UILabel * label1 = [self viewWithTag:1000 + i];
//        DeployModel * model = [DeployModel mj_objectWithKeyValues:DeployModels[i]];
//        label1.text = [NSString stringWithFormat:@"·%@",model.config[@"name"]];
//    }
    for (int i = 0; i < configs.count; i ++) {
        UILabel * label1 = [UILabel labelWithFrame:CGRectMake(15 + i % 2 * (SCREEN_WIDTH / 2 - 15), i/2 * 40, SCREEN_WIDTH / 2 - 15, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        label1.tag = 1000;
        label1.text = [NSString stringWithFormat:@"·%@",configs[i][@"config"][@"name"]];
        [self addSubview:label1];
        
    }
//    for (int i = 0; i < configs.count; i ++) {
//        if (configs[i][@""]) {
//            <#statements#>
//        }
//    }
}
@end
