//
//  BankCodeVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "BankCodeVC.h"
#import "ClaimsTableView.h"

@interface BankCodeVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;

@end

@implementation BankCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡认证";
    [self initTableView];
    
    // Do any additional setup after loading the view.
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    
    NSLog(@"点击确认");
    [self sure];
    [self.view endEditing:YES];

}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    UITextField *textFid3 = [self.view viewWithTag:102];
    UITextField *textFid4 = [self.view viewWithTag:103];

    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入银行卡号"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份证号"];
        return;
    }
    if ([textFid3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }if ([textFid4.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632923";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http1.parameters[@"customerName"] = [USERDEFAULTS objectForKey:NAME];

    http1.parameters[@"bankCardNo"] = textFid1.text;
    http1.parameters[@"mobileNo"] = textFid3.text;

    http1.parameters[@"identityNo"] = textFid2.text;
    http1.parameters[@"name"] = textFid4.text;
    
    
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"][@"result"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"code"] isEqualToString:@"1013"] || [dic[@"code"] isEqualToString:@"1016"]) {
            [TLAlert alertWithInfo:dic[@"msg"]];
            return ;
        }else
        {
            
            if ([dic[@"data"][@"resultMsg"] isEqualToString:@"一致"]) {
                [TLAlert alertWithInfo:dic[@"msg"]];
                [NSThread sleepForTimeInterval:1.0];
                [self.navigationController popViewControllerAnimated:YES];

                
            }else{
                [TLAlert alertWithInfo:@"信息不匹配"];
                
            }
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.isBank = YES;
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
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
