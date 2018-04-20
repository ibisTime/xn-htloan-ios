//
//  XIMineVC.m
//  htloan
//
//  Created by apple on 2018/4/16.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XIMineVC.h"
//Manager
#import "TLUploadManager.h"
//Macro
#import "APICodeMacro.h"
#import "AppMacro.h"
//Category
#import "NSString+Extension.h"
#import "UIBarButtonItem+convience.h"
//Extension
#import <UIImageView+WebCache.h>
#import "TLProgressHUD.h"
#import "NSString+Check.h"
#import <MBProgressHUD.h>
//M
#import "MineGroup.h"
////V
#import "MineTableView.h"
#import "MineHeaderView.h"
#import "TLImagePicker.h"
#import "BaseView.h"
////C
#import "HTMLStrVC.h"
#import "NavigationController.h"
#import "TLUserLoginVC.h"
#import "UserDetailEditVC.h"
#import "XIMyApplyForVC.h"
//#import "CircleCommentVC.h"
//#import "MyCollectionListVC.h"

@interface XIMineVC ()<MineHeaderSeletedDelegate>
//模型
@property (nonatomic, strong) MineGroup *group;
@property (nonatomic, strong) MineGroup *items;

//退出登录
//@property (nonatomic, strong) BaseView *logoutView;
//
@property (nonatomic, strong) MineTableView *tableView;
//头部
@property (nonatomic, strong) MineHeaderView *headerView;
//选择头像
@property (nonatomic, strong) TLImagePicker *imagePicker;
@end

@implementation XIMineVC

//-(void)viewWillAppear:(BOOL)animated {
//
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//
//}
//-(void)viewWillDisappear:(BOOL)animated{
//
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
self.view.backgroundColor =XIMineBackGroundColor;
    //
//    [self hidNav];
    self.title = @"我的";

    //通知
    [self addNotification];
 
    
    [self initTableView];

    [self initGroup];
    //
   [self changeInfo];

}
//-(void)hidNav{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"我的背景"] forBarMetrics:UIBarMetricsDefault];
//
//    self.title = @"我的";
//}





#pragma mark - Notification
- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInfo) name:kUserLoginNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeInfo) name:kUserInfoChange object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut) name:kUserLoginOutNotification object:nil];
}
#pragma mark - Events
- (void)changeInfo {
    //
    [self.headerView.userPhoto sd_setImageWithURL:[NSURL URLWithString:[[TLUser user].photo convertImageUrl]] placeholderImage:USER_PLACEHOLDER_SMALL];
    
    if (![TLUser user].isLogin) {
        
        [self.headerView.nameBtn setTitle:@"快速登录" forState:UIControlStateNormal];
        self.tableView.tableFooterView.hidden = YES;
        self.navigationItem.rightBarButtonItem = nil;
        
    } else {
        
        [self.headerView.nameBtn setTitle:[TLUser user].nickname forState:UIControlStateNormal];
        
        self.tableView.tableFooterView.hidden = NO;
        //编辑
        [self addEditItem];
    }
}
/**
 登入
 */

- (void)loginOut {
    
    [self.headerView.nameBtn setTitle:@"快速登录" forState:UIControlStateNormal];
    
    self.headerView.userPhoto.image = USER_PLACEHOLDER_SMALL;
    self.navigationItem.rightBarButtonItem = nil;
}

/**
 判断用户是否登录
 */
- (void)checkLogin:(void(^)(void))loginSuccess {
    
    if(![TLUser user].isLogin) {
        
        TLUserLoginVC *loginVC = [TLUserLoginVC new];
        
        loginVC.loginSuccess = loginSuccess;
        
        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:nav animated:YES completion:nil];
        return ;
    }
    
    if (loginSuccess) {
        
        loginSuccess();
    }
}

- (void)logout {
    
    [TLAlert alertWithTitle:@"" msg:@"是否确认退出" confirmMsg:@"确认" cancleMsg:@"取消" cancle:^(UIAlertAction *action) {
        
    } confirm:^(UIAlertAction *action) {
        
        self.tableView.tableFooterView.hidden = YES;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kUserLoginOutNotification object:nil];
    }];
    
}

/**
 编辑资料
 */
- (void)editInfo {
    
    BaseWeakSelf;
    
    [self checkLogin:^{
        
        UserDetailEditVC *editVC = [UserDetailEditVC new];
        
        [weakSelf.navigationController pushViewController:editVC animated:YES];
    }];
}


#pragma mark - Init
- (void)addEditItem {
    
    [UIBarButtonItem addRightItemWithTitle:@"编辑"
                                titleColor:kWhiteColor
                                     frame:CGRectMake(0, 0, 60, 40)
                                        vc:self
                                    action:@selector(editInfo)];
}



