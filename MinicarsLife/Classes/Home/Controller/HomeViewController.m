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

#import "HighQualityVC.h"
#import "CarsVC.h"
#import "SearchVC.h"
@interface HomeViewController ()<RefreshDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,ClickBtn,CollectionSelectRowDelegate>{
    HomeHeadVC * headview;
    NSArray *advertisingArray;
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
@property (nonatomic,strong)NSArray *newstagDataAry;
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self loadData];
//    [self getnewsadta];
//    [self PopularModels];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

#pragma mark -- 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [headview.player _pauseVideo];
    //    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    
}


//-(void)modifyFrame
//{
//    if (headview.CarBrandModels && headview.CarClassifyModels) {
//        float numberToRound;
//        int result;
//        numberToRound = (headview.CarBrandModels.count)/3.0;
//        result = (int)ceilf(numberToRound);
//
//        float numberToRound1;
//        int result1;
//        numberToRound1 = (headview.CarClassifyModels.count)/3.0;
//        result1 = (int)ceilf(numberToRound1);
    
//        headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*199);
//        0, self.scrollView.yy + 15,SCREEN_WIDTH
//        headview.collection.frame = CGRectMake(0, headview.scrollView.yy + 15,SCREEN_WIDTH , headview.bounds.size.height - headview.scrollView.yy -15);
//    }
//    [self.tableview reloadData_tl];
//}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    headview = [[HomeHeadVC alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*189 - 16 + 200 + (SCREEN_WIDTH - 30)/345*200)];
    headview.delegate = self;
//    headview.backgroundColor = kBlackColor;
//    [self.view addSubview:headview];
    [self getnewsadta];
    
    self.tableview.tableHeaderView = headview;
    [self.view addSubview:self.tableview];
    [self navigationView];
}


-(void)ClickBtn:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            HighQualityVC *vc = [HighQualityVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            CarsVC *vc = [CarsVC new];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {

            
        }
            break;

        default:
            break;
    }
}

-(void)navigationView
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNavigationBarHeight)];
    topView.backgroundColor = MainColor;
    [self.view addSubview:topView];
    
    
    
    UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, kStatusBarHeight + 13, 64, 21)];
    iconImg.image = kImage(@"会玩车");
    [self.view addSubview:iconImg];
    
    UIButton *backView = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backView.frame = CGRectMake(iconImg.xx + 21, kStatusBarHeight + 5.5, SCREEN_WIDTH - iconImg.xx - 21 - 15, 33);
    kViewRadius(backView, 16.5);
    backView.backgroundColor = kWhiteColor;
    [backView addTarget:self action:@selector(searchBtn) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backView];
    
    UIImageView *searchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 9.5, 14, 14)];
    searchImg.image = kImage(@"搜索-1");
    [backView addSubview:searchImg];
    
    UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(searchImg.xx + 5, 0, backView.width - searchImg.xx - 20, 33) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(12) textColor:kHexColor(@"#B3B3B3")];
    nameLbl.text = @"车系";
    [backView addSubview:nameLbl];
    
}

