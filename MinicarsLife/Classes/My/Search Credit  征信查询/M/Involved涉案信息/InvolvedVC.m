//
//  InvolvedVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "InvolvedVC.h"
#import "ClaimsTableView.h"

@interface InvolvedVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic ,copy) NSString *recordId;
@property (nonatomic ,copy)  NSString *n;
@end

@implementation InvolvedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"涉案信息";
    [self initTableView];
    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    
    
    NSLog(@"点击确认");
    [self sure];
    [self.view endEditing:YES];

}

- (void)sure
{
      [self.view endEditing:YES];
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份证号"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632921";
    
    http1.parameters[@"identityNo"] = textFid1.text;
    http1.parameters[@"name"] = textFid2.text;
    http1.parameters[@"customerName"] = [USERDEFAULTS objectForKey:NAME];

    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"][@"result"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
//        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        [TLAlert alertWithInfo:dic[@"msg"]];

       self.n = responseObject[@"data"][@"result"];

    } failure:^(NSError *error) {
        [TLAlert alertWithInfo:@"查询失败"];

    }];
}


//案例详情
- (void)recordIdDeatil
{
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632922";
    
    http1.parameters[@"bankCardNo"] = self.recordId;
    UITextField *textFid1 = [self.view viewWithTag:100];
    UITextField *textFid2 = [self.view viewWithTag:101];
    http1.parameters[@"identityNo"] = textFid1.text;
    http1.parameters[@"name"] = textFid2.text;

    [http1 postWithSuccess:^(id responseObject) {
        [TLAlert alertWithInfo:@"受理成功"];

        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        
    }];
    
}
- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
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
