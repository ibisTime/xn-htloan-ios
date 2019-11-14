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
    
    
}



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        scrollView.backgroundColor = kWhiteColor;
        kViewRadius(scrollView, 4);
        self.scrollView = scrollView;
        [self addSubview:scrollView];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 123, SCREEN_HEIGHT/2 - 200, 246, 400)];
//        img.contentMode = UIViewContentModeScaleAspectFit;
        _imageView = img;
        [self addSubview:img];
        
        
        scrollView.minimumZoomScale=0.5;
        scrollView.maximumZoomScale=6.0;
        scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        scrollView.delegate=self;
        
        [scrollView addSubview:img];

        
        
//        UIButton *ShutDown = [UIButton buttonWithType:(UIButtonTypeCustom)];
//        ShutDown.frame = CGRectMake(SCREEN_WIDTH/2 - 11, scrollView.yy + 34, 22, 22);
//        [ShutDown setImage:kImage(@"关闭弹框") forState:(UIControlStateNormal)];
//        [ShutDown addTarget:self action:@selector(ShutDownClick) forControlEvents:(UIControlEventTouchUpInside)];
//        [self addSubview:ShutDown];
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTap:)];
        
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        
        [self addGestureRecognizer:singleTapGestureRecognizer];
    }
    return self;
}

-(void)singleTap:(UITapGestureRecognizer *)tap
{
    [[USERXX user].cusPopView dismiss];
}

- (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView withScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    // The zoom rect is in the content view's coordinates.
    // At a zoom scale of 1.0, it would be the size of the
    // imageScrollView's bounds.
    // As the zoom scale decreases, so more content is visible,
    // the size of the rect grows.
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


//- (void)doubleTapGesture:(UITapGestureRecognizer *)tap
//{
//    if (self.scrollView.zoomScale > _minimumZoomScale) {// 已经放大 现在缩小
//        [self.scrollView setZoomScale:_minimumZoomScale animated:YES];
//    }
//    else {
//        // 已经缩小 现在放大
//        CGPoint point = [tap locationInView:self.scrollView];
//        //        [self zoomScrollView:self.scrollView toPoint:point withScale:_maximumZoomScale animated:YES];
//        // 方法一 以point为中心点进行放大
//        CGRect zoomRect = [self zoomRectForScrollView:scrollView withScale:_maximumZoomScale withCenter:point];
//        [self.scrollView zoomToRect:zoomRect animated:YES];
//        // 方法二 也可以通过这种方法 来放大 这种是直接放大 以scrollView的中心点
//        //        [self.scrollView setZoomScale:_maximumZoomScale animated:YES];
//    }
//}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat scrollW = CGRectGetWidth(scrollView.frame);
    CGFloat scrollH = CGRectGetHeight(scrollView.frame);
    
    CGSize contentSize = scrollView.contentSize;
    CGFloat offsetX = scrollW > contentSize.width ? (scrollW - contentSize.width) * 0.5 : 0;
    CGFloat offsetY = scrollH > contentSize.height ? (scrollH - contentSize.height) * 0.5 : 0;
    
    CGFloat centerX = contentSize.width * 0.5 + offsetX;
    CGFloat centerY = contentSize.height * 0.5 + offsetY;
    
    self.imageView.center = CGPointMake(centerX, centerY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

-(void)setUrl:(NSString *)url
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:[url convertImageUrl]]];
}

-(void)ShutDownClick
{
    [[USERXX user].cusPopView dismiss];
}

@end
