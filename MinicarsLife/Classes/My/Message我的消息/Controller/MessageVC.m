//
//  MessageVC.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/7/5.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "MessageVC.h"
#import "MessageTableView.h"
#import "MessageModel.h"
#import "RemindVC.h"
#import "NotifyVC.h"
#import "NoticeVC.h"

@interface MessageVC ()<RefreshDelegate,UIScrollViewDelegate>
@property (nonatomic , strong)MessageTableView *tableView;
@property (nonatomic , strong)NSMutableArray <MessageModel *>*model;
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, assign)NSInteger currentPages;

@property (nonatomic, strong)UILabel *WeiGreLabel;
@property (nonatomic,strong) RemindVC * vc1;
@property (nonatomic,strong) NotifyVC * vc2;
@property (nonatomic,strong) NoticeVC * vc3;
#define kPageCount 3
#define kButton_H 50
#define kMrg 10
#define kTag 1000

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的消息";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.WeiGreLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/kPageCount/2 - 12, 47 , 24, 3)];
    self.WeiGreLabel.backgroundColor = MainColor;
    [self.view addSubview:self.WeiGreLabel];
    
    //设置可以左右滑动的ScrollView
    [self setupScrollView];
    //设置控制的每一个子控制器
    [self setupChildViewControll];
    //设置分页按钮
    [self setupPageButton];
    //选择状态
    [self setupSelectBtn];

    
    
    [_scroll setContentOffset:CGPointMake(SCREEN_WIDTH * _currentPages, 0) animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController.navigationBar setShadowImage:nil];
}

#pragma mark - 设置可以左右滑动的ScrollView
- (void)setupScrollView{
    
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kButton_H , SCREEN_WIDTH, SCREEN_HEIGHT)];
    //    self.scroll.backgroundColor = [UIColor redColor];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    //    _scroll.backgroundColor = [UIColor redColor];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;
    
    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * kPageCount, SCREEN_HEIGHT/2);
    [self.view addSubview:_scroll];
}

#pragma mark - 设置控制的每一个子控制器
- (void)setupChildViewControll{
    self.vc1 = [[RemindVC alloc]init];
    self.vc2 = [[NotifyVC alloc]init];
    self.vc3 = [[NoticeVC alloc]init];
    
    //指定该控制器为其子控制器
    [self addChildViewController:_vc1];
    [self addChildViewController:_vc2];
    [self addChildViewController:_vc3];
    
    
    //将视图加入ScrollView上
    [_scroll addSubview:_vc1.view];
    [_scroll addSubview:_vc2.view];
    [_scroll addSubview:_vc3.view];
    
    //设置两个控制器的尺寸
    _vc1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc2.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc3.view.frame = CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    
}
#pragma mark - 设置分页按钮
- (void)setupPageButton{
    //button的index值应当从0开始
    
    UIButton *btn = [self setupButtonWithTitle:@"提醒" Index:0];
    [self setupButtonWithTitle:@"通知" Index:1];
    [self setupButtonWithTitle:@"公告" Index:2];
    
    [btn setTitleColor:MainColor forState:(UIControlStateNormal)];
    self.selectBtn = btn;
}
- (UIButton *)setupButtonWithTitle:(NSString *)title Index:(NSInteger)index{
    CGFloat y = 0;
    
    CGFloat w = SCREEN_WIDTH / kPageCount;
    CGFloat h = kButton_H;
    CGFloat x = index * w;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, y, w, h);
    btn.titleLabel.font = HGboldfont(15);
    btn.tag = index + kTag;
    [btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
    
    //    if (index!=0) {
    //        UIView * buttonline = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 , y+10, 1, h-20)];
    //        buttonline.backgroundColor=[UIColor lightGrayColor];
    //        [self.view addSubview:buttonline];
    //    }
    
    return btn;
}

#pragma mark -- 按钮点击方法
- (void)pageClick:(UIButton *)btn
{
    self.currentPages = btn.tag - kTag;
    [self gotoCurrentPage];
    [self setupSelectBtn];
}
#pragma mark - 设置选中button的样式
- (void)setupSelectBtn{
    UIButton *btn = [self.view viewWithTag:self.currentPages + kTag];
    if ([self.selectBtn isEqual:btn]) {
        return;
    }
    [self.selectBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    self.selectBtn = btn;
    [btn setTitleColor:MainColor forState:(UIControlStateNormal)];
    
    [UIView animateWithDuration:0.3 animations:^{
        _WeiGreLabel.frame = CGRectMake((self.currentPages + 1)*SCREEN_WIDTH/kPageCount - SCREEN_WIDTH/kPageCount/2 - 15, 48 , 30, 3);
    }];
    
}
#pragma mark -   进入当前的选定页面
- (void)gotoCurrentPage{
    CGRect frame;
    frame.origin.x = self.scroll.frame.size.width * self.currentPages;
    frame.origin.y = 0;
    frame.size = _scroll.frame.size;
    [_scroll scrollRectToVisible:frame animated:YES];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    //设置选中button的样式
    [self setupSelectBtn];
}

//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.title = @"我的消息";
//    self.view.backgroundColor = [UIColor whiteColor];
//    [self initTableView];
//}
//
//#pragma mark - Init
//- (void)initTableView {
//
//    self.tableView = [[MessageTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight) style:(UITableViewStyleGrouped)];
//    self.tableView.refreshDelegate = self;
//    self.tableView.backgroundColor = kBackgroundColor;
//    [self.view addSubview:self.tableView];
//    [self LoadData];
//
//}
//
//-(void)LoadData
//{
//
//    MinicarsLifeWeakSelf;
//
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = MyNewsURL;
//    helper.isList = NO;
//    helper.isCurrency = YES;
//    helper.parameters[@"toKind"] = @"C";
//    helper.parameters[@"channelType"] = @"4";
//    helper.parameters[@"pushType"] = @"41";
//    helper.parameters[@"status"] = @"1";
//    helper.parameters[@"fromSystemCode"] = @"CD-HTWT000020";
//    helper.parameters[@"toSystemCode"] = @"CD-HTWT000020";
//    helper.tableView = self.tableView;
//    [helper modelClass:[MessageModel class]];
//
//    [self.tableView addRefreshAction:^{
//        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//
//            //去除没有的币种
//            NSLog(@" ==== %@",objs);
//
//            NSMutableArray <MessageModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                MessageModel *model = (MessageModel *)obj;
//                [shouldDisplayCoins addObject:model];
//
//            }];
//
//            //
//            weakSelf.model = shouldDisplayCoins;
//            weakSelf.tableView.model = shouldDisplayCoins;
//            [weakSelf.tableView reloadData_tl];
//
//        } failure:^(NSError *error) {
//
//
//        }];
//
//
//    }];
//
//    [self.tableView addLoadMoreAction:^{
//
//        [helper loadMore:^(NSMutableArray *objs, BOOL stillHave) {
//            NSLog(@" ==== %@",objs);
//            //去除没有的币种
//
//
//            NSMutableArray <MessageModel *> *shouldDisplayCoins = [[NSMutableArray alloc] init];
//            [objs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//
//                MessageModel *model = (MessageModel *)obj;
//                //                if ([[CoinUtil shouldDisplayCoinArray] indexOfObject:currencyModel.currency ] != NSNotFound ) {
//
//                [shouldDisplayCoins addObject:model];
//                //                }
//
//            }];
//
//            //
//            weakSelf.model = shouldDisplayCoins;
//            weakSelf.tableView.model = shouldDisplayCoins;
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
