//
//  HomeViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "HomeViewController.h"
#import "GoodsDetailsViewController.h"
#import "HomeModel.h"
//#import "HomeTableView.h"
#import "NewsInfoVC.h"
//车贷计算器
#import "CarLoanCalculatorVC.h"
//展销中心
#import "ExhibitionCenterVC.h"
//商品详情
#import "GoodsDetailsViewController.h"
//推荐分期
#import "GoodsListVC.h"
#import "BannerWebViewVC.h"
#import "NewsCell.h"
#import "HomeHeadVC.h"
#import "CarNewsVC.h"
#import "NewsModel.h"
#import "ChooseCarVC.h"
#import "BrandListVC.h"
#import "ClassifyListVC.h"
#import "CarModel.h"
#import "CarInfoVC.h"
#import "HomeTableHeadCell.h"
#import "ClassifyInfoVC.h"
#import "GeneralWebView.h"
#import "DealersTableViewCell.h"
#import "DealersVC.h"
@interface HomeViewController ()<RefreshDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,ClickBtn,CollectionSelectRowDelegate>{
    HomeHeadVC * headview;
}
//@property (nonatomic , strong)HomeTableView *tableView;
@property (nonatomic , strong)UIWebView *webView;
@property (nonatomic , strong)NSArray *urlArray;

@property (nonatomic, strong) NSMutableArray <HomeModel *>*carModel;

@property (nonatomic, strong) NSMutableArray <HomeModel *>*goodsModel;
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) NSMutableArray<NewsModel *> * NewsModels;


@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModels;
@property (nonatomic,strong) NSMutableArray<CarModel *> * CarModelsCars;
@property (nonatomic,strong) NSMutableArray<CarModel *> * DealersModels;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadData];
//    [self getnewsadta];
}
-(void)modifyFrame
{
    if (headview.CarBrandModels && headview.CarClassifyModels) {
        float numberToRound;
        int result;
        numberToRound = (headview.CarBrandModels.count)/3.0;
        result = (int)ceilf(numberToRound);
        
        float numberToRound1;
        int result1;
        numberToRound1 = (headview.CarClassifyModels.count)/3.0;
        result1 = (int)ceilf(numberToRound1);
        
        headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 300.00/750.00 * SCREEN_WIDTH + 30 * result + 90 * result1 + 30 + 10);
        headview.collection.frame = CGRectMake(0, headview.scrollView.yy + 10,SCREEN_WIDTH , headview.bounds.size.height - headview.scrollView.yy);
    }
    [self.tableview reloadData_tl];
}

-(void)morenews{
//    CarNewsVC * vc = [[CarNewsVC alloc]init];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    self.tabBarController.selectedIndex = 2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *titleLbl = [[UILabel alloc]init];
    titleLbl.text = @"微车生活名车体验馆";
    titleLbl.font = Font(18);
    titleLbl.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = titleLbl;
    [self loadData];
    [self getnewsadta];
    
    headview = [[HomeHeadVC alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 673.00/750.00 * SCREEN_WIDTH + 60)];
    
    headview.delegate = self;
    self.tableview.tableHeaderView = headview;
    [self.view addSubview:self.tableview];
    
}


//banner 点击事件

-(void)bannerUrl:(NSDictionary *)advertisingDic
{
    
    if ([advertisingDic[@"contentType"] isEqualToString:@"1"]) {
        NSString * str = advertisingDic[@"url"];
        if (str.length > 0) {
            GeneralWebView *vc = [GeneralWebView new];
            vc.URL = advertisingDic[@"url"];
            vc.name = @"详情";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if ([advertisingDic[@"contentType"] isEqualToString:@"2"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630427";
        http.showView = self.view;
        http.parameters[@"code"] = advertisingDic[@"parentCode"];
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            
            CarInfoVC * vc = [CarInfoVC new];
            vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
            
        } failure:^(NSError *error) {
            
        }];
    }
    
    if ([advertisingDic[@"contentType"] isEqualToString:@"3"]) {
        NewsInfoVC * vc = [NewsInfoVC new];
        vc.code = advertisingDic[@"parentCode"];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}




-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight-kTabBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        _tableview.defaultNoDataText = @"";
        _tableview.defaultNoDataImage = kImage(@"qq");
        [_tableview registerClass:[HomeTableHeadCell class] forCellReuseIdentifier:@"HomeTableHead"];
        [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerClass:[DealersTableViewCell class] forCellReuseIdentifier:@"DealersTableViewCell"];
        
    }
    return _tableview;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0 || section == 1) {
        return 1;
    }
    return self.NewsModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        DealersTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DealersTableViewCell" forIndexPath:indexPath];
        cell.models = self.DealersModels;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.section == 1) {
        HomeTableHeadCell * cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableHead" forIndexPath:indexPath];
        cell.CarStyleModels = self.CarModelsCars;
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.NewsModels[indexPath.row];
    return cell;
}

