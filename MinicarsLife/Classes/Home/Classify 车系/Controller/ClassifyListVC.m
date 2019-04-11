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
    
    self.title = @"车系列表";
    [self getClassifyListData];
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
//    vc.seriesCode = self.CarModels[indexPath.row].code;
    vc.models = self.CarModels[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)GetClassifyByPrice{

    if (self.CarModels.count > 0 || [_state isEqualToString:@"1"]) {
        return;
    }
    MJWeakSelf;

    if (self.brandcode) {
        [self.tableview addRefreshAction:^{
            
            TLNetworking * http2 = [[TLNetworking alloc]init];
            http2.showView = weakSelf.view;
            http2.code = @"630416";
            http2.parameters[@"priceStart"] =@([self.priceStart floatValue]*1000);
            http2.parameters[@"priceEnd"] =@([self.priceEnd floatValue]*1000);
            http2.parameters[@"brandCode"] = weakSelf.brandcode;
//            http2.parameters[@"isMore"] = weakSelf.isMore;
            [http2 postWithSuccess:^(id responseObject) {
                //                    weakSelf.model = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                weakSelf.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [weakSelf.tableview reloadData_tl];
                [weakSelf.tableview endRefreshHeader];
            } failure:^(NSError *error) {
                [weakSelf.tableview endRefreshHeader];
            }];
        }];
        
        [self.tableview beginRefreshing];
    }else
    {
        [self.tableview addRefreshAction:^{
            
            TLNetworking * http2 = [[TLNetworking alloc]init];
            http2.showView = weakSelf.view;
            http2.code = @"630426";
            http2.parameters[@"priceStart"] =@([self.priceStart floatValue]*1000);
            http2.parameters[@"priceEnd"] =@([self.priceEnd floatValue]*1000);
            http2.parameters[@"brandCode"] = weakSelf.brandcode;
            http2.parameters[@"isMore"] = weakSelf.isMore;
            [http2 postWithSuccess:^(id responseObject) {
                //                    weakSelf.model = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                weakSelf.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [weakSelf.tableview reloadData_tl];
                [weakSelf.tableview endRefreshHeader];
            } failure:^(NSError *error) {
                [weakSelf.tableview endRefreshHeader];
            }];
        }];
        
        [self.tableview beginRefreshing];
    }
    
    
    
}


-(void)getClassifyListData{
//    if (self.brandcode) {
//        TLNetworking * http2 = [[TLNetworking alloc]init];
//        http2.showView = self.view;
//        http2.code = @"630416";
//        http2.parameters[@"status"] = @"1";
//        http2.parameters[@"brandCode"] = self.brandcode;
//        [http2 postWithSuccess:^(id responseObject) {
//            self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            [self.tableview reloadData_tl];
//            [self.tableview endRefreshHeader];
//        } failure:^(NSError *error) {
//            [self.tableview endRefreshHeader];
//        }];
//    }else
//        [self.tableview endRefreshHeader];
    
}

@end
