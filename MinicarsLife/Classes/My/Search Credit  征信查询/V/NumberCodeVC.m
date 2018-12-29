//
//  NumberCodeVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/12.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "NumberCodeVC.h"
#import "ClaimsTableView.h"

@interface NumberCodeVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;

@end

@implementation NumberCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"身份证认证";
    [self initTableView];

    // Do any additional setup after loading the view.
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
    if ([textFid1.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入身份证号"];
        return;
    }
    if ([textFid2.text isEqualToString:@""]) {
        [TLAlert alertWithInfo:@"请输入姓名"];
        return;
    }
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632920";
    
//    http1.showView = weakSelf.view;
//    http1.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
    http1.parameters[@"identityNo"] = textFid1.text;
    http1.parameters[@"name"] = textFid2.text;

}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
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
