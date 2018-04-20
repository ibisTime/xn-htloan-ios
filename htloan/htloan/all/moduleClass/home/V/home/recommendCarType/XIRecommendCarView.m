//
//  XIRecommendCarView.m
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XIRecommendCarView.h"

//Category 响应者链
#import "UIView+Responder.h"
//v
#import "XICarShowCollectionView.h"
//c
#import "calculatorVC.h"
@interface XIRecommendCarView()
//@property (nonatomic, strong) XIRecommendCarView *recommendCarView;
@end
@implementation XIRecommendCarView
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
    //推荐车型
    //image
    UIImageView * car = [[UIImageView alloc]initWithImage:kImage(@"推荐车型")];
    
    [self addSubview:car];
    [car mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(14);
        make.left.offset(15);
    }];
    //lable
    UILabel*carLable =[[UILabel alloc] init];
    carLable.text =@"推荐车型";
    carLable.font =[UIFont systemFontOfSize:(15)];
    [self addSubview:carLable];
    [carLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(car.mas_centerY);
        make.left.equalTo(car.mas_right).offset(10);
    }];



    
    
    //计算器
    self.calculatorForCar = [UIButton buttonWithTitle:@"车贷计算器"
                                  titleColor:kBlackColor
                             backgroundColor:kClearColor
                                   titleFont:15.0];
   
    [self.calculatorForCar addTarget:self action:@selector(clickCalculatorForCar:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.calculatorForCar];
    
    [self.calculatorForCar mas_makeConstraints:^(MASConstraintMaker *make) {
        
       make.centerY.equalTo(car.mas_centerY);
        make.right.offset(-15);
    }];
    
    
    
    //*****汽车展示********************
    //布局参数
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell的间距
    CGFloat cellW = (kScreenWidth-10)/3-2;
    CGFloat cellH = 125;
    flowLayout.itemSize = CGSizeMake(cellW, cellH);//size
    flowLayout.minimumLineSpacing =15;//行间距
    flowLayout.minimumInteritemSpacing = 1;//cell间距
//    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
//    flowLayout.sectionInset = UIEdgeInsetsMake(37, 5, 0, 5);//每一组间距
    
    XICarShowCollectionView * carShow = [[XICarShowCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
//    carShow.collectionViewLayout   = flowLayout;
    
    carShow.backgroundColor = [UIColor whiteColor];
    [self addSubview:carShow];
    [carShow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(37);
        make.left.offset(5);
         make.right.offset(-5);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    
    
    
}




-(void)clickCalculatorForCar:(UIButton *)sender
{
//    NSLog(@"车贷计算器");

    calculatorVC * calVC = [[calculatorVC alloc] init];

[self.viewController.navigationController pushViewController:calVC animated:YES];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