//修改头像
- (TLImagePicker *)imagePicker {
    
    if (!_imagePicker) {
        
        BaseWeakSelf;
        
        _imagePicker = [[TLImagePicker alloc] initWithVC:self];
        
        _imagePicker.allowsEditing = NO;
        _imagePicker.clipHeight = kScreenWidth;
        
        _imagePicker.pickFinish = ^(UIImage *photo, NSDictionary *info){
            
            UIImage *image = info == nil ? photo: info[@"UIImagePickerControllerOriginalImage"];
            
            NSData *imgData = UIImageJPEGRepresentation(image, 0.1);
            
            //进行上传
            [TLProgressHUD show];
            
            TLUploadManager *manager = [TLUploadManager manager];
            
            manager.imgData = imgData;
            manager.image = image;
            
            [manager getTokenShowView:weakSelf.view succes:^(NSString *key) {
                
                [weakSelf changeHeadIconWithKey:key imgData:imgData];
                
            } failure:^(NSError *error) {
                
            }];
        };
    }
    
    return _imagePicker;
}
#pragma mark - Data
//修改头像
- (void)changeHeadIconWithKey:(NSString *)key imgData:(NSData *)imgData {
    
    TLNetworking *http = [TLNetworking new];
    
    //    http.showView = self.view;
    http.code = USER_CHANGE_USER_PHOTO;
    http.parameters[@"userId"] = [TLUser user].userId;
    http.parameters[@"photo"] = key;
    http.parameters[@"token"] = [TLUser user].token;
    [http postWithSuccess:^(id responseObject) {
        
        [TLProgressHUD dismiss];
        
        [TLAlert alertWithSucces:@"修改头像成功"];
        
        [TLUser user].photo = key;
        //替换头像
        [self.headerView.userPhoto sd_setImageWithURL:[NSURL URLWithString:[key convertImageUrl]] placeholderImage:USER_PLACEHOLDER_SMALL];
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)initGroup {
    
    BaseWeakSelf;
    
    //
    MineModel *IntegralAccount = [MineModel new];
    
    IntegralAccount.text = @"积分账户";
    IntegralAccount.imgName = @"积分账户";
    IntegralAccount.action = ^{
        
//        [weakSelf checkLogin:^{
//
//            MyCollectionListVC *collectionVC = [MyCollectionListVC new];
//
//            [weakSelf.navigationController pushViewController:collectionVC animated:YES];
//        }];
    };
    
    //圈子评论
    MineModel *creditReport = [MineModel new];
    
    creditReport.text = @"信用报告";
    creditReport.imgName = @"信用报告";
    creditReport.action = ^{
        
//        [weakSelf checkLogin:^{
//
//            CircleCommentVC *commentVC = [CircleCommentVC new];
//
//            [weakSelf.navigationController pushViewController:commentVC animated:YES];
//        }];
    };
    //资讯评论
    MineModel *MyNews = [MineModel new];
    
    MyNews.text = @"我的消息";
    MyNews.imgName = @"消息";
    MyNews.action = ^{
        
//        [weakSelf checkLogin:^{
//
//            InfoCommentVC *commentVC = [InfoCommentVC new];
//
//            [weakSelf.navigationController pushViewController:commentVC animated:YES];
//        }];
    };
    //资讯评论
    MineModel *myApplyFor = [MineModel new];
    
    myApplyFor.text = @"我的车贷申请";
    myApplyFor.imgName = @"车贷申请";
    myApplyFor.action = ^{
        
//                [weakSelf checkLogin:^{
        
                    XIMyApplyForVC *myApplyForVC = [XIMyApplyForVC new];
        
                    [weakSelf.navigationController pushViewController:myApplyForVC animated:YES];
//}];

        
//                }];
    };
   
    //
    MineModel *CommonProblems = [MineModel new];
    
    CommonProblems.text = @"常见问题";
    CommonProblems.imgName = @"常见问题";
    CommonProblems.action = ^{
        
        //        [weakSelf checkLogin:^{
        //
        //            InfoCommentVC *commentVC = [InfoCommentVC new];
        //
        //            [weakSelf.navigationController pushViewController:commentVC animated:YES];
        //        }];
    };
    
    
    //
    MineModel *ContactCustomerService = [MineModel new];
    
    ContactCustomerService.text = @"联系客服";
    ContactCustomerService.imgName = @"联系客服";
    ContactCustomerService.action = ^{
        
//        [weakSelf checkLogin:^{
        
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://10086"]];
//                }];
    };
    


    
    //关于
    MineModel *aboutUs = [MineModel new];
    
    aboutUs.text = @"关于我们";
    aboutUs.imgName = @"关于我们";
    aboutUs.action = ^{
        
        HTMLStrVC *htmlVC = [[HTMLStrVC alloc] init];
        
        htmlVC.type = HTMLTypeAboutUs;
        
        [weakSelf.navigationController pushViewController:htmlVC animated:YES];
    };
    
    //传
    self.group = [MineGroup new];
    
    self.group.sections = @[@[IntegralAccount, creditReport], @[MyNews,myApplyFor],@[CommonProblems,ContactCustomerService],@[aboutUs]];
    
    self.tableView.mineGroup = self.group;
    
    [self.tableView reloadData];
}

- (void)initTableView {
    //headerview背景图片
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth,XIImageHeight)];

    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.image = kImage(@"我的背景");
   imageView.backgroundColor =kAppCustomMainColor;
    imageView.tag = 1500;
//    imageView.backgroundColor = kAppCustomMainColor;
  
    [self.view addSubview:imageView];
    
    
    self.tableView = [[MineTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kTabBarHeight) style:UITableViewStyleGrouped];
    
 //   self.tableView.tableFooterView = self.logoutView;
    
    [self.view addSubview:self.tableView];
    
    //d顶部个人信息
//    self.headerView = [[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 150)];
    self.headerView =[[MineHeaderView alloc] initWithFrame:CGRectMake(0, 0,kScreenWidth , XIImageHeight)];
    self.headerView.delegate = self;
    self.headerView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headerView;
    
}


#pragma mark - MineHeaderSeletedDelegate
- (void)didSelectedWithType:(MineHeaderSeletedType)type idx:(NSInteger)idx {
    
    switch (type) {
        case MineHeaderSeletedTypeLogin:
        {
            [self checkLogin:nil];
        }break;
        default:
            break;
    }
}




/**
 VC被释放时移除通知
 */
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



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
