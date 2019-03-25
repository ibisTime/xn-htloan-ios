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
@interface HomeViewController ()<RefreshDelegate,UIWebViewDelegate,UITableViewDelegate,UITableViewDataSource,ClickBtn>{
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
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微车生活";
//    HomeHeadVC * view = [[HomeHeadVC alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 673.00/750.00 * SCREEN_WIDTH + 20)];
    headview = [[HomeHeadVC alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 673.00/750.00 * SCREEN_WIDTH + 60)];
//    view.CarStyleModels = self.CarClassifyModels;
    headview.delegate = self;
    self.tableview.tableHeaderView = headview;
    [self.view addSubview:self.tableview];
    [self getnewsadta];
}
-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight-kTabBarHeight)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        
        [_tableview registerClass:[HomeTableHeadCell class] forCellReuseIdentifier:@"HomeTableHead"];
        [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"cell"];
        
    }
    return _tableview;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
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
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 180;
    }
    return 105;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 60;
    }
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
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
    if (section == 1) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 57.5)];
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        view.backgroundColor = kWhiteColor;
        UILabel * label = [UILabel labelWithFrame:CGRectMake(15, 10, 70, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        label.text = @"新车资讯";
        [view addSubview:label];
        
        UIButton * button = [UIButton buttonWithTitle:@"更多" titleColor:kTextColor2 backgroundColor:kClearColor titleFont:12 cornerRadius:0];
        [button addTarget:self action:@selector(morenews) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(SCREEN_WIDTH - 15 - 25, 27, 25, 17);
        [view addSubview:button];
        return view;
    }
    return [UIView new];
    
}

-(void)morenews{
    CarNewsVC * vc = [[CarNewsVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        NewsInfoVC * vc = [NewsInfoVC new];
        vc.code = self.NewsModels[indexPath.row].code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//根据价格选择
-(void)GetClassifyByPrice:(NSString *)priceStart priceEnd:(NSString *)priceEnd{
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630426";
    http2.parameters[@"priceStart"] =priceStart;
    http2.parameters[@"priceEnd"] =priceEnd;
    [http2 postWithSuccess:^(id responseObject) {      
        ClassifyListVC * vc = [[ClassifyListVC alloc]init];
        vc.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failure:^(NSError *error) {
        
    }];
    
    
    

}

//点击collectionview cell
-(void)ClickCollection:(NSInteger)index{
    NSLog(@"tag%ld",index);
//    ChooseCarVC * vc = [ChooseCarVC new];
//    CarInfoVC * vc = [CarInfoVC new];
//    vc.CarModel =[CarModel mj_objectWithKeyValues: self.CarModelsCars[index]];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    CarModel * model = [CarModel mj_objectWithKeyValues: self.CarModelsCars[index]];
    [self getcarinfo:model.code];
}
-(void)getcarinfo:(NSString *)code{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.parameters[@"code"] = code;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        CarInfoVC * vc = [CarInfoVC new];
//        vc.CarModel =[CarModel mj_objectWithKeyValues: self.models[0].cars[indexPath.row]];
        vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}

-(void)ClickCollectionClassify:(NSIndexPath *)index{
    if (index.section == 0) {
        switch (index.row) {
            case 0:
                [self GetClassifyByPrice:@"300000" priceEnd:@"500000"];
                break;
            case 1:
                [self GetClassifyByPrice:@"500000" priceEnd:@"700000"];
                break;
            case 2:
                [self GetClassifyByPrice:@"700000" priceEnd:@""];
                break;
            case 3:
                [self GetClassifyByPrice:@"" priceEnd:@"300000"];
                break;
            default:
                break;
        }
    }
}
-(void)ClickCollectionClassify:(NSIndexPath *)index withmodels:(CarModel *)models{
    if (index.section == 1) {
        [self getClassifyListData:models.code];
    }
    if (index.section == 2) {
        [self getClassifyData:models.code :models.name];
    }
}
-(void)getClassifyListData:(NSString *)code{
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630416";
    http2.parameters[@"brandCode"] = code;
    [http2 postWithSuccess:^(id responseObject) {
        ClassifyListVC * vc = [ClassifyListVC new];
        vc.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.brandcode = code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)getClassifyData:(NSString*)code :(NSString *)title{
    //列表查询车型
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630426";
    http2.parameters[@"seriesCode"] = code;
    [http2 postWithSuccess:^(id responseObject) {
        ClassifyInfoVC * vc = [ClassifyInfoVC new];
        vc.models = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        vc.hidesBottomBarWhenPushed = YES;
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 获取数据
-(void)getnewsadta{
    MinicarsLifeWeakSelf;
    TLPageDataHelper * help = [[TLPageDataHelper alloc]init];
    help.code = @"630455";
    help.parameters[@"status"] = @"1";
    [help modelClass:[NewsModel class]];
    help.tableView = self.tableview;
    help.isCurrency = YES;
    [self.tableview addRefreshAction:^{
        [help refresh:^(NSMutableArray *objs, BOOL stillHave) {
            weakSelf.NewsModels = objs;
            [weakSelf loadData];
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

-(void)loadData{
    
    //列表查询品牌
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630406";
    http.parameters[@"isReferee"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        headview.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    } failure:^(NSError *error) {
        
    }];
    
    //列表查询车系
    TLNetworking * http1 = [[TLNetworking alloc]init];
    http1.showView = self.view;
    http1.code = @"630416";
    http1.parameters[@"isReferee"] = @"1";
    [http1 postWithSuccess:^(id responseObject) {
        headview.CarClassifyModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
    } failure:^(NSError *error) {
        
    }];
    
    if (headview.CarBrandModels && headview.CarClassifyModels) {
        float numberToRound;
        int result;
        numberToRound = (headview.CarBrandModels.count)/3.0;
        result = (int)ceilf(numberToRound);
        
        float numberToRound1;
        int result1;
        numberToRound1 = (headview.CarClassifyModels.count)/3.0;
        result1 = (int)ceilf(numberToRound1);
        
        headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400.00/750.00 * SCREEN_WIDTH + 20 * result + 100 * result1 + 25);
        headview.collection.frame = CGRectMake(0, headview.scrollView.yy + 10,SCREEN_WIDTH , headview.bounds.size.height - headview.scrollView.yy);
    }
    
    //列表查询车型
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630426";
    http2.parameters[@"isReferee"] = @"1";
    [http2 postWithSuccess:^(id responseObject) {
        self.CarModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.CarModelsCars = [NSMutableArray array];
        for (int j = 0; j < self.CarModels.count; j ++) {
            for (int i = 0; i < self.CarModels[j].cars.count; i++) {
                
                [self.CarModelsCars addObject:self.CarModels[j].cars[i]];
            }
            [self.tableview reloadData_tl];
        }
    } failure:^(NSError *error) {
        
    }];
}










#pragma mark - Init
- (void)initTableView {
//    self.tableView = [[HomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight - kTabBarHeight) style:(UITableViewStyleGrouped)];
//    self.tableView.refreshDelegate = self;
//    self.tableView.backgroundColor = kBackgroundColor;
//    [self.view addSubview:self.tableView];
//    MJWeakSelf;
//    self.tableView.clickImageBlock = ^(NSInteger currentIndex) {
//        [weakSelf loadWebView:currentIndex];
//    };
}

- (void)loadWebView:(NSInteger)inter
{
    
  
//    BannerWebViewVC *banner = [BannerWebViewVC new];
//    banner.htmlStr = self.urlArray[inter];
//    if ([banner.htmlStr isEqualToString:@""] || banner.htmlStr == nil) {
//        return;
//    }
//    [self.navigationController pushViewController:banner animated:YES];
//    self.webView = [[UIWebView alloc] init];
//    self.webView.delegate = self;
//    self.webView.scrollView.bounces=NO;
//    [self.view addSubview:self.webView];
//
//    [self.webView loadHTMLString:self.urlArray[inter] baseURL:nil];

}
- (void)refreshTableView:(TLTableView *)refreshTableview didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 1) {
//        GoodsDetailsViewController *vc = [[GoodsDetailsViewController alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        vc.model = self.goodsModel[indexPath.row];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
//    if (index == 98) {
//        CarLoanCalculatorVC *vc = [CarLoanCalculatorVC new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }else if(index == 99)
//    {
//        GoodsListVC *vc = [GoodsListVC new];
//        vc.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:vc animated:YES];
//    }else
//    {
//        ExhibitionCenterVC *vc = [[ExhibitionCenterVC alloc]init];
//        vc.hidesBottomBarWhenPushed = YES;
//        HomeModel *model = self.carModel[index - 100];
//        vc.brandCode = model.brandCode;
////        vc.seriesCode = model.seriesCode;
//        NSLog(@"%@",self.carModel);
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

//-(void)bannerLoadData
//{
////    MinicarsLifeWeakSelf;
//    TLNetworking *http = [TLNetworking new];
//    http.code = @"805806";
//    http.parameters[@"location"] = @"index_banner";
//    http.showView = self.view;
//
//    [http postWithSuccess:^(id responseObject) {
//        WGLog(@"%@",responseObject);
//        NSArray *array = responseObject[@"data"];
//        NSMutableArray *muArray = [NSMutableArray array];
//        NSMutableArray *urlArray = [NSMutableArray array];
//
//        for (int i = 0; i < array.count; i ++) {
//            [muArray addObject:[NSString stringWithFormat:@"%@",[array[i][@"pic"] convertImageUrl]]];
//            [urlArray addObject:[NSString stringWithFormat:@"%@",array[i][@"url"]]];
//
//        }
//        self.urlArray = urlArray;
//        self.tableView.bannerArray = muArray;
//
//    } failure:^(NSError *error) {
//        WGLog(@"%@",error);
//    }];
//}

////推荐车系
//-(void)RecommendedRange
//{
//    MinicarsLifeWeakSelf;
//
//    TLNetworking *http = [TLNetworking new];
//    http.code = RecommendedRangeURL;
//    http.showView = self.view;
////    http.parameters[@"location"] = @"1";
//    http.parameters[@"status"] = @"1";
//    [http postWithSuccess:^(id responseObject) {
//
//        self.carModel = [HomeModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//        weakSelf.tableView.carModel = self.carModel;
//        [weakSelf.tableView reloadData];
//
//    } failure:^(NSError *error) {
//        WGLog(@"%@",error);
//    }];
//}
//
//-(void)LoadData
//{
//
//    MinicarsLifeWeakSelf;
//
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = RecommendedStagingURL;
//    helper.parameters[@"location"] = @"0";
//    helper.parameters[@"status"] = @"3";
//    helper.isList = NO;
//    helper.isCurrency = YES;
//    helper.tableView = self.tableView;
//    [helper modelClass:[HomeModel class]];
//
//    [self.tableView addRefreshAction:^{
//        [weakSelf RecommendedRange];
//        [weakSelf bannerLoadData];
//        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//
//            //去除没有的币种
//            NSLog(@" ==== %@",objs);
//
//            NSMutableArray <HomeModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                HomeModel *model = (HomeModel *)obj;
//                [shouldDisplayCoins addObject:model];
//
//            }];
//
//            //
//            weakSelf.goodsModel = shouldDisplayCoins;
//            weakSelf.tableView.goodsModel = shouldDisplayCoins;
//            [weakSelf.tableView reloadData_tl];
//
//        } failure:^(NSError *error) {
//
//        }];
//    }];
//    [self.tableView addLoadMoreAction:^{
//        helper.parameters[@"location"] = @"1";
//        helper.parameters[@"status"] = @"3";
//        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//            NSLog(@" ==== %@",objs);
//            //去除没有的币种
//            NSMutableArray <HomeModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                HomeModel *model = (HomeModel *)obj;
//                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {
//
//                [shouldDisplayCoins addObject:model];
//                //                }
//
//            }];
//
//            //
//            weakSelf.goodsModel = shouldDisplayCoins;
//            weakSelf.tableView.goodsModel = shouldDisplayCoins;
//            [weakSelf.tableView reloadData_tl];
//
//        } failure:^(NSError *error) {
//
//
//        }];
//
//    }];
//
//    [self.tableView beginRefreshing];
//}




@end
