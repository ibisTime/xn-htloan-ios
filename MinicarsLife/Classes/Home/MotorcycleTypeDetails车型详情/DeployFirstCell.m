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
        UILabel * content = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 0;
        
        [self addSubview:content];
        
        
        self.contentlab = content;
    }
    return self;
}

-(void)setCarConfig:(NSString *)carConfig
{
    self.contentlab.frame = CGRectMake(15, 10, SCREEN_WIDTH - 30, 0);
    self.contentlab.text = carConfig;
    [self.contentlab sizeToFit];
}

//-(void)setCaonfigList:(NSArray *)caonfigList{
////    _caonfigList = caonfigList;
////
//
//    NSMutableArray *ary = [NSMutableArray array];
//    for (int i = 0; i < caonfigList.count; i ++) {
//        if (![caonfigList[i][@"config"][@"name"] isEqualToString:@""]) {
//            [ary addObject:caonfigList[i][@"config"][@"name"]];
//        }
//    }
//
//
//
//    if (ary.count > 0) {
//
//
//        JKSmallLabels *jkSmallLabels = [[JKSmallLabels new]createSmallLabelGroupNames:ary withlabelFont:12 withlabelTextColor:kHexColor(@"#666666") withlabelBackgroundColor:kHexColor(@"#F0F0F0") withMaxWidth:SCREEN_WIDTH - 30 withInsideHorizontalSpace:10 withInsideVerticalSpace:6 withOuterHorizontalSpace:10 withOuterVerticalSpace:10];
//        //    self.
//        self.jkSmallLabels = jkSmallLabels;
//        jkSmallLabels.x = 15;
//        jkSmallLabels.y = 15;
//        //    jkSmallLabels.backgroundColor = kHexColor(@"#F0F0F0");
//        kViewRadius(jkSmallLabels, 12.5);
//        jkSmallLabels.JKSmallLabelClick = ^(NSInteger tag)
//        {
//            NSLog(@"tag=%ld",(long)tag);
//        };
//        [self addSubview:jkSmallLabels];
//
////        self.v1.frame = CGRectMake(15, jkSmallLabels.yy + 15, SCREEN_WIDTH - 30, 1);
//    }
////
////    for (int i = 0; i < caonfigList.count; i++) {
////
////
////        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(i % 4 * SCREEN_WIDTH/4, i / 4 * 70, SCREEN_WIDTH/4, 70)];
////        [self addSubview:backView];
////
////
////        UIImageView * logo = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4/2 - 20, 0, 40, 40)];
////        logo.tag = 1000 + i;
////        [backView addSubview:logo];
////
////
////        UIButton * button = [UIButton buttonWithTitle:@"" titleColor:kBlackColor backgroundColor:kClearColor titleFont:12 cornerRadius:0];
////        button.frame = CGRectMake(0 , logo.yy + 5 , (SCREEN_WIDTH / 4), 15);
////        button.tag = 100 + i;
////        [backView addSubview:button];
////
////
////        [button setTitle:caonfigList[i][@"config"][@"name"] forState:(UIControlStateNormal)];
////        [logo sd_setImageWithURL:[NSURL URLWithString:[caonfigList[i][@"config"][@"pic"] convertImageUrl]] placeholderImage:kImage(@"default_pic")];
////    }
//
//}
@end
