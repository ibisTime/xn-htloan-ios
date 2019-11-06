//
//  DealersVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/8/20.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DealersVC.h"
#import "DealersHeadView.h"
#import "DealersTableView.h"
#import "NewsModel.h"
#import "ClassifyListVC.h"
#import "ClassifyInfoVC.h"
#import "NewsInfoVC.h"
#import "CarInfoVC.h"
@interface DealersVC ()<RefreshDelegate>
@property (nonatomic , strong)NSMutableArray <CarModel *>*CarModelsCars;
@property (nonatomic , strong)NSMutableArray <NewsModel *>*NewsModels;
@property (nonatomic , strong)DealersHeadView *headView;
@property (nonatomic , strong)DealersTableView *tableView;
@property (nonatomic ,strong)NSArray *newstagDataAry;
@end

@implementation DealersVC

#pragma mark -- 页面即将显示
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//}
//
//#pragma mark -- 页面即将消失
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
//}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self navigationTransparentClearColor];
    self.navigationItem.hidesBackButton = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self navigationSetDefault];
    [self.view endEditing:YES];
    self.navigationItem.hidesBackButton = NO;
}

-(DealersHeadView *)headView
{
    if (!_headView) {
        _headView = [[DealersHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120 + kNavigationBarHeight - 64)];
        _headView.dealersModel = self.dealersModel;
        [_headView.shutdownBtn addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _headView;
}

- (void)initTableView {
    self.tableView = [[DealersTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    self.tableView.refreshDelegate = self;
    [self.view addSubview:self.tableView];
}

-(void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        NewsInfoVC * vc = [NewsInfoVC new];
        vc.code = self.NewsModels[indexPath.row].code;
    
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.showView = self.view;
    http.parameters[@"code"] = self.CarModelsCars[index].code;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        vc.status = @"1";
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index selectRowState:(NSString *)state
{
    ClassifyInfoVC *vc = [ClassifyInfoVC new];
    vc.carDealerCode = self.dealersModel.code;
    vc.brandCode = self.dealersModel.brandList[index][@"code"];
    vc.title = self.dealersModel.brandList[index][@"brandName"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)refreshTableView:(TLTableView *)refreshTableview scrollView:(UIScrollView *)scroll
{
    
    if (self.tableView.contentOffset.y>(120 + kNavigationBarHeight - 64)) {
        
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:0/255.0 green:145/255.0 blue:247/255.0 alpha:1.00]] forBarMetrics:UIBarMetricsDefault];
    }else
    {
        [self.navigationController.navigationBar setBackgroundImage:[self imageWithBgColor:[UIColor colorWithRed:0/255.0 green:145/255.0 blue:247/255.0  alpha:self.tableView.contentOffset.y / (120 + kNavigationBarHeight - 64)]] forBarMetrics:UIBarMetricsDefault];
    }
}

-(UIImage *)imageWithBgColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTableView];
    self.tableView.tableHeaderView = self.headView;
    [self NewsLoadData];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
////    [self.RightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
////    [self.LeftBackbButton setTintColor:[UIColor whiteColor]];
//    [self.LeftBackbButton setTitle:self.dealersModel.fullName forState:(UIControlStateNormal)];
    [self.RightButton setImage:kImage(@"编组") forState:(UIControlStateNormal)];
    [self.RightButton addTarget:self action:@selector(RightButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
//    self.navigationItem.leftBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.LeftBackbButton]];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:self.RightButton]];
}

-(void)RightButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 获取数据   资讯
-(void)NewsLoadData{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630455";
    help.parameters[@"status"] = @"1";
    help.parameters[@"carDealerCode"] = self.dealersModel.code;
    help.parameters[@"orderDir" ]=@"asc";
    [help modelClass:[NewsModel class]];
    help.tableView = self.tableView;
    help.isCurrency = YES;
    [self.tableView addRefreshAction:^{
        [weakSelf car_news_tag];
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.NewsModels = objs;
            weakSelf.tableView.NewsModels = weakSelf.NewsModels;
//            weakSelf.headView.newsTotalCount =
            [weakSelf carsLoadData];
            [weakSelf detailsLoadData];
            [weakSelf.tableView reloadData_tl];
            [weakSelf.tableView endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableView endRefreshHeader];
        }];
    }];
    [self.tableView beginRefreshing];
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
        self.tableView.newstagDataAry = self.newstagDataAry;
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)carsLoadData
{
 
    //精选车源
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630425";
    http2.parameters[@"carDealerCode"] = self.dealersModel.code;
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"start"] = @"0";
    http2.parameters[@"limit"] = @"100";
    [http2 postWithSuccess:^(id responseObject) {
        self.headView.carsTotalCount = [responseObject[@"data"][@"totalCount"] integerValue];
        self.CarModelsCars = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        self.tableView.CarModelsCars = self.CarModelsCars;
        [self.tableView reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}

//详情数据
-(void)detailsLoadData
{
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"632066";
    http2.parameters[@"code"] = self.dealersModel.code;
    
    [http2 postWithSuccess:^(id responseObject) {
        
        self.dealersModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        self.headView.dealersModel = self.dealersModel;
        self.tableView.dealersModel = self.dealersModel;
        [self.tableView reloadData];
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
