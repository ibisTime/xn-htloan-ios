//
//  CarInfoHeadCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarInfoHeadCell.h"

@implementation CarInfoHeadCell

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
//        title.text = @"奔驰SUV 600 xDriv351 基本型 小屏 织物中东";
        title.numberOfLines = 1;
        [self addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake( 15, title.yy + 5, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
//        describe.text = @"中大型SUV 白/米 车在杭州市";
        [self addSubview:describe];
        self.describdlab = describe;
        
//        UILabel * time = [UILabel labelWithFrame:CGRectMake( 15, describe.yy + 5, 74, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
//        time.text = @"2019-03-11";
//        [self addSubview:time];
//        self.timelab = time;
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(15, describe.yy + 5, SCREEN_WIDTH - 30 - 100, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#028EFF")];
        NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:@"参考价 54.9万"];
        [att addAttribute:NSForegroundColorAttributeName value:kTextColor2 range:NSMakeRange(0, 3)];
        money.attributedText = att;
//        money.text = @"54.9万";
        [self addSubview:money];
        self.moneylab = money;
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, money.yy + 10, SCREEN_WIDTH - 30, 50)];
        UILabel * content = [UILabel labelWithFrame:CGRectMake(7.5, 8.5, view.width - 15, 33) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 2;
//        content.text = @"底挂，2气，6速，冰箱，7座，铝踏，拖钩，中差，18铝，智能卡，主驾电座，前后雾灯，一键启动";
        view.backgroundColor = kHexColor(@"#F5F5F5");
        [view addSubview:content];
        [self addSubview:view];
        self.view = view;
        self.contentlab = content;
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 175, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [self addSubview:v1];
        
        UIView * view1 = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 52 - 15, describe.yy + 5, 52, 18)];
        kViewRadius(view1, 2);
        view1.layer.borderColor = kHexColor(@"#FF9402").CGColor;
        view1.layer.borderWidth = 0.5;
        view1.backgroundColor = kHexColor(@"#FF9402");
        view1.alpha = 0.2;
        
        UIButton * button = [UIButton buttonWithTitle:@"计算器" titleColor:kBlackColor backgroundColor:kClearColor titleFont:10 cornerRadius:2];
        button.frame = CGRectMake(0, 0, view1.bounds.size.width, view1.bounds.size.height);
        [button SG_imagePositionStyle:(SGImagePositionStyleDefault) spacing:2 imagePositionBlock:^(UIButton *button) {
            [button setImage:kImage(@"详情-计算器") forState:(UIControlStateNormal)];
        }];
        button.tag = 1001;
        self.button = button;
        [view1 addSubview:button];
        [self addSubview:view1];
    }
    return self;
}

-(void)setCarModel:(CarModel *)CarModel{
    _CarModel = CarModel;
    
    self.titlelab.text = [NSString stringWithFormat:@"%@",CarModel.name];
//    self.describdlab.text = [NSString stringWithFormat:@"%@ %@ %@",CarModel.brandName,CarModel.seriesName,CarModel.name];
    NSString * str;
    if (CarModel.salePrice.length > 5) {
        str = [NSString stringWithFormat:@"参考价 %.1f万",[CarModel.salePrice floatValue]/10000/1000];
    }else
        str = [NSString stringWithFormat:@"参考价 %.1f",[CarModel.salePrice floatValue]/1000];
    NSMutableAttributedString * att = [[NSMutableAttributedString alloc]initWithString:str];
    [att addAttribute:NSForegroundColorAttributeName value:kTextColor2 range:NSMakeRange(0, 3)];
    self.moneylab.attributedText = att;
    
//    self.contentlab.text = [NSString stringWithFormat:@"%@ %@ %@",CarModel.brandName,CarModel.seriesName,CarModel.name];
    
    
    
    
    self.contentlab.text = @"";
    NSMutableArray <DeployModel *> * model =[DeployModel mj_objectArrayWithKeyValuesArray:CarModel.caonfigList];
    for (int i = 0; i < model.count; i++) {
        self.contentlab.text = [NSString stringWithFormat:@"%@ %@",self.contentlab.text,model[i].config[@"name"]];
    }
}

-(void)setDataArray:(NSArray *)dataArray
{
    NSString *version;
    for (int i = 0; i<dataArray.count; i ++) {
        if ([_CarModel.version isEqualToString:dataArray[i][@"dkey"]]) {
            version = dataArray[i][@"dvalue"];
            self.describdlab.text = [NSString stringWithFormat:@"%@ %@/%@ %@",version,[USERXX convertNull: _CarModel.outsideColor],[USERXX convertNull: _CarModel.insideColor], [USERXX convertNull:_CarModel.fromPlace]];
        }
    }
    
}

@end
