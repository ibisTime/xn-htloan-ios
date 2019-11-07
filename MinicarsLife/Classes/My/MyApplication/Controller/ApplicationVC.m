//
//  ApplicationVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/6.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ApplicationVC.h"
#import "ApplicationTableView.h"
#import "CarModel.h"
@interface ApplicationVC ()<RefreshDelegate>

@property (nonatomic , strong)ApplicationTableView *tableView;
@property (nonatomic , strong)NSMutableArray <CarModel *>*models;
@end

@implementation ApplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"优质商家";
    
    self.tableView = [[ApplicationTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight - 50) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kHexColor(@"#FAFAFA");
    self.tableView.defaultNoDataText = @"暂无申请";
    self.tableView.defaultNoDataImage = kImage(@"暂无订单");
    [self.view addSubview:self.tableView];
    [self LoadData];
}


-(void)LoadData
{
    __weak typeof(self) weakSelf = self;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.tableView = self.tableView;
    //    self.helper = helper;
    helper.code = @"630435";
    helper.parameters[@"type"] = self.type;
    helper.parameters[@"userId"] = [USERDEFAULTS  objectForKey:USER_ID];
//    helper.parameters[@"location"]= @"0";
    helper.start = 1;
    helper.limit = 10;
    [helper modelClass:[CarModel class]];
    [self.tableView addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.models = objs;
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView beginRefreshing];
    [self.tableView addLoadMoreAction:^{
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.models = objs;
            weakSelf.tableView.models = objs;
            [weakSelf.tableView reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableView endRefreshingWithNoMoreData_tl];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
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
