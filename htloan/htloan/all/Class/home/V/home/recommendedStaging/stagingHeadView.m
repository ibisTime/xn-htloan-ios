//
//  stagingHeadView.m
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "stagingHeadView.h"
@interface stagingHeadView ()

//更多
@property (nonatomic, strong) UIButton *moreStaging;


@end


@implementation stagingHeadView
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
    //推荐分期
    //image
    UIImageView * love = [[UIImageView alloc]initWithImage:kImage(@"推荐商品")];
    
    [self addSubview:love];
    [love mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(13);
        make.left.offset(15);
    }];
    //lable
    UILabel*stagingLable =[[UILabel alloc] init];
    stagingLable.text =@"推荐分期";
    stagingLable.font =[UIFont systemFontOfSize:(15)];
    [self addSubview:stagingLable];
    [stagingLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(love.mas_centerY);
        make.left.equalTo(love.mas_right).offset(10);
    }];
    
    
    
    
    
    
    //更多
//    self.moreStaging = [UIButton buttonWithTitle:@"更多"
//titleColor:kBlackColor backgroundColor:kClearColor titleFont:15.0];
    
    self.moreStaging =[UIButton buttonWithImageName:@"更多"];
    [self.moreStaging addTarget:self action:@selector(clickCalculatorForCar) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.moreStaging];
    
    [self.moreStaging mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(love.mas_centerY);
        make.right.offset(-15);
    }];
    
    
    
   
    
    
}




-(void)clickCalculatorForCar
{
    NSLog(@"推荐分期");
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
