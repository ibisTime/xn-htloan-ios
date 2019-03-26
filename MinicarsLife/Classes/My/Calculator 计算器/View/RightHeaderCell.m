//
//  RightHeaderCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "RightHeaderCell.h"

@implementation RightHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = MainColor;
        self.titlelab = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
        self.titlelab.text = @"预计首付款（裸车价格+必要花费+商业保险）";
        [self addSubview:self.titlelab];
        
        self.moneylab = [UILabel labelWithFrame:CGRectMake(15, self.titlelab.yy, SCREEN_WIDTH - 30, 60) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(20) textColor:kWhiteColor];
//        self.moneylab.text = @"289，000元";
        self.moneylab.attributedText = [self getPriceAttribute:@"0，00元"];
        [self addSubview:self.moneylab];
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, self.moneylab.yy + 5, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        v1.alpha = 0.3;
        [self addSubview:v1];
        
        for (int i = 0; i < 3; i ++) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0 + SCREEN_WIDTH / 3 * i, self.moneylab.yy + 10, SCREEN_WIDTH / 3, 70)];
            UILabel * money = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 3, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
            money.tag = i + 10;
            money.text = @"00.00";
            
            [view addSubview:money];
            
            UILabel * title = [UILabel labelWithFrame:CGRectMake(0, money.yy, SCREEN_WIDTH / 3, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(14) textColor:kWhiteColor];
            title.text = @"月供（元）";
            title.tag = i +100;
            [view addSubview:title];
            
            if (i < 2) {
                UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 3 * (i+1),self.moneylab.yy + 15, 1, 25)];
                v1.backgroundColor = kLineColor;
                v1.alpha = 0.3;
                [self addSubview:v1];
            }
            
            [self addSubview:view];
        }
        
        UILabel * l1 = [self viewWithTag:100];
        l1.text = @"月供(元)";
        
        UILabel * l2 = [self viewWithTag:101];
        l2.text = @"多花费(元)";
        
        UILabel * l3 = [self viewWithTag:102];
        l3.text = @"总花费(元)";
        
    }
    return self;
}
-(NSMutableAttributedString *)getPriceAttribute:(NSString *)string{
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:string];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSRange range = [string rangeOfString:@"元"];
    NSRange pointRange = NSMakeRange(0, range.location);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSFontAttributeName] = boldFont(40);
    //赋值
    [attribut addAttributes:dic range:pointRange];
    return attribut;
}

-(void)setMoneyarray:(NSArray *)moneyarray{
    _moneyarray = moneyarray;
    UILabel * l1 = [self viewWithTag:100];
    l1.text = @"月供(元)";
    
    UILabel * l2 = [self viewWithTag:101];
    l2.text = @"多花费(元)";
    
    UILabel * l3 = [self viewWithTag:102];
    l3.text = @"总花费(元)";
    
    UILabel * l4 = [self viewWithTag:10];
    l4.text = moneyarray[0];
    
    UILabel * l5 = [self viewWithTag:11];
    l5.text = moneyarray[1];
    
    UILabel * l6 = [self viewWithTag:12];
    l6.text = moneyarray[2];
    
    
}
@end
