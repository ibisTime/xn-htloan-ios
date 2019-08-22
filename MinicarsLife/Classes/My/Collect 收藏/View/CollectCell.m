//
//  CollectCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/13.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CollectCell.h"

@interface CollectCell()
@property (nonatomic,strong) UIImageView * image;
@property (nonatomic,strong) UILabel * titlelab;
@property (nonatomic,strong) UILabel * describdlab;
@property (nonatomic,strong) UILabel * timelab;
@property (nonatomic,strong) UILabel * moneylab;

//@property (nonatomic,strong) UIView * view;
@end


@implementation CollectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    return;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 110, 82.5)];
        [self addSubview:img];
        self.image = img;
        self.image.contentMode = UIViewContentModeScaleAspectFit;
//        self.image.autoresizesSubviews = YES;
//        self.image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;;
        
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 15, SCREEN_WIDTH - 155, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
//        title.text = @"奔驰SUV 600 xDriv351 基本型 小屏 织物中东";
        title.numberOfLines = 2;
        [self addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake(img.xx + 15, title.yy + 5, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
//        describe.text = @"中大型SUV 白/米 车在杭州市";
        [self addSubview:describe];
        self.describdlab = describe;
        
        UILabel * time = [UILabel labelWithFrame:CGRectMake(img.xx + 15, describe.yy + 5, 74, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
//        time.text = @"2019-03-11";
        [self addSubview:time];
        self.timelab = time;
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(time.xx + 15, describe.yy + 5, SCREEN_WIDTH - 15 - 15 - time.xx, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#028EFF")];
//        money.text = @"54.9万";
        [self addSubview:money];
        self.moneylab = money;
        
//        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, img.yy + 10, SCREEN_WIDTH - 30, 50)];
        
        
        
//        UILabel *view = [[UILabel alloc]initWithFrame:CGRectMake(15, img.yy + 10, SCREEN_WIDTH - 30, 50)];
////        view.backgroundColor = kHexColor(@"#F5F5F5");
////        self.view = view;
//        [self addSubview:view];
        
        UILabel * content = [UILabel labelWithFrame:CGRectMake(15, 82.5 + 25, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 0;
//        content.text = @"底挂，2气，6速，冰箱，7座，铝踏，拖钩，中差，18铝，智能卡，主驾电座，前后雾灯，一键启动";
        
        [self addSubview:content];
        
        
        
        self.contentlab = content;
    }
    return self;
}

//-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
//    if (!self.editing) {
//        return;
//    }
//    [super setSelected:selected animated:animated];
//
//    if (self.editing) {
//
//        self.contentView.backgroundColor = [UIColor clearColor];
//        self.backgroundColor = [UIColor clearColor];
//    }
//}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    CGFloat moveSpace = 38;//一般移动距离是38
    if (editing) {
        self.image.frame = CGRectMake(15 + moveSpace, 15, 110, 82.5);
        self.titlelab.frame = CGRectMake(self.image.xx + 15, 15, SCREEN_WIDTH - 155, 40);
        self.describdlab.frame = CGRectMake(self.image.xx + 15, self.titlelab.yy + 5, SCREEN_WIDTH - 120, 16.5);
        self.timelab.frame = CGRectMake(self.image.xx + 15, self.describdlab.yy + 5, 74, 16.5);
        self.view.frame = CGRectMake(15 + moveSpace, self.image.yy + 10, SCREEN_WIDTH - 30, 50);
    }
    else{
        self.image.frame = CGRectMake(15, 15, 110, 82.5);
        self.titlelab.frame = CGRectMake(self.image.xx + 15, 15, SCREEN_WIDTH - 155, 40);
        self.describdlab.frame = CGRectMake(self.image.xx + 15, self.titlelab.yy + 5, SCREEN_WIDTH - 120, 16.5);
        self.timelab.frame = CGRectMake(self.image.xx + 15, self.describdlab.yy + 5, 74, 16.5);
        self.view.frame = CGRectMake(15, self.image.yy + 10, SCREEN_WIDTH - 30, 50);
    }
}
-(void)setModel:(CollectModel *)model{
    _model = model;
    CarModel * car = [CarModel mj_objectWithKeyValues:model.car];
    
    self.moneylab.text = [NSString stringWithFormat:@"%@",[USERXX AddSymbols:[car.salePrice floatValue]/1000]];
    self.timelab.text = [car.updateDatetime convertToDetailDateWithoutHour];
//    self.contentlab.text = car.Description;
//    self.describdlab.text = car.brandName;
    self.titlelab.text = car.name;
    
    
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[car.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    //超出容器范围的切除掉
//    self.image.clipsToBounds = YES;
    
//    self.describdlab.text = [NSString stringWithFormat:@"%@ %@/%@ %@",car.version,[USERXX convertNull: car.outsideColor],[USERXX convertNull: car.insideColor], [USERXX convertNull:car.fromPlace]];
    
    int level = [model.car[@"level"] intValue];
    switch (level) {
        case 0:
            self.describdlab.text = @"SUV";
            break;
        case 1:
            self.describdlab.text = @"轿车";
            break;
        case 2:
            self.describdlab.text = @"MPV";
            break;
        case 3:
            self.describdlab.text = @"跑车";
            break;
        case 4:
            self.describdlab.text = @"皮卡";
            break;
        case 5:
            self.describdlab.text = @"房车";
            break;
            
        default:
            break;
    }
    self.contentlab.frame = CGRectMake(15, 82.5 + 25, SCREEN_WIDTH - 30, 0);
    self.contentlab.text = car.configName;
    [self.contentlab sizeToFit];
}


-(void)setDataArray:(NSArray *)dataArray
{
//    NSString *version;
//    CarModel * car = [CarModel mj_objectWithKeyValues:_model.car];
//    for (int i = 0; i<dataArray.count; i ++) {
//        if ([car.version isEqualToString:dataArray[i][@"dkey"]]) {
//            version = dataArray[i][@"dvalue"];
//            self.describdlab.text = [NSString stringWithFormat:@"%@ %@/%@ %@",version,[USERXX convertNull: car.outsideColor],[USERXX convertNull: car.insideColor], [USERXX convertNull:car.fromPlace]];
//        }
//    }
    
}
@end
