//
//  StyleCarVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "StyleCarVC.h"
#import "CarModel.h"
#import "CalculatorVC.h"
@interface StyleCarVC ()<UITableViewDelegate,UITableViewDataSource,RefreshDelegate>
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;

@end

@implementation StyleCarVC

-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
                _tableview.delegate = self;
                _tableview.dataSource = self;
                _tableview.refreshDelegate = self;
    }
    return _tableview;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getClassify];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *rid=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    
    if(cell==nil){
        
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        cell.textLabel.text = self.CarModels[indexPath.row].name;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15, 54, SCREEN_WIDTH - 30, 1)];
        v1.backgroundColor = kLineColor;
        [cell addSubview:v1];
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    StyleCarVC * vc = [StyleCarVC new];
//    vc.seriesCode = self.CarModels[indexPath.row].code;
//    [self.navigationController pushViewController:vc animated:YES];
//    UINavigationController *navVC =self.navigationController;
//    NSMutableArray *viewControllers = [[NSMutableArray alloc]init];
//    for (UIViewController *vc in [navVC viewControllers]) {
//        [viewControllers addObject:vc];
//        if ([vc isKindOfClass:[RepairFourSVC class]]) {
//            break;
//        }
//    }
//    [navVC setViewControllers:viewControllers animated:YES];
    
    [self.navigationController popToViewController:[[CalculatorVC alloc]init]animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}
-(void)getClassify{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630425";
    [help modelClass:[CarModel class]];
    help.parameters[@"seriesCode"] = self.seriesCode;
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CarModels = objs;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview addLoadMoreAction:^{
        [help loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.CarModels = objs;
            [weakSelf.tableview reloadData];
            [weakSelf.tableview endRefreshFooter];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshFooter];
        }];
    }];
    [self.tableview beginRefreshing];
}

@end
