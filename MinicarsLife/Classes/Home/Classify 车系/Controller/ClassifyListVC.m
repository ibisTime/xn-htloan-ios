//
//  ClassifyListVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "ClassifyListVC.h"
#import "ClassifyCell.h"
#import "ClassifyInfoVC.h"
@interface ClassifyListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) TLTableView * tableview;
@end

@implementation ClassifyListVC
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerClass:[ClassifyCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableview;
}

-(void)GetClassifyByPrice{
    
    MJWeakSelf;
    TLPageDataHelper * http2 = [TLPageDataHelper new];
    http2.showView = weakSelf.view;
    http2.code = @"630491";
    http2.parameters[@"priceStart"] =[NSString stringWithFormat:@"%.0f",[self.priceStart floatValue]*1000];
    http2.parameters[@"priceEnd"] =[NSString stringWithFormat:@"%.0f",[self.priceEnd floatValue]*1000];
    http2.parameters[@"brandCode"] = weakSelf.brandcode;
    http2.parameters[@"name"] = self.queryName;
    http2.parameters[@"isMore"] = weakSelf.isMore;
    http2.parameters[@"status"] = @"1";
//    http2.parameters[@"type"] = @"2";
    http2.tableView = self.tableview;
    [http2 modelClass:[CarModel class]];
    http2.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [http2 refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:objs];
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        [http2 loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:objs];
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    
    [self.tableview beginRefreshing];
    //    }
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"车系列表";
//    车系
    [self GetClassifyByPrice];
    [self.view addSubview:self.tableview];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.CarModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    ClassifyCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[ClassifyCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
    cell.carmodel = [CarModel mj_objectWithKeyValues:self.CarModels[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ClassifyInfoVC * vc = [ClassifyInfoVC new];
    vc.title = self.CarModels[indexPath.row].name;
    vc.models = self.CarModels[indexPath.row];
    vc.priceEnd = self.priceEnd;
    vc.priceStart = self.priceStart;
    vc.queryName = self.queryName;
    [self.navigationController pushViewController:vc animated:YES];
}




-(void)getClassifyListData{
    
}

@end
