//
//  CarNewsVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarNewsVC.h"
#import "NewsCell.h"
#import "NewsInfoVC.h"
#import "NewsModel.h"
@interface CarNewsVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSMutableArray<NewsModel *> * NewsModels;
@end

@implementation CarNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微车资讯";
    [self.view addSubview:self.tableview];
    [self getnewsadta];
    // Do any additional setup after loading the view.
}

-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableview;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.NewsModels.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.NewsModels[indexPath.row];

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 105;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsInfoVC * vc = [NewsInfoVC new];
    vc.code = self.NewsModels[indexPath.row].code;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)getnewsadta{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630455";
    help.parameters[@"status"] = @"1";
    [help modelClass:[NewsModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.NewsModels = objs;
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.NewsModels = objs;
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    [self.tableview beginRefreshing];
}
@end
