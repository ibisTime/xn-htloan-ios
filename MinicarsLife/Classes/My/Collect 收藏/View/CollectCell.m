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
@property (nonatomic,strong) UILabel * contentlab;
@end


@implementation CollectCell

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
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 110, 82.5)];
        [self addSubview:img];
        self.image = img;
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 15, SCREEN_WIDTH - 155, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kBlackColor];
        title.text = @"奔驰SUV 600 xDriv351 基本型 小屏 织物中东";
        title.numberOfLines = 2;
        [self addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake(img.xx + 15, title.yy + 5, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        describe.text = @"中大型SUV 白/米 车在杭州市";
        [self addSubview:describe];
        self.describdlab = describe;
        
        UILabel * time = [UILabel labelWithFrame:CGRectMake(img.xx + 15, describe.yy + 5, 74, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        time.text = @"2019-03-11";
        [self addSubview:time];
        self.timelab = time;
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(time.xx + 15, describe.yy + 5, SCREEN_WIDTH - 15 - 15 - time.xx, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#028EFF")];
        money.text = @"54.9万";
        [self addSubview:money];
        self.moneylab = money;
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, img.yy + 10, SCREEN_WIDTH - 30, 50)];
        UILabel * content = [UILabel labelWithFrame:CGRectMake(7.5, 8.5, view.width - 15, 33) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        content.numberOfLines = 2;
        content.text = @"底挂，2气，6速，冰箱，7座，铝踏，拖钩，中差，18铝，智能卡，主驾电座，前后雾灯，一键启动";
        view.backgroundColor = kHexColor(@"#F5F5F5");
        [view addSubview:content];
        [self addSubview:view];
        self.contentlab = content;
    }
    return self;
}

@end
