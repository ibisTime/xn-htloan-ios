//
//  LeftHeadCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "LeftHeadCell.h"

@implementation LeftHeadCell

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
        self.backgroundColor = MainColor;
        self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
        self.titlelab.text = @"预计总花费（裸车价格+必要花费+商业保险）";
        [self addSubview:self.titlelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(15, self.titlelab.yy + 10, SCREEN_WIDTH - 30, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kWhiteColor];
//        self.moneylab.text = @"410，000元";
        self.moneylab.attributedText = [self getPriceAttribute:@"410，000元"];
        [self addSubview:self.moneylab];
    }
    return self;
}
-(NSMutableAttributedString *)getPriceAttribute:(NSString *)string{
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:string];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSRange range = [string rangeOfString:@"元"];
    NSRange pointRange = NSMakeRange(0, range.location);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = boldFont(20);
    //赋值
    [attribut addAttributes:dic range:pointRange];
    return attribut;
}
@end
