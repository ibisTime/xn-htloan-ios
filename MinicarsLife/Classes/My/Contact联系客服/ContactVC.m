//
//  ContactVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/6.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ContactVC.h"

@interface ContactVC ()
@property (nonatomic ,strong) UILabel *phoneLabel;
@end

@implementation ContactVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"客服";
    self.view.backgroundColor = BackColor;
    [self CustomPageView];
    [self loadData];
}

- (void)loadData
{
    
    TLNetworking *http = [TLNetworking new];
    http.code = TheCalculatorURL;
    http.showView = self.view;
    http.parameters[@"limit"] = @"20";
    http.parameters[@"start"] = @"1";
    http.parameters[@"ckey"] = @"telephone";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        self.phoneLabel.text = responseObject[@"data"][@"list"][0][@"cvalue"];
    } failure:^(NSError *error) {
        
    }];
    
}
-(void)CustomPageView
{


    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 310)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];

    UILabel *nameLabel = [UILabel labelWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 20) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(15) textColor:TextColor];
    nameLabel.text = @"客服热线";
    [backView addSubview:nameLabel];

    UILabel *phoneLabel = [UILabel labelWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 30) textAligment:(NSTextAlignmentCenter) backgroundColor:kClearColor font:HGfont(30) textColor:MainColor];
//    phoneLabel.text = @"400-3888-666";
    [backView addSubview:phoneLabel];
    self.phoneLabel = phoneLabel;
    UIButton *button1 = [UIButton buttonWithTitle:@"呼叫" titleColor:[UIColor whiteColor] backgroundColor:MainColor titleFont:14];
    button1.frame = CGRectMake(SCREEN_WIDTH/2 - 130, 190, 110, 50);
    kViewRadius(button1, 5);
    [button1 addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    button1.tag = 100;
    [backView addSubview:button1];

    UIButton *button2 = [UIButton buttonWithTitle:@"取消" titleColor:MainColor backgroundColor:kClearColor titleFont:14];
    button2.frame = CGRectMake(SCREEN_WIDTH/2 +20, 190, 110, 50);
    kViewBorderRadius(button2, 5, 1, MainColor);
    [button2 addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    button2.tag = 101;
    [backView addSubview:button2];

}

-(void)buttonClick:(UIButton *)sender
{
    if(sender.tag == 100)
    {
        NSString *mobile = [NSString stringWithFormat:@"telprompt://%@",self.phoneLabel.text];
        NSURL *url = [NSURL URLWithString:mobile];
        [[UIApplication sharedApplication] openURL:url];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
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
