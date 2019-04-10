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
    vc.seriesCode = self.CarModels[indexPath.row].code;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)GetClassifyByPrice{

    
    MJWeakSelf;
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    helper.code = @"630415";
    helper.parameters[@"priceStart"] =self.priceStart;
    helper.parameters[@"priceEnd"] =self.priceEnd;
    helper.parameters[@"brandCode"] = self.brandcode;
    helper.isList = NO;
    helper.isCurrency = YES;
    helper.tableView = self.tableview;
    [helper modelClass:[CarModel class]];
    [self.tableview addRefreshAction:^{
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            NSMutableArray <CarModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CarModel *model = (CarModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
//            weakSelf.model = shouldDisplayCoins;
            weakSelf.CarModels = shouldDisplayCoins;
            [weakSelf.tableview reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            NSLog(@" ==== %@",objs);
            NSMutableArray <CarModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CarModel *model = (CarModel *)obj;
                [shouldDisplayCoins addObject:model];
            }];
//            weakSelf.model = shouldDisplayCoins;
            weakSelf.CarModels = shouldDisplayCoins;
            [weakSelf.tableview reloadData_tl];
        } failure:^(NSError *error) {
        }];
    }];
    [self.tableview beginRefreshing];
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
