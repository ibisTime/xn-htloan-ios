//
//  CarInfoHeadCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarInfoHeadCell.h"

@implementation CarInfoHeadCell
{
    UIView * view1;
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
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        

        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        
        title.numberOfLines = 1;
        [self addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake( 15, title.yy + 5, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        
        [self addSubview:describe];
        self.describdlab = describe;
        
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(15, describe.yy + 5, SCREEN_WIDTH - 30 - 100, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#028EFF")];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"参考价 54.9万"];
        [att addAttribute:NSForegroundColorAttributeName value:kTextColor2 range:NSMakeRange(0, 3)];
        money.attributedText = att;
        
        [self addSubview:money];
        self.moneylab = money;
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, money.yy + 10, SCREEN_WIDTH - 30, 50)];
        view.backgroundColor = kHexColor(@"#F5F5F5");
        [self addSubview:view];
        self.view = view;
        
        UILabel * content = [UILabel labelWithFrame:CGRectMake(7.5, 8.5, view.width - 15, 33) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 0;
        
        
        [view addSubview:content];
       
        
        self.contentlab = content;
        
        
        
        view1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 52 - 15, describe.yy + 5, 52, 18)];
        kViewRadius(view1, 2);
        view1.layer.borderColor = kHexColor(@"#FF9402").CGColor;
        view1.layer.borderWidth = 0.5;
        view1.backgroundColor = kHexColor(@"#FF9402");
        view1.alpha = 0.2;
        [self addSubview:view1];
        
        
        
        
        UIButton * button = [UIButton buttonWithTitle:@"计算器" titleColor:kBlackColor backgroundColor:kClearColor titleFont:10 cornerRadius:2];
        button.frame = CGRectMake(SCREEN_WIDTH - 52 - 15, describe.yy + 5, 52, 18);
        [button SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"详情-计算器") forState:(UIControlStateNormal)];
        }];
        button.tag = 1001;
        self.button = button;
        [self addSubview:button];
        
        
    }
    return self;
}

-(void)setCarModel:(CarModel *)CarModel{
    _CarModel = CarModel;
    
    self.titlelab.text = [NSString stringWithFormat:@"%@",CarModel.name];
    self.titlelab.frame = CGRectMake(15, 15, SCREEN_WIDTH - 30, 22.5);
    self.titlelab.numberOfLines = 0;
    [self.titlelab sizeToFit];
    
    
    self.describdlab.frame = CGRectMake( 15, _titlelab.yy + 5, SCREEN_WIDTH - 120, 16.5);
    self.moneylab.frame = CGRectMake(15, _describdlab.yy + 5, SCREEN_WIDTH - 30 - 100, 16.5);
    view1.frame = CGRectMake(SCREEN_WIDTH - 52 - 15, _describdlab.yy + 5, 52, 18);
    self.button.frame = CGRectMake(SCREEN_WIDTH - 52 - 15, _describdlab.yy + 5, 52, 18);
    if (![CarModel.type isEqualToString:@"1"]) {
        self.button.hidden = NO;
        view1.hidden = NO;
    }else{
        self.button.hidden = YES;
        view1.hidden = YES;
    }
    
    NSString * str;
    if (CarModel.salePrice.length > 5) {
        str = [NSString stringWithFormat:@"参考价 %.2f万",[CarModel.salePrice floatValue]/10000/1000];
    }else
        str = [NSString stringWithFormat:@"参考价 %.2f",[CarModel.salePrice floatValue]/1000];
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
    [att addAttribute:NSForegroundColorAttributeName value:kTextColor2 range:NSMakeRange(0, 3)];
    self.moneylab.attributedText = att;
    
    
    
    
    
    self.contentlab.frame = CGRectMake(7.5, 8.5, self.view.width - 15, 33);
    self.contentlab.text = CarModel.Description;
    [self.contentlab sizeToFit];
    self.view.frame = CGRectMake(15, self.moneylab.yy + 10, SCREEN_WIDTH - 30, self.contentlab.height + 17);

}

-(void)setDataArray:(NSArray *)dataArray
{
    NSString *version;
    for (int i = 0; i<dataArray.count; i ++) {
        if ([_CarModel.version isEqualToString:dataArray[i][@"dkey"]]) {
            version = dataArray[i][@"dvalue"];
            self.describdlab.text = [NSString stringWithFormat:@"%@ 外色:%@ 内色:%@ %@",version,[USERXX convertNull: _CarModel.outsideColor],[USERXX convertNull: _CarModel.insideColor], [USERXX convertNull:_CarModel.fromPlace]];
        }
    }
    
}

@end
