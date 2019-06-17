//
//  SheBaoVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "SheBaoVC.h"
#import "ClaimsTableView.h"
#import "WSDatePickerView.h"
#import "BaoModel.h"
@interface SheBaoVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic, strong) NSMutableArray <BaoModel *>*baoModels;

@end

@implementation SheBaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡认证";
    [self initTableView];
    [self reauestList];
    // Do any additional setup after loading the view.
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
    }
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    
    NSLog(@"点击确认");
    [self sure];
}

- (void)sure
{
    UITextField *textFid1 = [self.view viewWithTag:101];
    UITextField *textFid2 = [self.view viewWithTag:102];
    UITextField *textFid3 = [self.view viewWithTag:103];
    UITextField *textFid4 = [self.view viewWithTag:104];
    UITextField *textFid5 = [self.view viewWithTag:105];
    UITextField *textFid6 = [self.view viewWithTag:106];

    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请选取地址"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入地址"];
        return;
    }
    if ([textFid3.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入账号"];
        return;
    }
    if ([textFid4.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入密码"];
        return;
    }
    if ([textFid5.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"真实姓名"];
        return;
    }
    if ([textFid6.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"其他信息"];
        return;
    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632923";
    
    //    http1.showView = weakSelf.view;
    //    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    
    http1.parameters[@"bankCardNo"] = textFid1.text;
    http1.parameters[@"mobileNo"] = textFid3.text;
    
    http1.parameters[@"identityNo"] = textFid2.text;
    http1.parameters[@"name"] = textFid4.text;
    
}

- (void)reauestList
{
 
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632925";
    [http1 postWithSuccess:^(id responseObject) {
        self.baoModels = [BaoModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSLog(@"%@",self.baoModels);
    } failure:^(NSError *error) {
        
    }];
}
   

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.isShe = YES;
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
    MJWeakSelf;
    self.tableView.ChooseBlock = ^{
        [weakSelf chooseShow];
    };
}
- (void)chooseShow {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowYearMonthDayHourMinute CompleteBlock:^(NSDate *selectDate) {
        
        [self.tableView reloadData];
        
    }];
    datepicker.dateLabelColor = MainColor;//年-月-日-时-分 颜色
    datepicker.datePickerColor = [UIColor blackColor];//滚轮日期颜色
    datepicker.doneButtonColor = MainColor;//确定按钮的颜色
    [datepicker show];
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
