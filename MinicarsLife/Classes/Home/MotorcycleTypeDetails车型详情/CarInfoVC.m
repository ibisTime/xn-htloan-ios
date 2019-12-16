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
#import "CarDetailsDealersCell.h"
#import "DealersVC.h"
#import "NewsModel.h"
#import "NewsCell.h"
#import "ClassifyInfoCell.h"
#import "NewsInfoVC.h"
#import "CustomShareView.h"
#import "TLWXManager.h"
@interface CarInfoVC ()<HW3DBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,RefreshDelegate,AskMoneyClickDelegate,BackToHomeDelegate,CustomShareViewDelegate>
{
    CallNowView * callNowView;
    DeployFirstCell *deployFirstCell;
    CarInfoHeadCell *_cell;
    ClassifyInfoCell *classifyInfoCell;
}
@property (nonatomic , strong)HW3DBannerView *scrollView;
@property (nonatomic,strong) TLTableView * tableview;
@property (nonatomic,strong) UIView * bottomview;
//@property (nonatomic,strong) UIButton * collectbtn;
@property (nonatomic,strong) NSMutableArray<DeployModel *> * DeployModels;
@property (nonatomic,strong) NSString * phonestring;
@property (nonatomic,strong) NSArray * picArray;
@property (nonatomic,strong) NSArray * nameArray;

@property (nonatomic , strong)NSArray *dataArray;
@property (nonatomic , strong)CustomShareView *shareView;
@property (nonatomic , strong)NSMutableArray <CarModel *>*CarModelsCars;
@property (nonatomic , strong)NSMutableArray <NewsModel *>*NewsModels;
@property (nonatomic , strong)CarModel *dealersModel;
@property (nonatomic ,strong)NSArray *newstagDataAry;

@end

@implementation CarInfoVC


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self navigationTransparentClearColor];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self navigationSetDefault];
    [self.view endEditing:YES];
}

