
//  CalculatorTableView.m
//  htloan
//
//  Created by apple on 2018/4/19.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "CalculatorTableView.h"

#import "UILable+convience.h"

//v
#import "CalculatorCell.h"
@interface CalculatorTableView ()<UITableViewDataSource, UITableViewDelegate>
// 头像
@property (nonatomic, strong) UIImageView *headIV;
// 自定义添加的view
@property (nonatomic, strong) UIView *otherView;
// 放大比例
@property (nonatomic, assign) CGFloat scale;
// 手机号
@property (nonatomic, strong) UILabel *mobileLbl;



@end

@implementation CalculatorTableView
static NSString *identifierCell = @"calculatorCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    if (self = [super initWithFrame:frame style:style]) {
        //设置dialing和数据源
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = kClearColor;
        //        self.backgroundColor = [UIColor redColor];
        
        //注册cell
        [self registerClass:[CalculatorCell class] forCellReuseIdentifier:identifierCell];
        
//        [self  initApplyForCar];

        
        if (@available(iOS 11.0, *)) {
            
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        
    }
    return self;
}






#pragma mark - UITableViewDataSource;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.calculatorGounp.sections.count;
//        return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.calculatorGounp.items = self.calculatorGounp.sections[section];
    
    return self.calculatorGounp.items.count;
//    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CalculatorCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierCell forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //shuju
    self.calculatorGounp.items = self.calculatorGounp.sections[indexPath.section];
    cell.calculatorModel = self.calculatorGounp.items[indexPath.row];
    
    
//    cell.calculatorModel = self.calculatorModel.[indexPath.row];
    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.calculatorGounp.items = self.calculatorGounp.sections[indexPath.section];
    
    if (self.calculatorGounp.items[indexPath.row].action) {
        
        self.calculatorGounp.items[indexPath.row].action();
    }
    
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
//        return 10;
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [UIView new];
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView * result = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
//    result.backgroundColor = kWhiteColor;
    
    UILabel * resultLab = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#999999") font:12];
    resultLab.text = @"*此结果仅供参考";
    [result addSubview:resultLab];
    [resultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(result.mas_centerX);
        make.centerY.equalTo(result.mas_centerY);
        
    }];
    
    if (section==0) {
        return nil;
    }
    return result;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    //    return 0.1;
    if (section==0) {
        return 0.1;
    }
    return 40;
}

#pragma mark - UIScrollViewDelgate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    //    if (scrollView.contentOffset.y < 0) {
    // 高度拉伸
    CGFloat imgH = CalculatorHeardHeight - offsetY;
    CGFloat imgW = kScreenWidth;
    //****************头部图片*********************
    UIView *imgView = [self.superview viewWithTag:2000];
    //       offsetY * self.scale
    imgView.frame = CGRectMake(0,0, imgW, imgH);
//    *****************************************************
    //    }
    
    NSLog(@"%lf",offsetY);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
