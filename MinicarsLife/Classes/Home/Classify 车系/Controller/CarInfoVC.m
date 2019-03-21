//
//  CarInfoVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/15.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "CarInfoVC.h"
#import "CarInfoHeadCell.h"
#import "CarInfoCommonCell.h"
#import "DeployFirstCell.h"
#import "DeployLastCell.h"
#import "CallNowView.h"
#import "AskSuccessView.h"
#import "CalculatorVC.h"
@interface CarInfoVC ()<HW3DBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,RefreshDelegate,AskMoneyClickDelegate,BackToHomeDelegate>
@property (nonatomic , strong)HW3DBannerView *scrollView;
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) UIView * bottomview;
@end

@implementation CarInfoVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.alpha = 0;
//     [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:animated];
    self.navigationController.navigationBar.alpha = 1;
}

-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 70)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
    }
    return _tableview;
}
#pragma mark -- 滑动试图懒加载
-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 522.00/750.00 * SCREEN_WIDTH) imageSpacing:0 imageWidth:SCREEN_WIDTH];
        _scrollView.userInteractionEnabled=YES;
        _scrollView.autoScrollTimeInterval = 3;
        _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self bannerLoadData];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 522.00/750.00 * SCREEN_WIDTH)];
    [view addSubview:self.scrollView];
    self.tableview.tableHeaderView = view;
    [self.view addSubview:self.tableview];
    
    self.bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 70, SCREEN_WIDTH, 70)];
    UIButton * callnow = [UIButton buttonWithTitle:@"打电话" titleColor:kWhiteColor backgroundColor:kHexColor(@"#FF9402") titleFont:16 cornerRadius:2];
    callnow.tag = 1;
    [callnow addTarget:self action:@selector(ClickBottomBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    callnow.frame = CGRectMake(15, 16, SCREEN_WIDTH / 2 - 30, 45);
    [self.bottomview addSubview:callnow];
    
    UIButton * asknow = [UIButton buttonWithTitle:@"询底价" titleColor:kWhiteColor backgroundColor:kHexColor(@"#028EFF") titleFont:16 cornerRadius:2];
    asknow.tag = 2;
    [asknow addTarget:self action:@selector(ClickBottomBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    asknow.frame = CGRectMake(callnow.xx + 15, 16, SCREEN_WIDTH / 2 - 30, 45);
    [self.bottomview addSubview:asknow];
    
    [self.view addSubview:self.bottomview];
    
    
    
}
-(void)ClickBottomBtn:(UIButton *)sender{
    if (sender.tag == 2) {
        CallNowView * vc = [[CallNowView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        vc.delegate = self;
        [[USERXX user]showPopAnimationWithAnimationStyle:3 showView:vc BGAlpha:0.5 isClickBGDismiss:YES];
    }
}
-(void)askmoney{
    [[USERXX user].cusPopView dismiss];
    AskSuccessView * vc = [[AskSuccessView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    vc.delegate = self;
    [[USERXX user]showPopAnimationWithAnimationStyle:3 showView:vc BGAlpha:0.5 isClickBGDismiss:YES];
    
}
-(void)BackToHomeClick{
    BaseTabBarViewController *tabBarCtrl = [[BaseTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarCtrl;
}
-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex{
    //    NSLog(@"%ld",currentImageIndex);
}
#pragma mark - UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 3;
    }
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=@"CarInfoHead";
        CarInfoHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[CarInfoHeadCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        cell.CarModel = [CarModel mj_objectWithKeyValues: self.CarModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.button addTarget:self action:@selector(goCalculator) forControlEvents:(UIControlEventTouchUpInside)];
        return cell;
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            static NSString *rid=@"DeployFirst";
            DeployFirstCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[DeployFirstCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            }
            cell.CarModel = [CarModel mj_objectWithKeyValues: self.CarModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            static NSString *rid=@"DeployLast";
            
            DeployLastCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            
            if(cell==nil){
                
                cell=[[DeployLastCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
                
            }
            cell.CarModel = [CarModel mj_objectWithKeyValues: self.CarModel];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    NSArray * titlearr = @[@"车源所在地",@"手续",@"更新时间"];
    NSArray * contentarr = @[@"",@"",[self.CarModel.updateDatetime convertToDetailDateWithoutHour]];
    static NSString *rid=@"CarInfoCommon";
    CarInfoCommonCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[CarInfoCommonCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
    cell.titlelab.text = titlearr[indexPath.row];
    cell.contentlab.text = contentarr[indexPath.row];
    cell.CarModel = [CarModel mj_objectWithKeyValues: self.CarModel];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)goCalculator{
    CalculatorVC * vc = [CalculatorVC new];
    vc.carcode = self.CarModel.code;
    [self.navigationController pushViewController:vc animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 170;
    }
    else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 82.5;
        }
        else
            return 45;
    }
    else
        return 45;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1 || section == 2) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52.5)];
        view.backgroundColor = kWhiteColor;
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kLineColor;
        [view addSubview:v1];
        
        UIView * v2 = [[UIView alloc]initWithFrame:CGRectMake(15, 20, 3, 25)];
        v2.backgroundColor = MainColor;
        [view addSubview:v2];
        UILabel * label = [UILabel labelWithFrame:CGRectMake(v2.xx + 5, v1.yy + 10, 100, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        if (section == 1) {
            label.text = @"库存信息";
        }
        else if (section == 2){
            label.text = @"配置";
        }
        [view addSubview:label];
        return view;
    }else
        return [UIView new];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.001;
    }
    else
        return 52.5;
}
#pragma mark - 获取数据

-(void)bannerLoadData
{
    //    MinicarsLifeWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"805806";
    http.parameters[@"location"] = @"index_banner";
    http.showView = self.view;
    
    [http postWithSuccess:^(id responseObject) {
        WGLog(@"%@",responseObject);
        NSArray *array = responseObject[@"data"];
        NSMutableArray *muArray = [NSMutableArray array];
        NSMutableArray *urlArray = [NSMutableArray array];
        
        for (int i = 0; i < array.count; i ++) {
            [muArray addObject:[NSString stringWithFormat:@"%@",[array[i][@"pic"] convertImageUrl]]];
            [urlArray addObject:[NSString stringWithFormat:@"%@",array[i][@"url"]]];
            
        }
        self.scrollView.data = muArray;
        
    } failure:^(NSError *error) {
        WGLog(@"%@",error);
    }];
}


@end
