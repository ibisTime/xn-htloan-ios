//
//  repaymentListV.m
//  htloan
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "repaymentListV.h"
//Category
#import "NSString+Date.h"
//V
#import "repaymentListCell.h"
//C
#import "repaymentDetailVC.h"

//Category 响应者链
#import "UIView+Responder.h"


@interface repaymentListV()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation repaymentListV

static NSString *identifierCell = @"repaymentListCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerClass:[repaymentListCell class] forCellReuseIdentifier:identifierCell];
    }
    
    return self;
}

#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.news.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    repaymentListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    
    cell.isNewRepayment = self.isNewRepayment;
    repaymentModel *new = self.news[indexPath.section];
    
//    new.isShowDate = [self isShowDateWithIndexPath:indexPath];
    
    cell.repaymentModel = new;
    
    return cell;
}

//- (BOOL)isShowDateWithIndexPath:(NSIndexPath *)indexPath {
//
//    //第一个直接
//    if (indexPath.section == 0) {
//
//        return NO;
//    }
//    //后面的时间跟前面比对
//    NewsFlashModel *new1 = self.news[indexPath.section - 1];
//    NewsFlashModel *new2 = self.news[indexPath.section];
//
//    NSString *day1 = [new1.showDatetime convertDateWithFormat:@"d"];
//    NSString *day2 = [new2.showDatetime convertDateWithFormat:@"d"];
//
//    if ([day1 integerValue] == [day2 integerValue]) {
//
//        return YES;
//    }
//
//    return NO;
//}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //
  repaymentDetailVC* detOfCarVC = [[repaymentDetailVC alloc ] init ];
    
//    detOfCarVC.code = self.cell.carShowModel.code;
    [self.viewController.navigationController pushViewController:detOfCarVC animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    return self.news[indexPath.section].cellHeight;
    return  70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    return [UIView new];
}

//#pragma mark - Events
//- (void)clickShare:(UIButton *)sender {
//    
//    NSInteger index = sender.tag - 2000;
//    
//    if (self.refreshDelegate && [self.refreshDelegate respondsToSelector:@selector(refreshTableViewButtonClick:button:selectRowAtIndex:)]) {
//        
//        [self.refreshDelegate refreshTableViewButtonClick:self button:sender selectRowAtIndex:index];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
