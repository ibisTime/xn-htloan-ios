//
//  TaobaoVC.m
//  MinicarsLife
//
//  Created by shaojianfei on 2018/10/15.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TaobaoVC.h"
#import "ClaimsTableView.h"
#import "HomeModel.h"
@interface TaobaoVC ()<RefreshDelegate>
@property (nonatomic , strong)ClaimsTableView *tableView;
@property (nonatomic ,strong) MyModel *model;
@property (nonatomic ,strong) HomeModel *homeModel;

@property (nonatomic ,strong) UIImageView *image;
@end

@implementation TaobaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"淘宝";
//    [self initTableView];

 

}

- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
//    [self requestWith:@"token"];

    [self sure];
    

    
}

-(void)refreshTableViewButtonClick:(TLTableView *)refreshTableview button:(UIButton *)sender selectRowAtIndex:(NSInteger)index
{
    NSLog(@"点击确认");
}

- (void)sure
{
    
//    TLPageDataHelper *helper = [[TLPageDataHelper alloc] init];
//    helper.code = @"632932";
//    NSString *idno =  [USERDEFAULTS objectForKey:IDNO];
//
//    if (!idno) {
//        [TLAlert alertWithInfo:@"请先进行实名认证"];
//        return;
//    }
//    helper.parameters[@"idNo"] = idno;
//    helper.parameters[@"loginType"] = @"qr";
//    helper.isList = YES;
//    helper.isCurrency = NO;
//    helper.tableView = self.tableView;
//    [helper modelClass:[HomeModel class]];
//    MJWeakSelf;
//
//    [self.tableView addRefreshAction:^{
//        [helper refresh:^(NSMutableArray *objs, BOOL stillHave) {
//
//            NSLog(@"%@",objs);
//            NSString *data = objs[0];
//
//            NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
//            //        NSString * jsonString = @"";
//            NSLog(@"第一次接口");
//            NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
//            [weakSelf requestWith:dic[@"token"]];
//        } failure:^(NSError *error) {
//            NSLog(@"%@",error);
//        }];
//    }];
//    [self.tableView beginRefreshing];

//    return;
    TLNetworking *http1 = [TLNetworking new];
    http1.code = @"632932";
    NSString *idno =  [USERDEFAULTS objectForKey:IDNO];
    http1.parameters[@"idNo"] = idno;
    http1.parameters[@"loginType"] = @"qr";
    http1.parameters[@"customerName"] = [USERDEFAULTS objectForKey:NAME];

    NSLog(@"idno%@",idno);

    MJWeakSelf;
    [http1 postWithSuccess:^(id responseObject) {
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSLog(@"第一次接口");
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        [NSThread sleepForTimeInterval:1];
        [weakSelf requestWith:dic[@"token"]];
    } failure:^(NSError *error) {

    }];

}

- (void)requestWith: (NSString *)token
{
    TLNetworking *htt = [TLNetworking new];
    htt.code = @"632944";
    
  
    htt.parameters[@"tokendb"] = token;
    htt.parameters[@"bizType"] = @"taobao";

    
    [htt postWithSuccess:^(id responseObject) {
        
        NSString *data = responseObject[@"data"];
        NSString *strUrl = [data stringByReplacingOccurrencesOfString:@"\%" withString:@""];
        //        NSString * jsonString = @"";
        NSData *jsonData = [strUrl dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        NSString *image = dic[@"input"][@"value"];
         NSLog(@"第二次接口");
        if (image == nil) {
            [TLAlert alertWithInfo:@"链接超时"];

            return ;
        }
        // 将base64字符串转为NSData
        NSData *decodeData = [[NSData alloc] initWithBase64EncodedString:image options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        // 将NSData转为UIImage
        UIImage *decodedImage = [UIImage imageWithData: decodeData];
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50, SCREEN_WIDTH-200, 100)];
        image1.contentMode = UIViewContentModeScaleToFill;
        [self.view addSubview:image1];
        image1.image = decodedImage;
        [TLAlert alertWithInfo:@"请使用手机淘宝扫描登录"];

    } failure:^(NSError *error) {
        
    }];
    
    
}

- (void)initTableView {
    self.tableView = [[ClaimsTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-49 ) style:(UITableViewStylePlain)];
    self.tableView.refreshDelegate = self;
//    self.tableView.isTD = YES;

    self.tableView.backgroundColor = kBackgroundColor;
    [self.view addSubview:self.tableView];
}



@end
