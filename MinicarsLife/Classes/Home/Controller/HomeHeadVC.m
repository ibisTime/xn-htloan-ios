//
//  HomeHeadVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "HomeHeadVC.h"

@interface HomeHeadVC ()<HW3DBannerViewDelegate>
@property (nonatomic , strong)HW3DBannerView *scrollView;
@end

@implementation HomeHeadVC


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self bannerLoadData];
        [self addSubview:self.scrollView];
        [self createbtn];
    }
    return self;
}


#pragma mark -- 滑动试图懒加载
-(HW3DBannerView *)scrollView
{
    if (!_scrollView) {
        MJWeakSelf;
        _scrollView = [HW3DBannerView initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/2) imageSpacing:0 imageWidth:SCREEN_WIDTH];
        _scrollView.userInteractionEnabled=YES;
        _scrollView.autoScrollTimeInterval = 3;
        _scrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
        
        _scrollView.clickImageBlock = ^(NSInteger currentIndex) {
//            NSLog(@"%ld",currentIndex);
            [weakSelf clickImage:currentIndex];
        };
        _scrollView.delegate = self;
    }
    return _scrollView;
}

#pragma mark - 八个按钮
-(void)createbtn{
    NSArray * titlearray = @[@"30-50万",@"50-70万",@"70万以上",@"更多",@"奔驰",@"保时捷",@"丰田",@"奥迪"];
//    NSArray * logoarray = @[@"",@"",@"",@"",@"",@"",@"",@"",];

    for (int j = 0; j < 4; j ++) {
        UIButton * button = [UIButton buttonWithTitle:titlearray[j] titleColor:kBlackColor backgroundColor:kClearColor titleFont:13 cornerRadius:0];
        button.tag = j;
        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/4 * j, self.scrollView.yy + 17, (SCREEN_WIDTH-30)/4, 16.5);
        
        if (j < 3) {
            UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15 + (SCREEN_WIDTH-30)/4 * (j+1), self.scrollView.yy + 15, 1, 20)];
            v1.backgroundColor = kLineColor;
            [self addSubview:v1];
        }
        [self addSubview:button];
    }
    for (int j = 0; j < 4; j ++) {
        UIButton * button = [UIButton buttonWithTitle:titlearray[j + 4] titleColor:kBlackColor backgroundColor:kClearColor titleFont:13 cornerRadius:0];
        button.tag = j + 4;
        [button addTarget:self action:@selector(clickbtn:) forControlEvents:(UIControlEventTouchUpInside)];
        button.frame = CGRectMake(15 + (SCREEN_WIDTH-30)/4 * j, self.scrollView.yy + 3.5 + 50, (SCREEN_WIDTH-30)/4, 20);
        [self addSubview:button];
        
        if (j < 3) {
            UIView * v1 = [[UIView alloc]initWithFrame:CGRectMake(15 + (SCREEN_WIDTH-30)/4 * (j+1), self.scrollView.yy + 3.5 + 50, 1, 30)];
            v1.backgroundColor = kLineColor;
            [self addSubview:v1];
        }
    }
    
    
}


#pragma mark - 点击事件
-(void)clickbtn:(UIButton *)sender{
    
}
- (void)clickImage:(NSInteger)inter
{
    
    
}
-(void)HW3DBannerViewClick:(NSInteger)currentImageIndex{
//    NSLog(@"%ld",currentImageIndex);
}

#pragma mark - 获取数据

-(void)bannerLoadData
{
    //    MinicarsLifeWeakSelf;
    TLNetworking *http = [TLNetworking new];
    http.code = @"805806";
    http.parameters[@"location"] = @"index_banner";
    http.showView = self;
    
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
