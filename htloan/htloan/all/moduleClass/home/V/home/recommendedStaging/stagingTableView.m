//
//  stagingTableView.m
//  htloan
//
//  Created by apple on 2018/4/18.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "stagingTableView.h"

//v
#import "stagingCell.h"
#import "stagingHeadView.h"
//m
#import "stagingModel.h"

@interface stagingTableView()<UITableViewDataSource, UITableViewDelegate>


@end
@implementation stagingTableView
static NSString *identifierCell = @"stagingCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        //设置diali和数据源
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = kClearColor;
        //        self.backgroundColor = [UIColor redColor];
        
        //注册cell
        [self registerClass:[stagingCell class] forCellReuseIdentifier:identifierCell];
        
        
        //适配
        if (@available(iOS 11.0, *)) {
            
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
//    return self.mineGroup.sections.count;
        return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
//    self.mineGroup.items = self.mineGroup.sections[section];
    
//    return self.mineGroup.items.count;
//    return self.stagings.count;
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    stagingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    //样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    cell.staModel=self.stagings[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    self.mineGroup.items = self.mineGroup.sections[indexPath.section];
//
//    if (self.mineGroup.items[indexPath.row].action) {
//
//        self.mineGroup.items[indexPath.row].action();
//    }
//
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 115;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
        return 50;
//    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView * head =[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    head.backgroundColor = [UIColor clearColor];
    
    stagingHeadView * header = [[stagingHeadView alloc] initWithFrame:CGRectMake(0, 10, kScreenWidth, 40)];
    header.backgroundColor =kWhiteColor;
    [head addSubview:header];
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
        return 0.1;
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
