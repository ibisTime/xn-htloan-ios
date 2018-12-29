//
//  MobleInfomationVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MobleInfomationVC.h"
#import "ClaimsTableView.h"
#import "MoblePhoneCodeVC.h"
#import "MoblieCodeVC.h"
@interface MobleInfomationVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic ,copy) NSString *code;

@end

@implementation MobleInfomationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"运营商报告采集";
    [self initTableView];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    NSLog(@"点击确认");
    [self sure];
    [self.view endEditing:YES];

}


-(void)viewWillDisappear:(BOOL)animated
{
    self.code = nil;
    [super viewWillDisappear:animated];
    
}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    UITextField *textFid3 = [self.view viewWithTag:102];
    UITextField *textFid4 = [self.view viewWithTag:103];
    UITextField *textFid5 = [self.view viewWithTag:104];
    UITextField *textFid6 = [self.view viewWithTag:105];
    UITextField *textFid7 = [self.view viewWithTag:106];
    UITextField *textFid8 = [self.view viewWithTag:107];
    UITextField *textFid9 = [self.view viewWithTag:108];
    UITextField *textFid10 = [self.view viewWithTag:109];
    UITextField *textFid11 = [self.view viewWithTag:110];
    UITextField *textFid12 = [self.view viewWithTag:111];
    UITextField *textFid13 = [self.view viewWithTag:112];
    UITextField *textFid14 = [self.view viewWithTag:113];
    UITextField *textFid15 = [self.view viewWithTag:114];
    UITextField *textFid16 = [self.view viewWithTag:115];
    UITextField *textFid17 = [self.view viewWithTag:116];
    UITextField *textFid18 = [self.view viewWithTag:117];
    UITextField *textFid19 = [self.view viewWithTag:118];
    UITextField *textFid20 = [self.view viewWithTag:119];
//    UITextField *textFid21 = [self.view viewWithTag:120];
//    UITextField *textFid22 = [self.view viewWithTag:121];

//    if ([textFid1.text isEqualToString:@""]) {
//        [TLAlert alertWithInfo:@"请输入银行卡号"];
//        return;
//    }
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份账号"];
        return;
    }   if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }   if ([textFid3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机号"];
        return;
    }   if ([textFid4.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入手机服务密码"];
        return;
    }
    
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632934";
    
//    http1.parameters[@"bankcard"] = textFid1.text;
    http1.parameters[@"identityCardNo"] = textFid1.text;
    http1.parameters[@"identityName"] = textFid2.text;
    http1.parameters[@"username"] = textFid3.text;
    http1.parameters[@"password"] = textFid4.text;
    http1.parameters[@"contactIdentityNo1st"] = textFid6.text;
    http1.parameters[@"contactMobile1st"] = textFid7.text;
    http1.parameters[@"contactName1st"] = textFid8.text;
    http1.parameters[@"contactRelationship1st"] = textFid9.text;

    http1.parameters[@"contactIdentityNo2st"] = textFid11.text;
    http1.parameters[@"contactMobile2st"] = textFid12.text;
    http1.parameters[@"contactName2st"] = textFid13.text;
    http1.parameters[@"contactRelationship2st"] = textFid14.text;
    
    http1.parameters[@"contactIdentityNo2st"] = textFid16.text;
    http1.parameters[@"contactMobile2st"] = textFid17.text;
    http1.parameters[@"contactName2st"] = textFid18.text;
    http1.parameters[@"contactRelationship2st"] = textFid19.text;
//    http1.parameters[@"otherInfo"] = textFid21.text;

    MJWeakSelf;
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"][@"result"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        if ([dic[@"code"] isEqualToString:@"1016"]) {
            [TLAlert alertWithError:dic[@"msg"]];
            return ;
        }
        self.code = dic[@"token"];
        [self requestCode];
       
    } failure:^(NSError *error) {
        
    }];

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)requestCode
{
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632935";
    [TLAlert alertWithMsg:@"正在获取验证码"];
    http1.parameters[@"tokendb"] = self.code;
    MJWeakSelf;
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        MoblieCodeVC *vc = [MoblieCodeVC new];
        vc.code = dic[@"token"];
        vc.isMb = YES;
        [weakSelf.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
  
}
- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.isMobleInformation = YES;
    MJWeakSelf;
    self.tableView.ScrolleWBlock = ^{
        [weakSelf.view endEditing:YES];
    };
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}




@end
