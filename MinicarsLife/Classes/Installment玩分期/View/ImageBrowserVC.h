//
//  ImageBrowserVC.h
//  MinicarsLife
//
//  Created by 郑勤宝 on 2019/11/12.
//  Copyright © 2019 QinBao Zheng. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 * 跳转方式
 */
typedef NS_ENUM(NSUInteger,PhotoBroswerVCType) {
    
    //modal
    PhotoBroswerVCTypePush=0,
    
    //push
    PhotoBroswerVCTypeModal,
    
    //zoom
    PhotoBroswerVCTypeZoom,
};

NS_ASSUME_NONNULL_BEGIN

@interface ImageBrowserVC : UIViewController
/**
 *  显示图片
 */
+(void)show:(UIViewController *)handleVC type:(PhotoBroswerVCType)type index:(NSUInteger)index imagesBlock:(NSArray *(^)())imagesBlock;
@end

NS_ASSUME_NONNULL_END
