//
//  MineTableView.m
//  Base_iOS
//
//  Created by XI on 2017/12/14.
//  Copyright © 2017年 XI. All rights reserved.
//

#import "MineTableView.h"
//Macro
#import "TLUIHeader.h"
#import "AppColorMacro.h"
//Category
#import <SDImageCache.h>
//V
#import "MineCell.h"

#define kHeaderImgHeight XIImageHeight

@interface MineTableView ()<UITableViewDataSource, UITableViewDelegate>
// 头像
@property (nonatomic, strong) UIImageView *headIV;
// 自定义添加的view
@property (nonatomic, strong) UIView *otherView;
// 放大比例
@property (nonatomic, assign) CGFloat scale;
// 手机号
@property (nonatomic, strong) UILabel *mobileLbl;

@end

@implementation MineTableView

static NSString *identifierCell = @"MineCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        //设置dialing和数据源
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = kClearColor;
//        self.backgroundColor = [UIColor redColor];
        
        //注册cell
        [self registerClass:[MineCell class] forCellReuseIdentifier:identifierCell];
        
        
        
        if (@available(iOS 11.0, *)) {
            
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.mineGroup.sections.count;
//    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.mineGroup.items = self.mineGroup.sections[section];
    
    return self.mineGroup.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //shuju
    self.mineGroup.items = self.mineGroup.sections[indexPath.section];
    cell.mineModel = self.mineGroup.items[indexPath.row];
    
//    cell.rightLabel.textColor = indexPath.row == 4 ? kThemeColor: kTextColor2;
    
//显示缓存
//    if (indexPath.row == 4) {
//
//        //获取缓存大小
//        NSInteger cacheSize = [SDImageCache sharedImageCache].getSize;
//
//        cell.rightLabel.text = [NSString stringWithFormat:@"%.1lf M",cacheSize/1024.0/1024.0];
//    }
//    cell.backgroundColor = [UIColor grayColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.mineGroup.items = self.mineGroup.sections[indexPath.section];
    
    if (self.mineGroup.items[indexPath.row].action) {
        
        self.mineGroup.items[indexPath.row].action();
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
//    return 10;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
//    return 0.1;
    return 0.1;
}

#pragma mark - UIScrollViewDelgate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
//    if (scrollView.contentOffset.y < 0) {
        // 高度拉伸
        CGFloat imgH = kHeaderImgHeight - offsetY;
        CGFloat imgW = kScreenWidth;
        
        UIView *imgView = [self.superview viewWithTag:1500];
//       offsetY * self.scale
        imgView.frame = CGRectMake(0,0, imgW, imgH);
        
//    }
    
    NSLog(@"%lf",offsetY);
}

@end
