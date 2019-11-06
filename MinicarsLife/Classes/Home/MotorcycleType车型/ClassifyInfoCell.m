//
//  ClassifyInfoCell.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyInfoCell.h"


@interface ClassifyInfoCell()


//@property (nonatomic ,strong)UIView *container;

@end

@implementation ClassifyInfoCell

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
        
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 110, 82.5)];
        [self addSubview:img];
        img.contentMode = UIViewContentModeScaleAspectFit;
        self.image = img;
        
        
        
        UILabel * title = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 15, SCREEN_WIDTH - 155, 30) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(14) textColor:kBlackColor];
        
        title.numberOfLines = 2;
        [self addSubview:title];
        self.titlelab = title;
        
        UILabel * describe = [UILabel labelWithFrame:CGRectMake(img.xx + 15, 60, SCREEN_WIDTH - 120, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        
        [self addSubview:describe];
        self.describdlab = describe;
        
        UILabel * time = [UILabel labelWithFrame:CGRectMake(img.xx + 15, describe.yy + 5, 74, 16.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor3];
        
        [self addSubview:time];
        self.timelab = time;
        
        
        UILabel * money = [UILabel labelWithFrame:CGRectMake(time.xx + 15, describe.yy + 5, SCREEN_WIDTH - 15 - 15 - time.xx, 22.5) textAligment:(NSTextAlignmentRight) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#F84444")];
        
        [self addSubview:money];
        self.moneylab = money;
        
        
        
//        self.tagsView =[[LXTagsView alloc]init];
//        self.tagsView.layer.borderWidth = 1;
//        self.tagsView.layer.borderColor = [UIColor redColor].CGColor;
//        [self.contentView addSubview:self.tagsView];
//
//        [self.tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self.contentView);
//            make.top.mas_equalTo(82.5 + 25);
//            make.bottom.mas_equalTo(-10);
//        }];
//        self.tagsView.tagClick = ^(NSString *tagTitle) {
//            NSLog(@"cell打印---%@",tagTitle);
//        };
        
        
//        UILabel * content = [UILabel labelWithFrame:CGRectMake(15, 82.5 + 25, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kTextColor2];
//        content.numberOfLines = 0;
//        [self addSubview:content];
//        self.contentlab = content;
        
        UIView * v1 = [[UIView alloc]init];
        v1.backgroundColor = kBackgroundColor;
        self.v1 = v1;
        [self addSubview:v1];
        
//        [v1 mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.right.bottom.equalTo(self.contentView);
//            make.height.mas_equalTo(10);
//        }];
        
    }
    return self;
}
-(void)setCarmodel:(CarModel *)carmodel{
    _carmodel = carmodel;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:[carmodel.pic convertImageUrl]] placeholderImage:kImage(@"default_pic")];
    

    self.titlelab.text = [NSString stringWithFormat:@"%@ %@ %@",carmodel.brandName,carmodel.seriesName,carmodel.name];
    self.titlelab.frame = CGRectMake(125 + 15, 15, SCREEN_WIDTH - 155, 30);
    [self.titlelab sizeToFit];
    
    self.timelab.text = [carmodel.updateDatetime convertToDetailDateWithoutHour];
    self.moneylab.text = [NSString stringWithFormat:@"%@", [USERXX AddSymbols:[carmodel.salePrice floatValue]/1000]];

    
    self.contentlab.text = @"";
//    self.contentlab.text = carmodel.Description;
    
    int level = [carmodel.level intValue];
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
    
    NSArray  *array = [carmodel.configName componentsSeparatedByString:@"  "];
//    self.tagsView.dataA = array;
//    [self.contentView layoutIfNeeded];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < array.count; i ++) {
        if (![array[i] isEqualToString:@""]) {
            [ary addObject:array[i]];
        }
    }
    
    
    
    if (ary.count > 0) {
        
        
        JKSmallLabels *jkSmallLabels = [[JKSmallLabels new]createSmallLabelGroupNames:ary withlabelFont:12 withlabelTextColor:kHexColor(@"#666666") withlabelBackgroundColor:kHexColor(@"#F0F0F0") withMaxWidth:SCREEN_WIDTH - 30 withInsideHorizontalSpace:10 withInsideVerticalSpace:6 withOuterHorizontalSpace:10 withOuterVerticalSpace:10];
        //    self.
        jkSmallLabels.x = 15;
        jkSmallLabels.y = 82.5 + 25;
        //    jkSmallLabels.backgroundColor = kHexColor(@"#F0F0F0");
        kViewRadius(jkSmallLabels, 12.5);
        jkSmallLabels.JKSmallLabelClick = ^(NSInteger tag)
        {
            NSLog(@"tag=%ld",(long)tag);
        };
        [self addSubview:jkSmallLabels];
        
        self.v1.frame = CGRectMake(15, jkSmallLabels.yy + 15, SCREEN_WIDTH - 30, 1);
    }else
    {
        self.v1.frame = CGRectMake(15, self.moneylab.yy + 15, SCREEN_WIDTH - 30, 1);
    }
//    self.contentlab.text = carmodel.configName;
//    self.contentlab.frame = CGRectMake(15, 82.5 + 25, SCREEN_WIDTH - 30, 0);
//    [self.contentlab sizeToFit];
    
    
}

-(void)setDataArray:(NSArray *)dataArray
{
  
}

@end
