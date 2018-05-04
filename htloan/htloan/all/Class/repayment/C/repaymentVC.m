//
//  repaymentVC.m
//  htloan
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "repaymentVC.h"
//m
#import "repaymentModel.h"
//V
#import "repaymentListV.h"
@interface repaymentVC ()
//
@property (nonatomic, strong) repaymentListV *repaymentListTableView;
//news
@property (nonatomic, strong) NSArray <repaymentModel *>*news;
//
@property (nonatomic, strong) TLPageDataHelper *flashHelper;

@end

@implementation repaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加通知
    [self addNotification];
    
    
        //
        [self initFlashTableView];
        //获取
        [self requestFlashList];
        //刷新
    
        [self.repaymentListTableView beginRefreshing];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DidLoadHomeVC"
                                                            object:nil];
        
    
}

#pragma mark - Init
- (void)addNotification {
    //用户登录刷新首页快讯
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRepaymentListTableView) name:kUserLoginNotification object:nil];
    //用户退出登录刷新首页快讯
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshRepaymentListTableView) name:kUserLoginOutNotification object:nil];
    //收到推送刷新首页快讯
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshRepaymentListTableView)
                                                 name:@"DidReceivePushNotification"
                                               object:nil];
}

- (void)refreshRepaymentListTableView {
    
    //
    [self.repaymentListTableView beginRefreshing];
}
//
- (void)initFlashTableView {
    
    self.repaymentListTableView = [[repaymentListV alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //是否最近还款
    self.repaymentListTableView.isNewRepayment = [self.status isEqualToString:kNewRepayment];
    
//    self.repaymentListTableView.refreshDelegate = self;
    
    self.repaymentListTableView.placeHolderView = [TLPlaceholderView placeholderViewWithImage:@"" text:@"暂无还款"];
    
    [self.view addSubview:self.repaymentListTableView];
    [self.repaymentListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_equalTo(0);
    }];
}


#pragma mark - Data
- (void)requestFlashList {
    
    BaseWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.code = @"628097";
    
    helper.parameters[@"type"] = self.status;
    
    helper.tableView = self.repaymentListTableView;
    
    self.flashHelper = helper;
    
    [helper modelClass:[repaymentModel class]];
    
    [self.repaymentListTableView addRefreshAction:^{
        //
        if ([TLUser user].isLogin) {
            
            helper.parameters[@"userId"] = [TLUser user].userId;
        } else {
            
            helper.parameters[@"userId"] = @"";
        }
        //
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            weakSelf.news = objs;
            
            weakSelf.repaymentListTableView.news = objs;
            NSLog(@"....???%@",weakSelf.repaymentListTableView.news);
            
            [weakSelf.repaymentListTableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
        }];
    }];
    // 拉加载更多
    [self.repaymentListTableView  addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            //中转
            weakSelf.news = objs;
            
            weakSelf.repaymentListTableView.news = objs;
            [weakSelf.repaymentListTableView reloadData_tl];
            
        } failure:^(NSError *error) {
            
        }];
        
    }];
    
    [self.repaymentListTableView endRefreshingWithNoMoreData_tl];
}
//






- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
