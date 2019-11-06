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
@property (nonatomic , strong)NSArray *newstagDataAry;
@end

@implementation CarNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"玩车资讯";
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"玩车资讯";
    titleLbl.font = Font(18);
    titleLbl.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLbl;
    [self.view addSubview:self.tableview];
    [self getnewsadta];
    // Do any additional setup after loading the view.
}

-(void)car_news_tag
{
    //标签数据字典
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"car_news_tag";
    
    [http postWithSuccess:^(id responseObject) {
        //        headview.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        //        [self modifyFrame];
        self.newstagDataAry = responseObject[@"data"];
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
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

-(void)getnewsadta{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630455";
    help.parameters[@"status"] = @"1";
    help.parameters[@"orderDir" ]=@"asc";
    [help modelClass:[NewsModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [weakSelf car_news_tag];
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
    cell.newstagDataAry = self.newstagDataAry;
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

@end
