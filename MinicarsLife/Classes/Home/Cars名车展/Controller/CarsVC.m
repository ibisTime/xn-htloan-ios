//
//  CarsVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/4.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "CarsVC.h"
#import "CarsTableView.h"
#import "CarsHeadView.h"
#import "CarModel.h"
#import "HomeModel.h"
#import "CarInfoVC.h"
#import "ClassifyListVC.h"
#import "BrandListVC.h"
#import "ClassifyInfoVC.h"
@interface CarsVC ()<RefreshDelegate>

@property (nonatomic , strong)CarsHeadView *headView;

@property (nonatomic , strong)CarsTableView *tableView;

@property (nonatomic , strong)NSMutableArray <CarModel *>*carsModels;
@property (nonatomic , strong)NSMutableArray <CarModel *>*HotCarBrands;

@property (nonatomic , strong)NSMutableArray *allArray;

@end

@implementation CarsVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"名车展";
    
    self.tableView = [[CarsTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kNavigationBarHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    self.tableView.backgroundColor = kHexColor(@"#F5F5F5");
    [self.view addSubview:self.tableView];
    
    CarsHeadView *headView = [[CarsHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH - 30)/345*200 + 15)];
    self.tableView.tableHeaderView = headView;
    
    [self PopularModels];
    [self PopularBrandLoadData];
    [self brandLoadData];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= 2) {
        NSMutableArray<CarModel *> * array = [CarModel mj_objectArrayWithKeyValuesArray:self.allArray[indexPath.section - 2]];
        //    CarModel * model = [CarModel mj_objectArrayWithKeyValuesArray:array[indexPath.row]];
        CarModel * model = [CarModel mj_objectWithKeyValues:array[indexPath.row]];
        //    [self getClassifyListData:model.code];
        ClassifyListVC * vc = [ClassifyListVC new];
        vc.brandcode = model.code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    if ([state isEqualToString:@"all"]) {
        if (index == 0) {
            ClassifyInfoVC *vc = [ClassifyInfoVC new];
            vc.title = @"全部车型";
            [self.navigationController pushViewController:vc animated:YES];
        }else
        {
            BrandListVC * vc = [[BrandListVC alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if ([state isEqualToString:@"精选车源"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630427";
        http.showView = self.view;
        http.parameters[@"code"] = self.carsModels[index].code;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            CarInfoVC * vc = [CarInfoVC new];
            vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            
        }];

    }
    if ([state isEqualToString:@"热门品牌"]) {
        ClassifyListVC * vc = [ClassifyListVC new];
        vc.brandcode = self.HotCarBrands[index].code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//热门车型
-(void)PopularModels
{
    
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.code = @"630492";
    http2.parameters[@"location"] = @"0";
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"start"] = @"0";
    http2.parameters[@"limit"] = @"100";
    http2.parameters[@"orderDir"] = @"asc";
    [http2 postWithSuccess:^(id responseObject) {
        self.carsModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.tableView.carsModels = self.carsModels;
        [self.tableView reloadData];

    } failure:^(NSError *error) {
        
    }];
}

//热门品牌
-(void)PopularBrandLoadData
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630406";
    http.parameters[@"location"] = @"0";
    http.parameters[@"status"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        self.HotCarBrands = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.tableView.HotCarBrands = self.HotCarBrands;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        
    }];
}

-(void)brandLoadData
{
 
    MJWeakSelf;
    TLNetworking * http1 = [TLNetworking new];
    http1.code = @"630406";
    http1.parameters[@"status"] = @"1";
    [http1 postWithSuccess:^(id responseObject) {
        NSArray<CarModel *> *array = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        weakSelf.allArray = [NSMutableArray array];
        for(int i=0;i<26;i++)
        {
            NSString *str = [NSString stringWithFormat:@"%c",'A'+ i];
            NSMutableArray<CarModel *> *rowArray = [NSMutableArray array];
            for (int j = 0; j < array.count; j ++) {
                if ([str isEqualToString:array[j].letter]) {
                    [rowArray addObject:array[j]];
                }
            }
            if (rowArray.count > 0) {
                [weakSelf.allArray addObject:rowArray];
            }
            
        }
        
        NSMutableArray *indexArray = [NSMutableArray array];
        for (int i = 0; i < weakSelf.allArray.count; i ++) {
            NSMutableArray<CarModel *> * model = [CarModel mj_objectArrayWithKeyValuesArray:weakSelf.allArray[i]];
            [indexArray addObject:[NSString stringWithFormat:@"%@",model[0].letter]];
        }
        weakSelf.tableView.indexArray = indexArray;
        weakSelf.tableView.normalArray = weakSelf.allArray;
        [weakSelf.tableView reloadData];
        [weakSelf.tableView endRefreshHeader];
    } failure:^(NSError *error) {
        
    }];
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
