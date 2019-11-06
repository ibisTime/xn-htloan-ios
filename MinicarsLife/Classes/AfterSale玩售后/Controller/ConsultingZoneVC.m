//
//  ConsultingZoneVC.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/5.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "ConsultingZoneVC.h"

@interface ConsultingZoneVC ()

@end

@implementation ConsultingZoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TLNetworking * http = [[TLNetworking alloc]init];
    http.showView = self.view;
    http.code = @"630597";
    http.parameters[@"type"] = self.type;
    
    [http postWithSuccess:^(id responseObject) {
        NSArray *dataAry = responseObject[@"data"];
        for (int i = 0; i < dataAry.count; i ++) {
            UIImageView *iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(15, 23.5 + i % dataAry.count * 85, 16, 16)];
            iconImg.image= kImage(@"问题分类");
            [self.view addSubview:iconImg];
            
            UILabel *nameLbl = [UILabel labelWithFrame:CGRectMake(iconImg.xx + 3.5 + i % dataAry.count * 85, 20 , SCREEN_WIDTH - iconImg.xx - 3.5 - 15, 22.5) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kHexColor(@"#333333")];
            nameLbl.text = dataAry[i][@"inquiry"];
            [self.view addSubview:nameLbl];
            
            UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, nameLbl.yy + 10,  SCREEN_WIDTH - 30, 40)];
            backView.backgroundColor = kHexColor(@"#F7F7F7");
            [self.view addSubview:backView];
            
            UILabel *contentLbl = [UILabel labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 60, 40) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(14) textColor:kHexColor(@"#333333")];
            contentLbl.text = dataAry[i][@"answer"];
            [backView addSubview:contentLbl];
            
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