-(void)searchBtn
{
    SearchVC * vc = [SearchVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//banner 点击事件
-(void)clickImage:(NSInteger)inter
{
    NSDictionary *advertisingDic = advertisingArray[inter];
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
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, kNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - kTabBarHeight - kNavigationBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        _tableview.backgroundColor = kClearColor;
//        _tableview.defaultNoDataText = @"";
//        _tableview.defaultNoDataImage = kImage(@"qq");
//        _tableview.contentInset = UIEdgeInsetsMake(SCREEN_WIDTH/375*189 - kStatusBarHeight - 16, 0, 0, 0);;
        [_tableview registerClass:[HomeTableHeadCell class] forCellReuseIdentifier:@"HomeTableHead"];
        [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
        [_tableview registerClass:[DealersTableViewCell class] forCellReuseIdentifier:@"DealersTableViewCell"];
        
//        UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/375*189 - kStatusBarHeight - 16)];
//        _tableview.tableHeaderView = topView;
        
        
        
    }
    return _tableview;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if (section == 0) {
//        return 1;
//    }
    return self.NewsModels.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.NewsModels[indexPath.row];
    cell.newstagDataAry = self.newstagDataAry;
    return cell;
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

    return 105;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 60;
    }
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57.5)];
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 10, 70, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        label.text = @"玩车资讯";
        [view addSubview:label];
        
        UIButton * button = [UIButton buttonWithTitle:@"全部" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        [button addTarget:self action:@selector(morenews) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(SCREEN_WIDTH - 15 - 50, 27, 50, 17);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [view addSubview:button];
        return view;
    }
    return [UIView new];
}

-(void)morenews{
    CarNewsVC * vc = [[CarNewsVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    //    self.tabBarController.selectedIndex = 2;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        NewsInfoVC * vc = [NewsInfoVC new];
        vc.code = self.NewsModels[indexPath.row].code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

//点击collectionview cell
//-(void)ClickCollection:(NSInteger)index{
//    NSLog(@"tag%ld",index);
//    CarModel * model = [CarModel mj_objectWithKeyValues: self.CarModelsCars[index]];
//    [self getcarinfo:model.code];
//}

//-(void)getcarinfo:(NSString *)code{
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.code = @"630427";
//    http.showView = self.view;
//    http.parameters[@"code"] = code;
//    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
//    [http postWithSuccess:^(id responseObject) {
//        CarInfoVC * vc = [CarInfoVC new];
//        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    } failure:^(NSError *error) {
//
//    }];
//}


//-(void)ClickCollectionClassify:(NSIndexPath *)index{
//    if (index.section == 0) {
//        ClassifyInfoVC * vc = [[ClassifyInfoVC alloc]init];
//        switch (index.row) {
//            case 0:{
//                vc.priceStart = @"300000";
//                vc.priceEnd = @"500000";
//            }
//                break;
//            case 1:{
//                vc.priceStart = @"500000";
//                vc.priceEnd = @"700000";
//            }
//                break;
//            case 2:{
//                vc.priceStart = @"700000";
//                vc.priceEnd = @"";
//            }
//                break;
//            case 3:{
//                vc.priceStart = @"";
//                vc.priceEnd = @"";
////                vc.isMore = @"1";
//            }
//                break;
//            default:
//                break;
//        }
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//}

//-(void)ClickCollectionClassify:(NSIndexPath *)index withmodels:(CarModel *)models{
//    if (index.section == 1) {
//        ClassifyListVC * vc = [ClassifyListVC new];
//        vc.brandcode = models.code;
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
////        [self getClassifyListData:models.code];
//    }
//    if (index.section == 2) {
//        ClassifyInfoVC * vc = [ClassifyInfoVC new];
//        vc.title = models.name;
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.models = models;
//        [self.navigationController pushViewController:vc animated:YES];
////        [self getClassifyData:models.code :models.name];
//    }
//}

#pragma mark - 获取数据   资讯
-(void)getnewsadta{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630455";
    help.parameters[@"location"] = @"0";
    help.parameters[@"status"] = @"1";
    help.parameters[@"orderDir" ]=@"asc";
//    help.parameters[@"orderColumn"] = @"";
    [help modelClass:[NewsModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.NewsModels = objs;
            [weakSelf car_news_tag];
            [weakSelf bannerLoadData];
//            [weakSelf loadData];
            [weakSelf.tableview reloadData_tl];
            [weakSelf.tableview endRefreshHeader];
            
        } failure:^(NSError *error) {
            [weakSelf.tableview endRefreshHeader];
        }];
    }];
    [self.tableview beginRefreshing];
}

-(void)bannerLoadData{
 
    TLNetworking *http = [TLNetworking new];
    http.code = @"805806";
    http.parameters[@"location"] = @"index_banner";
    http.showView = self.view;
    
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        advertisingArray = responseObject[@"data"];
        NSMutableArray *muArray = [NSMutableArray array];
        NSMutableArray *urlArray = [NSMutableArray array];
        
        for (int i = 0; i < advertisingArray.count; i ++) {
            [muArray addObject:[NSString stringWithFormat:@"%@",[advertisingArray[i][@"pic"] convertImageUrl]]];
            [urlArray addObject:[NSString stringWithFormat:@"%@",advertisingArray[i][@"url"]]];
        }
        headview.scrollView.data = muArray;
//        self.urlArray = urlArray;
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];

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

//-(void)loadData{
//
//    //热门品牌
//    TLNetworking * http = [[TLNetworking alloc]init];
//    http.showView = self.view;
//    http.code = @"630490";
//    http.parameters[@"location"] = @"0";
//    http.parameters[@"status"] = @"1";
//    http.parameters[@"start"] = @"0";
//    http.parameters[@"limit"] = @"100";
////    http.parameters[@"type"] = @"2";
//    http.parameters[@"orderDir"] = @"asc";
//    [http postWithSuccess:^(id responseObject) {
//        headview.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [self modifyFrame];
//    } failure:^(NSError *error) {
//
//    }];
//
//    //列表查询车系
//    TLNetworking * http1 = [[TLNetworking alloc]init];
//    http1.showView = self.view;
//    http1.code = @"630491";
//    http1.parameters[@"location"] = @"0";
//    http1.parameters[@"status"] = @"1";
//    http1.parameters[@"start"] = @"0";
//    http1.parameters[@"limit"] = @"100";
//    http1.parameters[@"orderColumn"] = @"order_no";
//    http1.parameters[@"orderDir"] = @"asc";
//    [http1 postWithSuccess:^(id responseObject) {
//        headview.CarClassifyModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        [self modifyFrame];
//    } failure:^(NSError *error) {
//
//    }];
//    [self PopularModels];
//}

//热门车型
//-(void)PopularModels
//{
//
//    TLNetworking * http2 = [[TLNetworking alloc]init];
//    http2.code = @"630492";
//    http2.parameters[@"location"] = @"0";
//    http2.parameters[@"status"] = @"1";
//    http2.parameters[@"start"] = @"0";
//    http2.parameters[@"limit"] = @"100";
//    //    http2.parameters[@"type"] = @"2";
//    http2.parameters[@"orderDir"] = @"asc";
//    [http2 postWithSuccess:^(id responseObject) {
//        self.CarModelsCars = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//    } failure:^(NSError *error) {
//
//    }];
//}





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
