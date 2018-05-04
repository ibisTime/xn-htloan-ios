//
//  detailsOfCarVC.m
//  htloan
//
//  Created by apple on 2018/4/23.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "detailsOfCarVC.h"
//C
#import "calculatorVC.h"
//m
#import "carImgModel.h"

//V
#import "CircleGuideView.h"
#import "CarTextImgV.h"
#import "CarTextV.h"

@interface detailsOfCarVC ()<UIScrollViewDelegate>
//m
@property (nonatomic, strong) carImgModel * carImgM;
@property (nonatomic, strong) NSArray<NSString*>*carImgName;
//TLPageDataHelper
@property (nonatomic, strong) TLPageDataHelper *flashHelper;
//v
@property (nonatomic, strong) CircleGuideView *carView;
@property (nonatomic, strong) CarTextV *carTextV;
@property (nonatomic, strong) CarTextImgV *carTextImgV;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat height;
@end

@implementation detailsOfCarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"车辆详情";
    self.view.backgroundColor = kMineBackGroundColor;
   
    self.scrollView= [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview: self.scrollView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.contentSize = CGSizeMake(kScreenWidth,1000);
    });
    
//    self.scrollView.delegate =self;

//     [self addTapGestureRecognizer];
    //init
    [self initCarImgS];
    
    [self initText];
    
    [self initcarTextImgV];
    
    //s
    [self requestCarShowList];
    //刷新
    
    UIButton *butt =[UIButton buttonWithTitle:@"申请购买" titleColor:kWhiteColor backgroundColor:kAppCustomMainColor titleFont:16 cornerRadius:5];
    [self.scrollView addSubview:butt];
    butt.backgroundColor = kAppCustomMainColor;
    [butt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carTextImgV.mas_bottom).offset(10);
        make.left.equalTo(self.scrollView.mas_left).offset(15);
        make.right.equalTo(self.scrollView.mas_right).offset(-15);
    }];
    [butt addTarget:self action:@selector(applyToBuy) forControlEvents:UIControlEventTouchUpInside];
    

}

#pragma mark - envent
-(void)applyToBuy
{
    NSLog(@"点击购买");
    calculatorVC * calVC = [[calculatorVC alloc ] init];
    [self.navigationController pushViewController:calVC animated:YES];
    
}

#pragma mark - init
-(void)initCarImgS
{

    
    self.carView =[[CircleGuideView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 270)];
    self.carView.backgroundColor= kWhiteColor;
    
   
    
    [self.scrollView addSubview:self.carView];
    
    
    
}


-(void)initText
{
    self.carTextV = [[CarTextV alloc]init];
    self.carTextV.backgroundColor = kWhiteColor;
    
    [self.scrollView addSubview:self.carTextV];
    [self.carTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carView.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.equalTo(@120);
    }];
}
// appendAttributedText
- (void)initcarTextImgV
{        self.carTextImgV= [[CarTextImgV alloc] init];
    
    self.carTextImgV.backgroundColor =kWhiteColor ;
    [self.scrollView addSubview:self.carTextImgV];
    [self.carTextImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
   make.top.equalTo(self.carTextV.mas_bottom).offset(kPublicMargin);
        make.height.equalTo(@470);
        make.width.equalTo(self.view.mas_width);
    }];
    
}





#pragma mark - Data
- (void)requestCarShowList {
//    BaseWeakSelf;

    TLNetworking *http = [TLNetworking new];

        http.code = @"630427";

      http.parameters[@"code"] = self.code;


    [http postWithSuccess:^(id responseObject) {

//        [TLProgressHUD dismiss];

//        [TLAlert alertWithSucces:@"图片刷新成功"];


        NSDictionary*adDict=responseObject[@"data"];

//       self. carImgM = [carImgModel mj_objectWithKeyValues:adDict];
        self.carImgM = [carImgModel tl_objectWithDictionary :adDict];
NSString * advpic= self.carImgM.advPic;
        NSArray<NSString*>*carImgName=  [advpic componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"|"]];
        
        self.carTextV.carText = [carImgModel tl_objectWithDictionary:adDict];
        
        self.carView.imageNames =@[@"img_01",@"img_02",@"img_03",@"img_04"];
//        self.carView.imageNames =carImgName;
        NSLog(@"!!!!!!!%@",carImgName);
        //隐藏页控制器
        self.carView.pageControl.hidden = YES;
        
    } failure:^(NSError *error) {


    }];


    
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//
//    if (scrollView.contentOffset.y <= 0) {
//        self.scrollView.contentOffset = CGPointMake(0, _height);
//    }
//
//
//
//}










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
