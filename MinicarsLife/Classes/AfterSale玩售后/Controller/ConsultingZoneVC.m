//
//  ConsultingZoneVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/5.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ConsultingZoneVC.h"

@interface ConsultingZoneVC ()
{
    CGFloat y;
}

@end

@implementation ConsultingZoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - kNavigationBarHeight)];
    [self.view addSubview:scrollView];
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630597";
    http.parameters[@"type"] = self.type;
    [http postWithSuccess:^(id responseObject) {
        NSArray *dataAry = responseObject[@"data"];
        for (int i = 0; i < dataAry.count; i ++) {
            UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, y + 23.5, 16, 16)];
            iconImg.image= kImage(@"问题分类");
            [scrollView addSubview:iconImg];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 3.5 , y + 20 , SCREEN_WIDTH - iconImg.xx - 3.5 - 15, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#333333")];
            nameLbl.text = dataAry[i][@"inquiry"];
            [scrollView addSubview:nameLbl];
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, nameLbl.yy + 10,  SCREEN_WIDTH - 30, 40)];
            backView.backgroundColor = kHexColor(@"#F7F7F7");
            [scrollView addSubview:backView];
            
            UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(15, 10, SCREEN_WIDTH - 60, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
            contentLbl.numberOfLines = 0;
            contentLbl.text = dataAry[i][@"answer"];
            [contentLbl sizeToFit];
            contentLbl.frame = CGRectMake(15, 10, SCREEN_WIDTH - 60, contentLbl.height);
            
            backView.frame = CGRectMake(15, nameLbl.yy + 10,  SCREEN_WIDTH - 30, contentLbl.height + 20);
            [backView addSubview:contentLbl];
            y = backView.yy;
            
            scrollView.contentSize = CGSizeMake(0, y + 10);
        }
        
    } failure:^(NSError *error) {
        
    }];
    
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
