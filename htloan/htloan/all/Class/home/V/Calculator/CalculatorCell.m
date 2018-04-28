//
//  CalculatorCell.m
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "CalculatorCell.h"




#import "TLUIHeader.h"
#import "AppColorMacro.h"

#import "UILabel+Extension.h"

@interface CalculatorCell ()


@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel * carLbl;


@property (nonatomic, strong) UIImageView *rightArrowIV;

@end

@implementation CalculatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
        
    }
    return self;
    
}

#pragma mark - Init
- (void)initSubviews {
    //
    self.titleLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
    [self.contentView addSubview:self.titleLbl];
    //
    self.carLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kTextColor font:15.0];
    [self.contentView addSubview:self.carLbl];
    
    //右边箭头
    self.rightArrowIV = [[UIImageView alloc] init];
    self.rightArrowIV.image = [UIImage imageNamed:@"更多"];
    [self.contentView addSubview:self.rightArrowIV];
    
    //
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = kLineColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(@(kLineHeight));
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (void)setSubviewLayout {
   
    //
    [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.top.offset(18);
        
    }];
    
    //
    [self.carLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.offset(85);
        make.centerY.equalTo(self.titleLbl.mas_centerY);
    }];
    
    //右箭头
    [self.rightArrowIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@7);
        make.height.equalTo(@12);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        
    }];
   
            
   
}


//shuju
- (void)setCalculatorModel:(CalculatorModel *)calculatorModel {
    
    _calculatorModel = calculatorModel;
    
   
    
    self.titleLbl.text = calculatorModel.text;
    
    self.carLbl.text = calculatorModel.carText;
    //布局
    [self setSubviewLayout];
    

}





- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
