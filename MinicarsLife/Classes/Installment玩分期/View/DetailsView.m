//
//  DetailsView.m
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/5.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import "DetailsView.h"

@implementation DetailsView
{
    UIImageView *img;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 123, SCREEN_HEIGHT/2 - 200, 246, 400)];
        scrollView.backgroundColor = kWhiteColor;
        kViewRadius(scrollView, 4);
        [self addSubview:scrollView];
        
        img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 123, SCREEN_HEIGHT/2 - 200, 246, 400)];
//        img.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:img];
        
        
        
        UIButton *ShutDown = [UIButton buttonWithType:(UIButtonTypeCustom)];
        ShutDown.frame = CGRectMake(SCREEN_WIDTH/2 - 11, scrollView.yy + 34, 22, 22);
        [ShutDown setImage:kImage(@"关闭弹框") forState:(UIControlStateNormal)];
        [ShutDown addTarget:self action:@selector(ShutDownClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:ShutDown];
        
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    [img sd_setImageWithURL:[NSURL URLWithString:[url convertImageUrl]]];
}

-(void)ShutDownClick
{
    [[USERXX user].cusPopView dismiss];
}

@end