-(void)DealersLoadData
{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"632065";
    http.parameters[@"isHighQuality"] = @"1";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"10";
    [http postWithSuccess:^(id responseObject) {
        self.DealersModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [self modifyFrame];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
}

//经销商点击方法
-(void)DealersCollectionSelectRow:(NSInteger)index
{
    DealersVC *vc = [DealersVC new];
    vc.dealersModel = self.DealersModels[index];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 165;
    }
    if (indexPath.section == 1) {
        return 200;
    }
    return 105;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    if (section == 0) {
        UIView * view = [[UIView alloc]init];
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        return view;
        
    }
    
    if (section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57.5)];
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 10, 70, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        label.text = @"精选车源";
        [view addSubview:label];
        return view;
    }
    if (section == 2) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57.5)];
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 10, 70, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        label.text = @"资讯";
        [view addSubview:label];
        
        UIButton * button = [UIButton buttonWithTitle:@"查看更多" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        [button addTarget:self action:@selector(morenews) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(SCREEN_WIDTH - 15 - 50, 27, 50, 17);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [view addSubview:button];
        return view;
    }
    return [UIView new];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        NewsInfoVC * vc = [NewsInfoVC new];
        vc.code = self.NewsModels[indexPath.row].code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//点击collectionview cell
-(void)ClickCollection:(NSInteger)index{
    NSLog(@"tag%ld",index);
    CarModel * model = [CarModel mj_objectWithKeyValues: self.CarModelsCars[index]];
    [self getcarinfo:model.code];
}

-(void)getcarinfo:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.showView = self.view;
    http.parameters[@"code"] = code;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {

    }];
}


-(void)ClickCollectionClassify:(NSIndexPath *)index{
    if (index.section == 0) {
        ClassifyInfoVC * vc = [[ClassifyInfoVC alloc]init];
        switch (index.row) {
            case 0:{
                vc.priceStart = @"300000";
                vc.priceEnd = @"500000";
            }
                break;
            case 1:{
                vc.priceStart = @"500000";
                vc.priceEnd = @"700000";
            }
                break;
            case 2:{
                vc.priceStart = @"700000";
                vc.priceEnd = @"";
            }
                break;
            case 3:{
                vc.priceStart = @"";
                vc.priceEnd = @"";
//                vc.isMore = @"1";
            }
                break;
            default:
                break;
        }
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)ClickCollectionClassify:(NSIndexPath *)index withmodels:(CarModel *)models{
    if (index.section == 1) {
        ClassifyListVC * vc = [ClassifyListVC new];
        vc.brandcode = models.code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
//        [self getClassifyListData:models.code];
    }
    if (index.section == 2) {
        ClassifyInfoVC * vc = [ClassifyInfoVC new];
        vc.title = models.name;
        vc.hidesBottomBarWhenPushed = YES;
        vc.models = models;
        [self.navigationController pushViewController:vc animated:YES];
//        [self getClassifyData:models.code :models.name];
    }
}

#pragma mark - 获取数据   资讯
-(void)getnewsadta{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630455";
    help.parameters[@"location"] = @"0";
    help.parameters[@"status"] = @"1";
    [help modelClass:[NewsModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.NewsModels = objs;
            [weakSelf DealersLoadData];
            [weakSelf loadData];
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshHeader];
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview beginRefreshing];
}

-(void)loadData{
    
    //热门品牌
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630490";
    http.parameters[@"location"] = @"0";
    http.parameters[@"status"] = @"1";
    http.parameters[@"start"] = @"0";
    http.parameters[@"limit"] = @"100";
    http.parameters[@"type"] = @"2";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        headview.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [self modifyFrame];
    } failure:^(NSError *error) {
        
    }];
    
    //列表查询车系
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.showView = self.view;
    http1.code = @"630491";
    http1.parameters[@"location"] = @"0";
    http1.parameters[@"status"] = @"1";
    http1.parameters[@"start"] = @"0";
    http1.parameters[@"limit"] = @"100";
    http1.parameters[@"type"] = @"2";
    http1.parameters[@"orderDir"] = @"asc";
    [http1 postWithSuccess:^(id responseObject) {
        headview.CarClassifyModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        [self modifyFrame];
    } failure:^(NSError *error) {
        
    }];
    
    
    
    //热门车型
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630492";
    http2.parameters[@"location"] = @"0";
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"start"] = @"0";
    http2.parameters[@"limit"] = @"100";
    http2.parameters[@"type"] = @"2";
    http2.parameters[@"orderDir"] = @"asc";
    [http2 postWithSuccess:^(id responseObject) {
        self.CarModelsCars = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
    } failure:^(NSError *error) {
        
    }];
}










#pragma mark - Init
- (void)initTableView {

}

- (void)loadWebView:(NSInteger)inter
{

}
- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{

}



@end
