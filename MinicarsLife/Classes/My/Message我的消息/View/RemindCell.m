//
//  RemindCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "RemindCell.h"

@implementation RemindCell{
    UILabel * titlelab;
    UILabel * contentlab;
    UILabel *haveReadLbl;
    UIImageView *headImg;
    UILabel *timeLbl;
    UIView *pointView;
}

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

        
        headImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 18.5, 41, 41)];
//        headImg.image = kImage(@"");
        [self addSubview:headImg];
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(headImg.xx + 8, 18.5, SCREEN_WIDTH - headImg.xx - 20, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        title.text = @"APP更新";
        [self addSubview:title];
        titlelab = title;

        
        timeLbl = [UILabel labelWithFrame:CGRectMake(headImg.xx + 8, 43, SCREEN_WIDTH - headImg.xx - 20, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#999999")];
        [self addSubview:timeLbl];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 78, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
        
        pointView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 20, 36.5, 5, 5)];
        pointView.backgroundColor = kHexColor(@"#FF3F3F");
        kViewRadius(pointView, 2.5);
        pointView.hidden = YES;
        [self addSubview:pointView];
    }
    return self;
}

-(void)setModel:(MessageModel *)model{
    _model = model;
    if ([USERXX isBlankString:model.isAlreadyRead] == NO && [model.isAlreadyRead isEqualToString:@"0"]) {
        pointView.hidden = NO;
    }
    else
    {
        pointView.hidden = YES;
    }
    
    titlelab.text = model.title;
    timeLbl.text = [model.createDatetime convertToDetailDate];
    if ([model.type isEqualToString:@"1"]) {
        headImg.image = kImage(@"公告");
    }
    else
    {
        headImg.image = kImage(@"通知");
    }
}

@end
