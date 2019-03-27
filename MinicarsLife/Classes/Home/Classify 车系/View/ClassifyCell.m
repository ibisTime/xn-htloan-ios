//
//  ClassifyCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyCell.h"
@interface ClassifyCell()
@property (nonatomic,strong) UIImageView * ClassifyLogo;
@property (nonatomic,strong) UILabel * ClassifyName;
@property (nonatomic,strong) UILabel * ClassiftType;
@property (nonatomic,strong) UILabel * ClassifyPrice;
@end
@implementation ClassifyCell

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
        self.ClassifyLogo = [[UIImageView alloc]initWithFrame:CGRectMake(15, 14, 110, 82.5)];
        self.ClassifyLogo.image = kImage(@"1");
        [self addSubview:self.ClassifyLogo];
        
        self.ClassifyName = [UILabel labelWithFrame:CGRectMake(self.ClassifyLogo.xx + 15, 15, SCREEN_WIDTH - 30 - 85, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
        self.ClassifyName.text = @"奔驰SUV 600";
        [self addSubview:self.ClassifyName];
        
        self.ClassiftType = [UILabel labelWithFrame:CGRectMake(self.ClassifyLogo.xx + 15, self.ClassifyName.yy +9, SCREEN_WIDTH - 30 - 85, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
        self.ClassiftType.text = @"中大型SUV";
        [self addSubview:self.ClassiftType];
        
        self.ClassifyPrice = [UILabel labelWithFrame:CGRectMake(self.ClassifyLogo.xx + 15, self.ClassiftType.yy +9, SCREEN_WIDTH - 30 - 85, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kHexColor(@"#028EFF")];
        self.ClassifyPrice.text = @"54.9-108万";
        [self addSubview:self.ClassifyPrice];
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(15, 109, SCREEN_WIDTH - 30, 1)];
        view.backgroundColor = kLineColor;
        [self addSubview:view];
    }
    return self;
}

-(void)setCarmodel:(CarModel *)carmodel{
    _carmodel = carmodel;
    [self.ClassifyLogo sd_setImageWithURL:[NSURL URLWithString:[carmodel.advPic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    self.ClassifyLogo.contentMode =UIViewContentModeScaleAspectFill;
    //超出容器范围的切除掉
    self.ClassifyLogo.clipsToBounds = YES;
    self.ClassifyName.text = carmodel.name;
//    self.ClassiftType.text = carmodel.remark;
    int level = [carmodel.level intValue];
    switch (level) {
        case 0:
            self.ClassiftType.text = @"SUV";
            break;
        case 1:
            self.ClassiftType.text = @"轿车";
            break;
        case 2:
            self.ClassiftType.text = @"MPV";
            break;
        case 3:
            self.ClassiftType.text = @"跑车";
            break;
        case 4:
            self.ClassiftType.text = @"皮卡";
            break;
        case 5:
            self.ClassiftType.text = @"房车";
            break;
            
        default:
            break;
    }
    self.ClassifyPrice.text = [NSString stringWithFormat:@"%.1f-%.1f万",[carmodel.lowest floatValue]/10000,[carmodel.highest floatValue]/10000];
}
@end
