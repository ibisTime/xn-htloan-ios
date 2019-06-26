//
//  ChangeBrandVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/6/26.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ChangeBrandVC.h"
#import "ChangeBrandTableView.h"
#import "CarModel.h"
@interface ChangeBrandVC ()<UITableViewDelegate>
@property (nonatomic,strong) ChangeBrandTableView * tableView;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;
@end

@implementation ChangeBrandVC
-(ChangeBrandTableView *)tableView{
    if (!_tableView) {
        _tableView = [[ChangeBrandTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"品牌列表";
    [self.view addSubview:self.tableView];
    [self loaddata];
    
}

-(void)loaddata{
    MJWeakSelf;
    TLPageDataHelper * help = [TLPageDataHelper new];
    help.code = @"630485";
    help.tableView = self.tableView;
    help.showView = self.view;
    help.isCurrency = YES;
    [help modelClass:[CarModel class]];
    [self.tableView addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CarModels = objs;
            weakSelf.tableView.CarModels = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CarModels = objs;
            weakSelf.tableView.CarModels = objs;
            [weakSelf.tableView reloadData];
            [weakSelf.tableView endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshFooter];
        }];
    }];
    
    [self.tableView beginRefreshing];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
