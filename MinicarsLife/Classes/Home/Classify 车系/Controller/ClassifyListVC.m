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


- (void)viewDidLoad {
    [super viewDidLoad];
    [self GetClassifyByPrice];
    MinicarsLifeWeakSelf;
    self.title = @"车系列表";
    [self.tableview addRefreshAction:^{
        [weakSelf getClassifyListData];
        [weakSelf GetClassifyByPrice];
        }];
    [self.tableview beginRefreshing];
    
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
//    [self getClassifyData:self.CarModels[indexPath.row].code];
//    [self getClassifyData:self.CarModels[indexPath.row].code withtitle:self.CarModels[indexPath.row].name];
    ClassifyInfoVC * vc = [ClassifyInfoVC new];
    vc.title = self.CarModels[indexPath.row].name;
    vc.seriesCode = self.CarModels[indexPath.row].code;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)GetClassifyByPrice{
    if (self.priceStart||self.priceEnd) {
        TLNetworking * http2 = [[TLNetworking alloc]init];
        http2.showView = self.view;
        http2.code = @"630426";
        http2.parameters[@"priceStart"] =self.priceStart;
        http2.parameters[@"priceEnd"] =self.priceEnd;
        
        [http2 postWithSuccess:^(id responseObject) {
            self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableview reloadData_tl];
            [self.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [self.tableview endRefreshHeader];
        }];
    }
    else{
        [self.tableview endRefreshHeader];
    }
}
-(void)getClassifyListData{
    if (self.brandcode) {
        TLNetworking * http2 = [[TLNetworking alloc]init];
        http2.showView = self.view;
        http2.code = @"630416";
        
        http2.parameters[@"brandCode"] = self.brandcode;
        [http2 postWithSuccess:^(id responseObject) {
            self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableview reloadData_tl];
            [self.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [self.tableview endRefreshHeader];
        }];
    }else
        [self.tableview endRefreshHeader];
    
}
@end
