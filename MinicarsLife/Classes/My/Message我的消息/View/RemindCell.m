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
        UILabel * title = [UILabel labelWithFrame:CGRectMake(15, 20, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(15) textColor:kBlackColor];
        title.text = @"APP更新";
        [self addSubview:title];
        titlelab = title;
        
        UILabel * content = [UILabel labelWithFrame:CGRectMake(15, title.yy + 5, SCREEN_WIDTH - 30, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(13) textColor:kTextColor3];
        content.text = @"V1.0版本正式上线，如遇问题欢迎使用智能客服";
        [self addSubview:content];
        contentlab = content;
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, content.yy + 5, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [self addSubview:v1];
        
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, v1.yy + 5, 100, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(13) textColor:kTextColor3];
        label.text = @"查看详情";
        [self addSubview:label];
        
        UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 40, v1.yy + 5, 15, 15)];
        image.image = kImage(@"you");
        [self addSubview:image];
        
    }
    return self;
}
-(void)setModel:(MessageModel *)model{
    _model = model;
    titlelab.text = model.title;
    contentlab.text = model.content;
}
@end
