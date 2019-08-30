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
        
        haveReadLbl = [UILabel labelWithFrame:CGRectMake(15, 17, 30, 16) textAligment:(NSTextAlignmentCenter) backgroundColor:MainColor font:Font(10) textColor:kWhiteColor];
        haveReadLbl.text = @"未读";
        kViewRadius(haveReadLbl, 2);
        [self addSubview:haveReadLbl];
        
        
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(haveReadLbl.xx + 5, 15, SCREEN_WIDTH - haveReadLbl.xx - 20, 20) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        title.text = @"APP更新";
        [self addSubview:title];
        titlelab = title;
        
        UILabel * content = [UILabel labelWithFrame:CGRectMake(15, title.yy + 5, SCREEN_WIDTH - 30, 45) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(13) textColor:kTextColor3];
        content.text = @"V1.0版本正式上线，如遇问题欢迎使用智能客服";
        content.numberOfLines = 2;
        [self addSubview:content];
        contentlab = content;
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 85, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, v1.yy + 5, 100, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(13) textColor:kTextColor3];
        label.text = @"查看详情";
        [self addSubview:label];
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 21, v1.yy + 10, 6, 11)];
        image.image = kImage(@"you");
        [self addSubview:image];
        
    }
    return self;
}

-(void)setModel:(MessageModel *)model{
    _model = model;
    
    if ([model.content hasPrefix:@"<p>"]) {
        NSRange startRange = [model.content rangeOfString:@"<p>"];
        NSRange endRange = [model.content rangeOfString:@"</p>"];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString * con = [model.content substringWithRange:range];
        contentlab.text = con;
    }else
    {
        contentlab.text = model.content;
    }
    contentlab.frame = CGRectMake(15, 40, SCREEN_WIDTH - 30, 45);
    [contentlab sizeToFit];

    if ([USERXX isBlankString:model.isAlreadyRead] == NO && [model.isAlreadyRead isEqualToString:@"0"]) {
        haveReadLbl.text = @"未读";
        haveReadLbl.backgroundColor = MainColor;
    }
    else
    {
        haveReadLbl.text = @"已读";
        haveReadLbl.backgroundColor = RGB(220, 220, 220);
    }
    titlelab.text = model.title;
    
    
}



@end
