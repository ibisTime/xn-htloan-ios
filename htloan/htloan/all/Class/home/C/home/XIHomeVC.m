//
//  XIHomeVC.m
//  htloan
//
//  Created by apple on 2018/4/14.
//  Copyright © 2018年 myteam. All rights reserved.
//
#define imgCount    5
#import "XIHomeVC.h"

//M
#import "homeCarShowModel.h"
#import "stagingModel.h"

//V
#import "CircleGuideView.h"
#import "XIRecommendCarView.h"
#import "XICarShowCollectionView.h"
#import "stagingTableView.h"

@interface XIHomeVC ()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout>
//@property (nonatomic, strong) XIRecommendCarView *recommendCarView;
@property (nonatomic, strong) UIView *headerView;
//jiepan
@property (nonatomic, strong) XIRecommendCarView *recommendCarView;
@property (nonatomic, strong)XICarShowCollectionView * showCarColV;
@property (nonatomic, strong) NSArray<homeCarShowModel*> *carShows;
@property (nonatomic, strong)stagingTableView * stagingTabV;
@property (nonatomic, strong) NSArray <stagingModel *>*stagings;



//TLPageDataHelper
@property (nonatomic, strong) TLPageDataHelper *flashHelper;
@end

@implementation XIHomeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
  
    self.view.backgroundColor =kMineBackGroundColor;
    //添加通知
    [self addNotification];
    
    //创建控件
    [self initView];

    
    //获取列表
    [self requestCarShowList];
    
    

    [self requestStagingList];
    
    //刷新
    [self.showCarColV beginRefreshing];
    
    // Do any additional setup after loading the view.
}

#pragma mark - init
- (void)addNotification {
    //用户登录刷新首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewsFlash) name:kUserLoginNotification object:nil];
    //用户退出登录刷新首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshNewsFlash) name:kUserLoginOutNotification object:nil];
    //收到推送刷新首页
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshNewsFlash)
                                                 name:@"DidReceivePushNotification"
                                               object:nil];
}

- (void)refreshNewsFlash {
    
    //
    [self.stagingTabV beginRefreshing];
    [self.showCarColV beginRefreshing];
}

-(void)initView
{
    self.headerView = [[UIView alloc ]initWithFrame:CGRectMake(0, 0, kScreenWidth, 363)];
   
    
    //滚动
    NSArray<NSString*> * carImgName = @[@"img_01",@"img_02",@"img_03",@"img_04"];
    
    CircleGuideView * carView = [[CircleGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 185) imageNames:carImgName];
    carView.backgroundColor= kWhiteColor;
    carView.page.hidden =YES;
    [self.headerView addSubview:carView];
    
    //推荐
   self. recommendCarView = [[XIRecommendCarView alloc] initWithFrame:CGRectMake(0, 185, kScreenWidth, 178)];
    self.recommendCarView.backgroundColor = [UIColor whiteColor];
    [self.headerView addSubview:self.recommendCarView];
    
    //*****汽车展示********************
    //布局参数
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //设置cell的间距
    CGFloat cellW = (kScreenWidth-10)/3-2;
    CGFloat cellH = 125;
    flowLayout.itemSize = CGSizeMake(cellW, cellH);//size
    flowLayout.minimumLineSpacing =15;//行间距
    flowLayout.minimumInteritemSpacing = 1;//cell间距
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;//水平滚动
    //    flowLayout.sectionInset = UIEdgeInsetsMake(37, 5, 0, 5);//每一组间距
    
    self.showCarColV = [[XICarShowCollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:flowLayout];
    //    carShow.collectionViewLayout   = flowLayout;
    
    self.showCarColV.backgroundColor = kWhiteColor;
    [self.recommendCarView addSubview:self.showCarColV];
    [self.showCarColV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.recommendCarView.mas_top).offset(37);
        make.left.equalTo(self.recommendCarView.mas_left).offset(0);
        make.right.equalTo(self.recommendCarView.mas_right).offset(0);
        make.bottom.equalTo(self.recommendCarView.mas_bottom);
    }];
    
    

    //商品
    self.stagingTabV =[[stagingTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight)style:UITableViewStylePlain];
    self.stagingTabV.backgroundColor =kMineBackGroundColor;
    
    self.stagingTabV.tableHeaderView = self.headerView;
    
    [self.view addSubview:self.stagingTabV];
    
}

#pragma mark - Data
- (void)requestCarShowList {
    BaseWeakSelf;
    
    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
    
    helper.code = @"630426";
    helper.isList = YES;
//    helper.parameters[@"type"] = self.status;
    
    helper.collectionView = self.showCarColV;
    self.flashHelper = helper;
    
    [helper modelClass:[homeCarShowModel class]];
    
    [self.showCarColV addRefreshAction:^{
//        登入设置
        if ([TLUser user].isLogin) {

            helper.parameters[@"userId"] = [TLUser user].userId;
        } else {

            helper.parameters[@"userId"] = @"";
        }
        
        
        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
            
            weakSelf.carShows = objs;
            
            weakSelf.showCarColV.carShows = objs;
            
            
            
            [weakSelf.showCarColV reloadData_tl];
            
        } failure:^(NSError *error) {
            NSLog(@"----请求失败");
        }];
    }];
    // 下拉加载更多
    [self.showCarColV addLoadMoreAction:^{
        
        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            //中转
            weakSelf.carShows = objs;
            
            weakSelf.showCarColV.carShows = objs;
            
            [weakSelf.showCarColV reloadData_tl];
            
            
        } failure:^(NSError *error) {
            
        }];
        
    }];
    
    [self.showCarColV endRefreshingWithNoMoreData_tl];
    
    
}



- (void)requestStagingList {

    BaseWeakSelf;

    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];

    helper.code = @"630426";
    helper.isList = YES;
    helper.parameters[@"type"] = self.status;

    helper.tableView = self.stagingTabV;
    self.flashHelper = helper;

    [helper modelClass:[stagingModel class]];

    [self.stagingTabV addRefreshAction:^{
        //登入设置
        if ([TLUser user].isLogin) {

            helper.parameters[@"userId"] = [TLUser user].userId;
        } else {

            helper.parameters[@"userId"] = @"";
        }
        //

        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {

            weakSelf.stagings = objs;

            
            [weakSelf.stagingTabV reloadData_tl];

        } failure:^(NSError *error) {

        }];
    }];
    // 下拉加载更多
    [self.stagingTabV addLoadMoreAction:^{

        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
            //中转
            weakSelf.stagings = objs;

            weakSelf.stagingTabV.stagings = objs;

            [weakSelf.stagingTabV reloadData_tl];

           
        } failure:^(NSError *error) {

        }];

    }];

    [self.stagingTabV endRefreshingWithNoMoreData_tl];
}





- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
