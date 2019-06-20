//
//  MessageInfoVC.m
//  MinicarsLife
//
//  Created by 梅敏杰 on 2019/3/14.
//  Copyright © 2019年 QinBao Zheng. All rights reserved.
//

#import "MessageInfoVC.h"

@interface MessageInfoVC ()

@end

@implementation MessageInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息详情";
    
    UILabel * title = [UILabel labelWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:boldFont(18) textColor:kBlackColor];
    title.numberOfLines = 0;
    title.text = self.model.title;
    [self.view addSubview:title];
    
    UILabel * content = [UILabel labelWithFrame:CGRectMake(15, title.yy + 15, SCREEN_WIDTH - 30, 0) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:Font(16) textColor:kBlackColor];
    content.numberOfLines = 0;
    
    if ([self.model.content hasPrefix:@"<p>"]) {
        NSRange startRange = [self.model.content rangeOfString:@"<p>"];
        NSRange endRange = [self.model.content rangeOfString:@"</p>"];
        NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        NSString * con = [self.model.content substringWithRange:range];
        content.text = con;
    }else
    {
        content.text = self.model.content;
    }
    
//    content.text = self.model.content;
    
    
    [content sizeToFit];
    content.frame = CGRectMake(15, title.yy + 15, SCREEN_WIDTH - 30, content.height);
    [self.view addSubview:content];
}



@end
