//
//  CarTextV.m
//  htloan
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "CarTextV.h"
@interface CarTextV ()

@property (nonatomic, strong) UILabel *carModelName;
@property (nonatomic, strong) UILabel *carOriginalPrice;
@property (nonatomic, strong) UILabel *sloganText;
@end

@implementation CarTextV
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        [self initSubviews];
    }
    return self;
}
#pragma mark - Init
- (void)initSubviews {
    //
    //lable1
    self.carModelName =[[UILabel alloc] init];
    self.carModelName.font =[UIFont systemFontOfSize:(18)];
    self.carModelName.textColor = kHexColor(@"#333333");
    [self addSubview:self.carModelName];
    [self.carModelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kPublictextMargin);
        make.top.offset(18);
        
    }];
    
    
    //lable2
    self.carOriginalPrice =[[UILabel alloc] init];
    self.carOriginalPrice.font =[UIFont systemFontOfSize:(18)];
    self.carOriginalPrice.textColor = kHexColor(@"#fc7d41");
    [self addSubview:self.carOriginalPrice];
    [self.carOriginalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.offset(kPublictextMargin);
        make.top.equalTo(self.carModelName.mas_bottom).offset(18);
        
    }];
    //lable
    self.sloganText =[[UILabel alloc] init];
    self.sloganText.font =[UIFont systemFontOfSize:(13)];
    self.sloganText.textColor = kHexColor(@"#999999");
    [self addSubview:self.sloganText];
    [self.sloganText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(kPublictextMargin);
        make.top.equalTo(self.carOriginalPrice.mas_bottom).offset(18);
        
    }];
     
}


-(void)setCarText:(carImgModel *)carText
{    _carText = carText;
    
    self.carModelName.text =  carText.name;
    self.carOriginalPrice.text =[NSString stringWithFormat:@"¥%@万", carText.originalPrice];
    self.sloganText.text = carText.slogan;
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