-(TLTableView *)tableview{
    if (!_tableview) {
        _tableview = [[TLTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 70 - kNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.refreshDelegate = self;
        [_tableview registerClass:[CarDetailsDealersCell class] forCellReuseIdentifier:@"CarDetailsDealersCell"];
        [_tableview registerClass:[NewsCell class] forCellReuseIdentifier:@"NewsCell"];
        
    }
    return _tableview;
}

-(NSArray *)splitArray: (NSArray *)array withSubSize : (int )subSize{
    
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for(int i=0;i<count;i++){
        int index = i * subSize;
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        [arr1 removeAllObjects];
        int j = index;
        while (j < subSize*(i + 1) && j < array. count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j+=1;
        }
        [arr addObject:[arr1 copy]];
    }
    return [arr copy];
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


-(void)car_versionLoadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = @"630036";
    http.parameters[@"parentKey"] = @"car_version";
    [http postWithSuccess:^(id responseObject) {
        
        self.dataArray = responseObject[@"data"];
        NSString *version;
        for (int i = 0; i<self.dataArray.count; i ++) {
            if ([_CarModel.version isEqualToString:self.dataArray[i][@"dkey"]]) {
                version = self.dataArray[i][@"dvalue"];
                callNowView.describdlab.text = [NSString stringWithFormat:@"%@ 外观:%@ 内饰:%@ %@",version,[USERXX convertNull: self.CarModel.outsideColor],[USERXX convertNull: self.CarModel.insideColor], [USERXX convertNull:self.CarModel.fromPlace]];
            }
        }
        [self.tableview reloadData];
    } failure:^(NSError *error) {
        
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
//    [self bannerLoadData];
    self.title = self.CarModel.name;
    [self loadData];
    [self reloaddata];
    [self car_versionLoadData];
    [self setHistory];
    
    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 522.00/750.00 * SCREEN_WIDTH)];
    [view addSubview:self.scrollView];
    self.tableview.tableHeaderView = view;
    [self.view addSubview:self.tableview];
    
    NSArray * p= [self.CarModel.advPic componentsSeparatedByString:@"||"];
    NSMutableArray *topImage = [NSMutableArray array];
    for (int i = 0; i < p.count; i ++) {
        [topImage addObject:[p[i] convertImageUrl]];
    }
    
    self.scrollView.data = topImage;
    
    
//    [self getCarDeploy];
    
    
    self.bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 70 -kNavigationBarHeight, SCREEN_WIDTH, 70)];
    UIButton * callnow = [UIButton buttonWithTitle:@"打电话" titleColor:kWhiteColor backgroundColor:kHexColor(@"#FF9402") titleFont:16 cornerRadius:2];
    callnow.tag = 1;
    [callnow addTarget:self action:@selector(ClickBottomBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    callnow.frame = CGRectMake(15, 16, SCREEN_WIDTH / 2 - 7.5 - 15, 45);
    [self.bottomview addSubview:callnow];
    
    UIButton * asknow = [UIButton buttonWithTitle:@"询底价" titleColor:kWhiteColor backgroundColor:kHexColor(@"#028EFF") titleFont:16 cornerRadius:2];
    asknow.tag = 2;
    [asknow addTarget:self action:@selector(ClickBottomBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    asknow.frame = CGRectMake(SCREEN_WIDTH / 2 + 7.5, 16, SCREEN_WIDTH / 2 - 15 - 7.5, 45);
    [self.bottomview addSubview:asknow];
    
    [self.view addSubview:self.bottomview];
    
    
    UIView *rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 88, 44)];
    
    [self.RightButton setFrame:CGRectMake(0, 0, 44, 44)];
    //    [self.RightButton setTitle:@"搜索" forState:UIControlStateNormal];
    [self.RightButton setImage:kImage(@"详情收藏-未点击") forState:UIControlStateNormal];
    [self.RightButton setImage:kImage(@"详情收藏-点击") forState:UIControlStateSelected];
    if ([self.CarModel.isCollect isEqualToString:@"1"]){
        self.RightButton.selected = YES;
    }
    if ([USERXX isBlankString:[USERDEFAULTS objectForKey:USER_ID]] == YES) {
        self.RightButton.hidden = YES;
    }
    
    [self.RightButton addTarget:self action:@selector(collectclick) forControlEvents:(UIControlEventTouchUpInside)];
    [rightView addSubview:self.RightButton];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareBtn.frame = CGRectMake(44, 0, 44, 44);
    [shareBtn setImage:kImage(@"分享白色") forState:(UIControlStateNormal)];
    [shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [rightView addSubview:shareBtn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer, [[UIBarButtonItem alloc] initWithCustomView:rightView]];

    callNowView = [[CallNowView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-kNavigationBarHeight)];
    callNowView.carmodel = self.CarModel;
    callNowView.delegate = self;
    [self.view addSubview:callNowView];
    
}



-(void)shareBtnClick{
    NSArray *shareAry = @[@{@"image":@"wechat",
                            @"title":@"微信"},
                          @{@"image":@"timeline_small",
                            @"title":@"朋友圈"}];
    
    _shareView = [[CustomShareView alloc] init];
    
    _shareView.alpha = 0;
    _shareView.delegate = self;
    [_shareView setShareAry:shareAry delegate:self];
    
    [[UIApplication sharedApplication].keyWindow addSubview:_shareView];
    
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        
        _shareView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
    
    //    BaseWeakSelf;
    _shareView.cancleBlock = ^(){
        
        //        [weakSelf removeFromSuperview];
    };
    
}

-(void)customShareViewButtonAction:(CustomShareView *)shareView title:(NSString *)title
{
    if ([title isEqualToString:@"微信"]) {
        [TLWXManager wxShareWebPageWithScene:WXSceneSession
                                       title:self.CarModel.name
                                        desc:@""
                                         url:[NSString stringWithFormat:@"http://h5.htwt.hichengdai.com/vehicleDetail?code=%@",self.CarModel.code]];
        [TLWXManager manager].wxShare = ^(BOOL isSuccess, int errorCode) {
            
            if (isSuccess) {
                
                [TLAlert alertWithSucces:@"分享成功"];
            } else {
                
                [TLAlert alertWithError:@"分享失败"];
            }
        };
    }
    else
    {
        [TLWXManager wxShareWebPageWithScene:WXSceneTimeline
                                       title:self.CarModel.name
                                        desc:@""
                                         url:[NSString stringWithFormat:@"http://h5.htwt.hichengdai.com/vehicleDetail?code=%@",self.CarModel.code]];
        [TLWXManager manager].wxShare = ^(BOOL isSuccess, int errorCode) {
            
            if (isSuccess) {
                
                [TLAlert alertWithSucces:@"分享成功"];
            } else {
                
                [TLAlert alertWithError:@"分享失败"];
            }
        };
    }
    
    
    
}


-(void)collectclick{
    if ([self.CarModel.isCollect isEqualToString:@"0"]) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630460";
        http.showView = self.view;
        http.parameters[@"creater"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"toCode"] = self.CarModel.code;
        http.parameters[@"toType"] = @"0";
        http.parameters[@"type"] = @"3";
        [http postWithSuccess:^(id responseObject) {

            [TLProgressHUD showSuccessWithStatus:@"收藏成功"];
            self.RightButton.selected = !self.RightButton.selected;
            [self reloaddata];
//            [self getCarDeploy];
        } failure:^(NSError *error) {
            
        }];
    }else{
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630462";
        http.showView = self.view;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        http.parameters[@"carCode"] = self.CarModel.code;
        [http postWithSuccess:^(id responseObject) {
            [TLProgressHUD showSuccessWithStatus:@"取消收藏"];
            self.RightButton.selected = !self.RightButton.selected;
//            [self getCarDeploy];
            [self reloaddata];
        } failure:^(NSError *error) {
            
        }];
    }
}
-(void)ClickBottomBtn:(UIButton *)sender{
    if (sender.tag == 1) {
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",self.phonestring]]];
    }
    if (sender.tag == 2) {
        [UIView animateWithDuration:0.1 animations:^{
//            self.view.alpha = 0.6;
            callNowView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        }];
    }
}

-(void)askmoneyWithphone:(NSString *)phone name:(NSString *)name{
//    [NSUserDefaults standardUserDefaults]
    NSLog(@"%@",[USERDEFAULTS objectForKey:USER_ID]);
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630430";
    http.showView = self.view;
    http.parameters[@"carCode"] = self.CarModel.code;
    http.parameters[@"name"] = name;
    http.parameters[@"userMobile"] = phone;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    [http postWithSuccess:^(id responseObject) {
        callNowView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
        AskSuccessView * vc = [[AskSuccessView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        vc.delegate = self;
        [[USERXX user]showPopAnimationWithAnimationStyle:3 showView:vc BGAlpha:0.5 isClickBGDismiss:YES];
    } failure:^(NSError *error) {
        
    }];
}
-(void)deleteBtnClickDelegate{
    callNowView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight);
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
    if ([USERXX isBlankString:self.CarModel.carDealer[@"fullName"]] == YES) {
        return 4;
    }
    return 6;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        if ([USERXX isBlankString:self.CarModel.carDealer[@"fullName"]] == YES) {
            return 0;
        }
        return 1;
    }
    if (section == 2){
        return 3;
    }
    if (section == 3) {
        return 1;
    }
    if (section == 4) {
        return self.CarModelsCars.count;
    }
    return self.NewsModels.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *rid=@"CarInfoHead";
        CarInfoHeadCell *cell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(cell==nil){
            cell=[[CarInfoHeadCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        _cell = cell;
        cell.CarModel = [CarModel mj_objectWithKeyValues: self.CarModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.button addTarget:self action:@selector(goCalculator) forControlEvents:(UIControlEventTouchUpInside)];
        cell.dataArray = self.dataArray;
        return cell;
    }
    if (indexPath.section == 1) {
        CarDetailsDealersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarDetailsDealersCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.carDealer = [CarModel mj_objectWithKeyValues:self.CarModel.carDealer];
        return cell;
    }
    if (indexPath.section == 2) {
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
                if ([self.CarModel.procedure isEqualToString:@"0"]) {
                    cell.contentlab.text = @"齐全";
                }else
                {
                    cell.contentlab.text = @"不齐全";
                }
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
    if (indexPath.section == 3) {
        static NSString *rid=@"DeployFirst";
        deployFirstCell=[tableView dequeueReusableCellWithIdentifier:rid];
        if(deployFirstCell==nil){
            deployFirstCell=[[DeployFirstCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        
        deployFirstCell.carConfig = self.CarModel.carConfig;
        deployFirstCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return deployFirstCell;
    }
    
    if (indexPath.section == 4) {
        static NSString *rid=@"cell";
        
        classifyInfoCell=[tableView dequeueReusableCellWithIdentifier:rid];
        
        if(classifyInfoCell==nil){
            classifyInfoCell=[[ClassifyInfoCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:rid];
        }
        //    cell.carmodel = [CarModel mj_objectWithKeyValues: self.models.cars[indexPath.row]];
        classifyInfoCell.carmodel = [CarModel mj_objectWithKeyValues:self.CarModelsCars[indexPath.row]];
        //    cell.dataArray = self.dataArray;
        classifyInfoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return classifyInfoCell;
    }
    
    NewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.NewsModels[indexPath.row];
    cell.newstagDataAry = self.newstagDataAry;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if ([self.status isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else
        {
            DealersVC *vc = [DealersVC new];
            vc.dealersModel = [CarModel mj_objectWithKeyValues:self.CarModel.carDealer];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    
    if (indexPath.section == 4) {
        TLNetworking * http = [[TLNetworking alloc]init];
        http.code = @"630427";
        http.showView = self.view;
        http.parameters[@"code"] = self.CarModelsCars[indexPath.row].code;
        http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
        [http postWithSuccess:^(id responseObject) {
            CarInfoVC * vc = [CarInfoVC new];
            vc.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } failure:^(NSError *error) {
            
        }];

    }
    if (indexPath.section == 5) {
        NewsInfoVC * vc = [NewsInfoVC new];
        vc.code = self.NewsModels[indexPath.row].code;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)goCalculator{
    CalculatorVC * vc = [CalculatorVC new];
    vc.carcode = self.CarModel.code;
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return _cell.contentlab.yy + 15;
    }
    if (indexPath.section == 1) {
        return 78;
    }
    if (indexPath.section == 2) {
        return 45;
    }
    if (indexPath.section == 3) {
        return deployFirstCell.contentlab.yy + 10;
    }
    if (indexPath.section == 4) {
        return classifyInfoCell.v1.yy;
    }
    return 105;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        if ([USERXX isBlankString:self.CarModel.carDealer[@"fullName"]] == NO) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52.5)];
            view.backgroundColor = kWhiteColor;
            UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
            v1.backgroundColor = kBackgroundColor;
            [view addSubview:v1];
            return view;
        }
        
    }
    if (section == 2 || section == 3 || section == 4 || section == 5) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 52.5)];
        view.backgroundColor = kWhiteColor;
        UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
        v1.backgroundColor = kBackgroundColor;
        [view addSubview:v1];
        
        UIView * v2 = [[UIView alloc]initWithFrame:CGRectMake(15, 25, 3, 15)];
        kViewRadius(v2, 1.5);
        v2.backgroundColor = kHexColor(@"#F89C44");
        [view addSubview:v2];
        UILabel * label = [UILabel labelWithFrame:CGRectMake(v2.xx + 5, v1.yy + 10, 100, 25) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(16) textColor:kBlackColor];
        if (section == 2) {
            label.text = @"库存信息";
        }
        else if (section == 3){
            label.text = @"配置";
        }else if (section == 4)
        {
            label.text = @"店内推荐";
        }else
        {
            label.text = @"店内动态";
        }
        [view addSubview:label];
        return view;
    }else
        return [UIView new];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return  0.001;
    }else if(section == 1)
    {
        if ([USERXX isBlankString:self.CarModel.carDealer[@"fullName"]] == NO) {
            return 10;
        }
        return 0.01;
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


- (void)loadData
{
    TLNetworking *http = [TLNetworking new];
    http.code = TheCalculatorURL;
    http.showView = self.view;
    http.parameters[@"limit"] = @"20";
    http.parameters[@"start"] = @"1";
    http.parameters[@"ckey"] = @"kf_phone";
    http.parameters[@"orderDir"] = @"asc";
    [http postWithSuccess:^(id responseObject) {
        self.phonestring = responseObject[@"data"][@"list"][0][@"cvalue"];
    } failure:^(NSError *error) {
        
    }];
}

//浏览
-(void)setHistory{
    
    if ([USERXX isBlankString:[USERDEFAULTS objectForKey:USER_ID]] == YES) {
        return;
    }
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630460";
    http.showView = self.view;
    http.parameters[@"creater"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"toCode"] = self.CarModel.code;
    http.parameters[@"toType"] = @"0";
    http.parameters[@"type"] = @"1";
    [http postWithSuccess:^(id responseObject) {

        
        
    } failure:^(NSError *error) {

    }];
}


-(void)reloaddata{
    TLNetworking * http = [[TLNetworking alloc]init];
    http.code = @"630427";
    http.showView = self.view;
    http.parameters[@"userId"] = [USERDEFAULTS objectForKey:USER_ID];
    http.parameters[@"code"] = self.CarModel.code;
    [http postWithSuccess:^(id responseObject) {
        self.CarModel = [CarModel mj_objectWithKeyValues:responseObject[@"data"]];
        
        if ([USERXX isBlankString:self.CarModel.carDealer[@"code"]] == NO) {
            [self carsLoadData];
            [self NewsLoadData];
            [self car_news_tag];
        }
        [self.tableview reloadData_tl];
    } failure:^(NSError *error) {
        
    }];
}


#pragma mark - 获取数据   资讯
-(void)NewsLoadData{
    MinicarsLifeWeakSelf;
    
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630455";
    http.parameters[@"status"] = @"1";
    http.parameters[@"carDealerCode"] = self.CarModel.carDealer[@"code"];
    http.parameters[@"orderDir" ]=@"asc";
    http.parameters[@"start"] = @"1";
    http.parameters[@"limit"] = @"100";
    [http postWithSuccess:^(id responseObject) {
        //        headview.CarBrandModels = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        //        [self modifyFrame];
        weakSelf.NewsModels = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        weakSelf.tableView.NewsModels = weakSelf.NewsModels;

        [weakSelf.tableview reloadData];
        
    } failure:^(NSError *error) {
        
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
//        self.tableView.newstagDataAry = self.newstagDataAry;
        [self.tableview reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}

-(void)carsLoadData
{
    
    //精选车源
    TLNetworking * http2 = [[TLNetworking alloc]init];
    http2.showView = self.view;
    http2.code = @"630425";
    http2.parameters[@"carDealerCode"] = self.CarModel.carDealer[@"code"];
    http2.parameters[@"status"] = @"1";
    http2.parameters[@"start"] = @"0";
    http2.parameters[@"limit"] = @"100";
    [http2 postWithSuccess:^(id responseObject) {
//        self.headView.carsTotalCount = [responseObject[@"data"][@"totalCount"] integerValue];
        self.CarModelsCars = [CarModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        self.tableView.CarModelsCars = self.CarModelsCars;
        [self.tableview reloadData];
        
        
    } failure:^(NSError *error) {
        
    }];
}




-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

@end
