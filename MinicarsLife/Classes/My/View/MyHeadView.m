//
//  MyHeadView.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/28.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView
{
    UILabel *numberLbl1;
    UILabel *numberLbl2;
    UILabel *numberLbl3;
    UIView *pointView;
}

-(UIImageView *)headImage
{
    if (!_headImage) {
        _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(17, kNavigationBarHeight + 18.5, 55, 55)];
        _headImage.layer.masksToBounds = YES;
        _headImage.layer.cornerRadius = 27.5;
        _headImage.image = HGImage(@"myheadimage");

        NSLog(@"%@",[[USERDEFAULTS objectForKey:PHOTO] convertImageUrl]);
    }
    return _headImage;
}

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(85 , kNavigationBarHeight + 22, SCREEN_WIDTH - 85 - 15, 24) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(18) textColor:[UIColor whiteColor]];
        
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (!_phoneLabel) {
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(85 , kNavigationBarHeight + 110 - 64, SCREEN_WIDTH - 110, 24)];
        _phoneLabel.font = HGfont(14);
        _phoneLabel.textColor = [UIColor whiteColor];
        
    }
    return _phoneLabel;
}



-(void)ButtonClick:(UIButton *)sender
{
    [_delegate MyHeadButton:sender.tag - 100];
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        _backImage = [[UIImageView alloc]initWithFrame:self.bounds];
        _backImage.image = HGImage(@"我的背景");
        [self addSubview:_backImage];

        [self addSubview:self.headImage];
        [self addSubview:self.nameLabel];
        [self addSubview:self.phoneLabel];

        NSArray *ary = @[@"我的消息",@"我的关注",@"我的申请"];
        for (int i = 0; i < 3; i ++) {
            UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
            backBtn.frame = CGRectMake(i % 3 * (SCREEN_WIDTH/3), _headImage.yy + 20, SCREEN_WIDTH/3, 42);
            backBtn.tag = i;
            [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
            [self addSubview:backBtn];
            
            UILabel *numberLbl = [UILabel labelWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/3, 25) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(18) textColor:kWhiteColor];
            if (i == 0) {
                numberLbl1 = numberLbl;
                
                pointView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3/2 + 15, _headImage.yy + 21, 6, 6)];
                pointView.backgroundColor = kHexColor(@"#FF4D4D");
                kViewBorderRadius(pointView, 3, 1, kWhiteColor);
                pointView.hidden = YES;
                [self addSubview:pointView];
                
            }
            if (i == 1) {
                numberLbl2 = numberLbl;
            }
            if (i == 2) {
                numberLbl3 = numberLbl;
            }
            [backBtn addSubview:numberLbl];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(0, 25, SCREEN_WIDTH/3, 16.5) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:Font(12) textColor:kWhiteColor];
            nameLbl.text = ary[i];
            [backBtn addSubview:nameLbl];
        }
 
        
        
    }
    return self;
}

-(void)setNumber:(NSInteger)number
{
    if (number == 0) {
        pointView.hidden = YES;
    }else
    {
        pointView.hidden = NO;
    }
}

-(void)setDataDic:(NSDictionary *)dataDic
{
    numberLbl1.text = [NSString stringWithFormat:@"%ld",[dataDic[@"newsCount"] integerValue]];
    numberLbl2.text = [NSString stringWithFormat:@"%ld",[dataDic[@"followCount"] integerValue]];
    numberLbl3.text = [NSString stringWithFormat:@"%ld",[dataDic[@"applyCount"] integerValue]];
}

-(void)backBtnClick:(UIButton *)sender
{
    [_delegate MyHeadButton:sender.tag];
}


@end
