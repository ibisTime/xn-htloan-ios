//
//  calculatorVC.m
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "calculatorVC.h"
//c
#import "XIMyApplyForVC.h"
//m
#import "CalculatorGounp.h"
//v
#import "CalculatorTableView.h"
#import "CalculatorHeaderView.h"

@interface calculatorVC ()
//m
@property (nonatomic, strong) CalculatorGounp *calGounp;
//v
@property (nonatomic, strong) CalculatorTableView *calculatorTableView;
@property (nonatomic, strong) CalculatorHeaderView *calculatorheaderV;

//butt
@property (nonatomic, strong) UIButton *applyForCar;

@end

@implementation calculatorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"车贷计算器";
    self.view.backgroundColor =kMineBackGroundColor;

    // Do any additional setup after loading the view.
    [self initTableView];
    //
    [self initGroup];
    
    //
    [self initApplyForCar];
    
}
#pragma mark - init


-(void)initApplyForCar{
    
    //
    self.applyForCar =   [UIButton buttonWithTitle:@"申请分期购车" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:5];
    [self.view addSubview:self.applyForCar];
    
    [self.applyForCar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-113);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.equalTo(@45);
        
    }];
    [self.applyForCar addTarget:self action:@selector(ApplyForCar) forControlEvents:UIControlEventTouchUpInside];
}
-(void)ApplyForCar
{
    XIMyApplyForVC * MyApplyForVC = [[XIMyApplyForVC alloc] init];
    
    [self.navigationController pushViewController:MyApplyForVC animated:YES];
    
    NSLog(@"申请分期购车");
}





- (void)initGroup {
    
    BaseWeakSelf;
    
    //
    CalculatorModel *brand = [CalculatorModel new];
    
    brand.text = @"品牌";
    brand.carText = @"奥迪";
    brand.action = ^{
       
        NSLog(@"品牌");
    };
    
    //
    CalculatorModel *type = [CalculatorModel new];
    
    type.text = @"型号";
    type.carText = @"2018款 30周年 Sport";
    type.action = ^{
        NSLog(@"型号");
    };
    //
    CalculatorModel *downPayment = [CalculatorModel new];
    
    downPayment.text = @"首付";
    downPayment.carText = @"30%";
    downPayment.action = ^{
        
     NSLog(@"首付");
    };
    //
    CalculatorModel *timeLimit = [CalculatorModel new];
    
    timeLimit.text = @"还款年限";
    timeLimit.carText = @"3";
    timeLimit.action = ^{
      NSLog(@"还款年限");
        
    };
    
    
    //传
    self.calGounp = [CalculatorGounp new];
    
    self.calGounp.sections = @[@[brand, type], @[downPayment,timeLimit]];
    
    self.calculatorTableView.calculatorGounp = self.calGounp;
    
    [self.calculatorTableView reloadData];
}


- (void)initTableView {
    //headerview背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,CalculatorHeardHeight)];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.image = kImage(@"车贷计算器背景");
    imageView.backgroundColor =kAppCustomMainColor;
    imageView.tag = 2000;
    //    imageView.backgroundColor = kAppCustomMainColor;
    
    [self.view addSubview:imageView];
    
    
    self.calculatorTableView = [[CalculatorTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 415) style:UITableViewStyleGrouped];
    self.calculatorTableView.backgroundColor = kClearColor;
    self.calculatorTableView.scrollEnabled = NO;
    [self.view addSubview:self.calculatorTableView];
    
    //
    //    self.headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    self.calculatorheaderV =[[CalculatorHeaderView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth ,164)];
//    self.calculatorheaderV.delegate = self;
    self.calculatorheaderV.backgroundColor = [UIColor clearColor];
    self.calculatorTableView.tableHeaderView = self.calculatorheaderV;
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
