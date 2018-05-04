//
//  XIMyApplyForVC.m
//  htloan
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XIMyApplyForVC.h"
#import "XIMyApplyForTableView.h"
@interface XIMyApplyForVC ()<RefreshDelegate>
//tableview
@property (nonatomic, strong) XIMyApplyForTableView*tableView;

@property (nonatomic, strong) NSArray <XIMyApplyForModel *>*myAppNubs;
@end

@implementation XIMyApplyForVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的车贷申请";
    // Do any additional setup after loading the view.
    
    [self initTableView];
    //获取申请列表
        
    
    [self requestMyApplyForList];
   
    [self.tableView beginRefreshing];
}
#pragma mark - Init
- (void)initTableView {
    
    self.tableView = [[XIMyApplyForTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    
    self.tableView.refreshDelegate = self;
    
    TLPlaceholderView * place = [TLPlaceholderView placeholderViewWithImage:@"" text:@"暂无申请"];
    
        self.tableView.placeHolderView = place ;
    
    [self.view addSubview:self.tableView];
    //frame
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
    }];
}


#pragma mark - Data

/**
 获取申请列表
 */
- (void)requestMyApplyForList {
    
    BaseWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
   #pragma mark - 未完成
    helper.code = @"630437";
    
//    helper.parameters[@"userId"] = [TLUser user].userId;

    helper.parameters[@"code"] = self.code;

    helper.tableView = self.tableView;
    
    [helper modelClass:[XIMyApplyForModel class]];
    
    [self.tableView addRefreshAction:^{
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            weakSelf.myAppNubs = objs;
            
            weakSelf.tableView.myAppNubs = objs;
            
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
//           NSLog([error.userInfo objectForKey:NSLocalizedDescriptionKey]) ;
            
        }];
    }];
    
    [self.tableView addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            
            weakSelf.myAppNubs = objs;
            
            weakSelf.tableView.myAppNubs = objs;
            
            [weakSelf.tableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
        }];
    }];
    
    [self.tableView endRefreshingWithNoMoreData_tl];
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
