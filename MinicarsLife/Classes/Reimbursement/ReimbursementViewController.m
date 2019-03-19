//
//  ReimbursementViewController.m
//  MinicarsLife
//
//  Created by QinBao Zheng on 2018/6/27.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "ReimbursementViewController.h"
#import "RecentPaymentsVC.h"
#import "RecordVC.h"
#import "SearchVC.h"
@interface ReimbursementViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scroll;
@property (nonatomic, strong)UIButton *selectBtn;

@property (nonatomic, assign)NSInteger currentPages;

@property (nonatomic, strong)UILabel *WeiGreLabel;
@property (nonatomic, strong)RecentPaymentsVC *vc1;
@property (nonatomic, strong)RecordVC *vc2;
@property (nonatomic , strong)UIView *backView;

#define kPageCount 2
#define kButton_H 50
#define kMrg 10
#define kTag 1000


@end

@implementation ReimbursementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.title = @"车型库";
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
//    self.backView.backgroundColor = [UIColor redColor];
    
    UIButton  *button = [UIButton buttonWithTitle:@"" titleColor:kClearColor backgroundColor:kClearColor titleFont:0];
//    button.imageView.image = kImage(@"弹窗-关闭");
    [button setImage:kImage(@"搜索") forState:(UIControlStateNormal)];
    button.frame = CGRectMake(self.backView.width - 6 - 12 - 12, 14.5, 17.5, 17.5);
    [button addTarget:self action:@selector(buttonclick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.backView addSubview:button];
    
    
    self.navigationItem.titleView = self.backView;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    //设置可以左右滑动的ScrollView
    [self setupScrollView];
    //设置控制的每一个子控制器
    [self setupChildViewControll];
    //设置分页按钮
    [self setupPageButton];
    self.WeiGreLabel = [[UILabel alloc]initWithFrame:CGRectMake(133, 40 , 24, 2)];
    self.WeiGreLabel.backgroundColor = kLineColor;
    [self.backView addSubview:self.WeiGreLabel];
//    [self setupSelectBtn];
    [_scroll setContentOffset:CGPointMake(SCREEN_WIDTH * _currentPages, 0) animated:YES];
    
    
    
}
-(void)buttonclick{
    SearchVC * vc = [SearchVC new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.scroll.backgroundColor = [UIColor redColor];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.bounces = NO;
    //    _scroll.backgroundColor = [UIColor redColor];
    _scroll.showsVerticalScrollIndicator = NO;
    _scroll.directionalLockEnabled = YES;

    _scroll.contentSize = CGSizeMake(SCREEN_WIDTH * kPageCount, 0);
    [self.view addSubview:_scroll];
}

#pragma mark - 设置控制的每一个子控制器
- (void)setupChildViewControll{
    self.vc1 = [[RecentPaymentsVC alloc]init];
    self.vc2 = [[RecordVC alloc]init];

    //指定该控制器为其子控制器
    [self addChildViewController:_vc1];
    [self addChildViewController:_vc2];


    //将视图加入ScrollView上
    [_scroll addSubview:_vc1.view];
    [_scroll addSubview:_vc2.view];

    //设置两个控制器的尺寸
    _vc1.view.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    _vc2.view.frame = CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

}
#pragma mark - 设置分页按钮
- (void)setupPageButton{
    //button的index值应当从0开始

    UIButton *btn = [self setupButtonWithTitle:@"按条件" Index:0];
    [self setupButtonWithTitle:@"按品牌" Index:1];
//    btn.alpha = 0.99;
//    [btn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
    btn.selected = YES;
    self.selectBtn = btn;
    
}

- (UIButton *)setupButtonWithTitle:(NSString *)title Index:(NSInteger)index{
    CGFloat y = 0;
    
//    CGFloat w = SCREEN_WIDTH / (kPageCount + 1);
    CGFloat h = kButton_H;
//    CGFloat x = index * w;
    CGFloat w = 50;
    CGFloat x = 116 + index * (w + 40);
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:(UIControlStateNormal)];
    btn.frame = CGRectMake(x, y, w, h);
    btn.titleLabel.font = HGboldfont(16);
    btn.tag = index + kTag;
    [btn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
//    [btn setTitleColor:RGB(170, 207, 254) forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(pageClick:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:btn];
//    self.navigationItem.titleView = btn;
//    btn.alpha = 0.6;
    //    if (index!=0) {
    //        UIView * buttonline = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4 , y+10, 1, h-20)];
    //        buttonline.backgroundColor=[UIColor lightGrayColor];
    //        [self.view addSubview:buttonline];
    //    }
    [self.backView addSubview:btn];
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
//    btn.selected = !btn.selected;
//    _selectBtn.selected = !_selectBtn.selected;
//    [self.selectBtn setTitleColor:RGB(170, 207, 254) forState:(UIControlStateNormal)];
//    self.selectBtn.alpha = 0.6;
    self.selectBtn = btn;
    [btn setTitleColor:kWhiteColor forState:(UIControlStateNormal)];
//    btn.alpha = 0.99;
    [UIView animateWithDuration:0.3 animations:^{
        CGFloat w = 50;
        CGFloat x = 130 + self.currentPages * (w + 40);
//        CGFloat x = btn.centerX;
//        _WeiGreLabel.frame = CGRectMake((self.currentPages + 1)*SCREEN_WIDTH/kPageCount - SCREEN_WIDTH/kPageCount/2 - 15, 40 , 30, 2);
         _WeiGreLabel.frame = CGRectMake(x, 40 , 30, 2);
    }];
}
#pragma mark -   进入当前的选定页面
- (void)gotoCurrentPage{
    CGPoint offset = CGPointMake(self.currentPages * _scroll.frame.size.width, 0);
    // 设置新的偏移量
    [_scroll setContentOffset:offset animated:YES];
}

#pragma mark - ScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = _scroll.frame.size.width;
    self.currentPages = floor((_scroll.contentOffset.x - pageWidth/2)/pageWidth) + 1;
    //设置选中button的样式
    [self setupSelectBtn];
}


@end
