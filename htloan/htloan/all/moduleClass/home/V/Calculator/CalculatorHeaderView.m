//
//  CalculatorHeaderView.m
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "CalculatorHeaderView.h"


//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
//M
#import "TLUser.h"
@interface CalculatorHeaderView()

@property (nonatomic, strong) UILabel *totalPrice;

@property (nonatomic, strong) UILabel *payment;

@property (nonatomic, strong) UILabel *monthlyPayment;

@property (nonatomic, strong) UILabel *morePayment;

@property (nonatomic, strong) UILabel * totalPriceNub;
@property (nonatomic, strong) UILabel *paymentNub;
@property (nonatomic, strong) UILabel *monthlyPaymentNub;
@property (nonatomic, strong) UILabel *morePaymentNub;

@end

@implementation CalculatorHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.backgroundColor = kClearColor;

        [self initSubviews];
    }
    return self;
}

#pragma mark - Init
- (void)initSubviews {
   //1
self.totalPrice = [UILabel labelWithTitle:@"总价  (元)" BackgroundColor:kClearColor textColor:kWhiteColor font:14];
     [self addSubview:self.totalPrice];
    
    [self.totalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(14);
        make.left.offset(20);
    }];
    //2
    self.totalPriceNub = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:38];
    [self addSubview:self.totalPriceNub];
    
    [self.totalPriceNub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.totalPrice.mas_bottom).offset(18);
        make.left.offset(20);
    }];
    //3
    self.payment = [UILabel labelWithTitle:@"首付(元)" BackgroundColor:kClearColor textColor:kWhiteColor font:14];
    [self addSubview:self.payment];
    
    [self.payment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-43);
        make.left.offset(15);
    }];

    //4
    self.paymentNub = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:17];
    [self addSubview:self.paymentNub];
    
    [self.paymentNub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.left.offset(15);
    }];

        //5
    self.monthlyPayment = [UILabel labelWithTitle:@"月供(元)" BackgroundColor:kClearColor textColor:kWhiteColor font:14];
    [self addSubview:self.monthlyPayment];
    
    [self.monthlyPayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.offset(-43);
    }];

    //6
    self.monthlyPaymentNub = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:17];
    [self addSubview:self.monthlyPaymentNub];
    
    [self.monthlyPaymentNub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.offset(-15);
    }];
    //7
    self.morePayment = [UILabel labelWithTitle:@"多花(元)" BackgroundColor:kClearColor textColor:kWhiteColor font:14];
    [self addSubview:self.morePayment];
    
    [self.morePayment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.monthlyPayment.mas_right).offset(77);
        make.bottom.offset(-43);
    }];

    //
    self.morePaymentNub = [UILabel labelWithBackgroundColor:kClearColor textColor:kWhiteColor font:38];
    [self addSubview:self.morePaymentNub];
    
    [self.morePaymentNub mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.monthlyPaymentNub.mas_right).offset(77);
        make.bottom.offset(-15);
    }];

    //
    

    
}


#pragma mark - sourse
-(void)setCalculatorModel:(CalculatorModel *)calculatorModel
{
    _calculatorModel = calculatorModel;
    self.paymentNub.text  = calculatorModel.paymentNub;
    self.morePaymentNub.text = calculatorModel.morePaymentNub;
    self.monthlyPaymentNub.text = calculatorModel.monthlyPaymentNub;
    self.totalPriceNub.text = calculatorModel.totalPriceNub;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
