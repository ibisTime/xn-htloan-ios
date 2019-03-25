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
#import "DeployModel.h"
@interface CarInfoVC ()<HW3DBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,RefreshDelegate,AskMoneyClickDelegate,BackToHomeDelegate>
{
    CallNowView * callNowView;
}
@property (nonatomic , strong)HW3DBannerView *scrollView;
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) UIView * bottomview;
@property (nonatomic,strong) UIButton * collectbtn;
@property (nonatomic,strong) NSMutableArray<DeployModel *> * DeployModels;
@property (nonatomic,strong) NSString * phonestring;
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
//    [self bannerLoadData];
    [self getCarDeploy];
    [self loadData];
    [self setHistory];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 522.00/750.00 * SCREEN_WIDTH)];
    [view addSubview:self.scrollView];
    self.tableview.tableHeaderView = view;
    [self.view addSubview:self.tableview];
    
     NSArray * p=[self.CarModel.pic componentsSeparatedByString:@","];
    NSMutableArray *muArray = [NSMutableArray arrayWithArray:p];
    self.scrollView.data = muArray;
    
    
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
    
    
    UIButton * collectbtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 50, 30, 30, 30)];
//    collectbtn.backgroundColor = [UIColor redColor];
    [collectbtn addTarget:self action:@selector(collectclick) forControlEvents:(UIControlEventTouchUpInside)];
    [collectbtn setImage:kImage(@"我的收藏") forState:(UIControlStateNormal)];
    [collectbtn setImage:kImage(@"详情收藏-点击") forState:(UIControlStateSelected)];
    if ([self.CarModel.isCollect isEqualToString:@"1"]) {
        collectbtn.selected = YES;
    }
    [self.scrollView addSubview:collectbtn];
    self.collectbtn = collectbtn;
    
    callNowView = [[CallNowView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    callNowView.carmodel = self.CarModel;
    callNowView.delegate = self;
    [self.view addSubview:callNowView];
    
}
-(void)collectclick{
    if ([self.CarModel.isCollect isEqualToString:@"0"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630460";
        http.parameters[@"creater"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"toCode"] = self.CarModel.code;
        http.parameters[@"toType"] = @"0";
        http.parameters[@"type"] = @"3";
        [http postWithSuccess:^(id responseObject) {
            self.collectbtn.selected = !self.collectbtn.selected;
            [self getCarDeploy];
        } failure:^(NSError *error) {
            
        }];
    }else{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630462";
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"carCode"] = self.CarModel.code;
        [http postWithSuccess:^(id responseObject) {
            self.collectbtn.selected = !self.collectbtn.selected;
            [self getCarDeploy];
        } failure:^(NSError *error) {
            
        }];
    }
    NSLog(@"=======%s=======",__func__);
}
-(void)ClickBottomBtn:(UIButton *)sender{
    if (sender.tag == 1) {
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"telprompt:10086"]];
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.phonestring]]];
    }
    if (sender.tag == 2) {
        [UIView animateWithDuration:0.1 animations:^{
//            self.view.alpha = 0.6;
            callNowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
    }
}

-(void)askmoneyWithphone:(NSString *)phone name:(NSString *)name{
//    [NSUserDefaults standardUserDefaults]
    NSLog(@"%@",[USERDEFAULTS objectForKey:USER_ID]);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630430";
    http.parameters[@"carCode"] = self.CarModel.code;
    http.parameters[@"name"] = name;
    http.parameters[@"userMobile"] = phone;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        callNowView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
        AskSuccessView * vc = [[AskSuccessView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        vc.delegate = self;
        [[USERXX user]showPopAnimationWithAnimationStyle:3 showView:vc BGAlpha:0.5 isClickBGDismiss:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)deleteBtnClickDelegate{
    callNowView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
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
    if (self.DeployModels.count <= 4) {
        return 1;
    }
    else if (self.DeployModels.count > 4 && self.DeployModels.count <= 6 ){
        return 2;
    }else
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
//            cell.CarModel = [CarModel mj_objectWithKeyValues: self.CarModel];
//            cell.model = [DeployModel mj_objectWithKeyValues:self.DeployModels[indexPath.row]];
            cell.DeployModels = self.DeployModels;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        else{
            
            static NSString *rid=@"DeployLast";
            DeployLastCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
            if(cell==nil){
                cell=[[DeployLastCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
            }
            if (indexPath.row == 1) {
                if (self.DeployModels.count == 6) {
                    cell.DeployModels =(NSMutableArray *) [self.DeployModels subarrayWithRange:NSMakeRange(4, 2)];
                }
                else
                    cell.DeployModels =(NSMutableArray *) [self.DeployModels subarrayWithRange:NSMakeRange(4, 1)];
                
            }
            else{
                if (self.DeployModels.count == 8) {
                    cell.DeployModels =(NSMutableArray *) [self.DeployModels subarrayWithRange:NSMakeRange(6, 2)];
                }
                else
                    cell.DeployModels =(NSMutableArray *) [self.DeployModels subarrayWithRange:NSMakeRange(6, 1)];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    NSArray * titlearr = @[@"车源所在地",@"手续",@"更新时间"];
    
    
    
    static NSString *rid=@"CarInfoCommon";
    CarInfoCommonCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
    if(cell==nil){
        cell=[[CarInfoCommonCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
    }
    cell.titlelab.text = titlearr[indexPath.row];
    if (indexPath.row==0) {
        if (self.CarModel.fromPlace) {
            cell.contentlab.text = self.CarModel.fromPlace;
        }
        else
            cell.contentlab.text = @"暂无";
    }
    else if (indexPath.row==1) {
        if (self.CarModel.procedure) {
            cell.contentlab.text = self.CarModel.procedure;
        }
        else
            cell.contentlab.text = @"暂无";
    }
    else{
        if (self.CarModel.updateDatetime) {
            cell.contentlab.text = [self.CarModel.updateDatetime convertToDetailDateWithoutHour];
        }
        else
            cell.contentlab.text = @"暂无";
    }
//    cell.contentlab.text = contentarr[indexPath.row];
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
-(void)getCarDeploy{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630448";
    http.parameters[@"carCode"] = self.CarModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.DeployModels = [DeployModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)loadData
{
    
    TLNetworking *http = [TLNetworking new];
    http.code = TheCalculatorURL;
    http.showView = self.view;
    http.parameters[@"limit"] = @"20";
    http.parameters[@"start"] = @"1";
    http.parameters[@"ckey"] = @"telephone";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        self.phonestring = responseObject[@"data"][@"list"][0][@"cvalue"];
    } failure:^(NSError *error) {
        
    }];
}
-(void)setHistory{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630460";
    http.parameters[@"creater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"toCode"] = self.CarModel.code;
    http.parameters[@"toType"] = @"0";
    http.parameters[@"type"] = @"1";
    [http postWithSuccess:^(id responseObject) {
        
    } failure:^(NSError *error) {
        
    }];
}
@end
