//
//  XIRepaymentVC.m
//  htloan
//
//  Created by apple on 2018/4/14.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XIRepaymentVC.h"
//m
#import "repaymentModel.h"
//V
#import "SelectScrollView.h"
#import "TopLabelUtil.h"
//C
#import "repaymentVC.h"
@interface XIRepaymentVC ()


//大滚动
@property (nonatomic, strong) UIScrollView *switchSV;
//小滚动
@property (nonatomic, strong) SelectScrollView *selectSV;
//titles
@property (nonatomic, strong) NSMutableArray *titles;
//statusList
@property (nonatomic, strong) NSArray *statusList;
//类型
@property (nonatomic, copy) NSString *kind;
//资讯类型
//@property (nonatomic, strong) NSArray <InfoTypeModel *>*infoTypeList;

@end

@implementation XIRepaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"还款";
    
    [self initSegmentView];
}


#pragma mark - Init

- (void)initSegmentView {
    
    self.statusList = @[kNewRepayment, kHistoryRepayment];
    self.switchSV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSuperViewHeight)];
    [self.view addSubview:self.switchSV];

    
    
    
    for (int i = 0; i < 2; i++) {
        self.titles = [NSMutableArray arrayWithObjects:@"近期还款", @"还款记录", nil];
            
            [self initSelectScrollView:i];
        }
}
- (void)initSelectScrollView:(NSInteger)index {
    
    SelectScrollView *selectSV = [[SelectScrollView alloc] initWithFrame:CGRectMake(index*kScreenWidth, 0, kScreenWidth, kSuperViewHeight - kTabBarHeight) itemTitles:self.titles];
    
    selectSV.tag = 2500 + index;
    
    [self.switchSV addSubview:selectSV];
    
    [self addSubViewController:index];
}

- (void)addSubViewController:(NSInteger)index {
//
    SelectScrollView *selectSV = (SelectScrollView *)[self.view viewWithTag:2500+index];
//
    for (NSInteger i = 0; i < self.titles.count; i++) {
       
      

        repaymentVC *childVC = [[repaymentVC alloc] init];
          childVC.status = self.statusList[i];
            childVC.titleStr = self.titles[i];


 childVC.view.frame = CGRectMake(kScreenWidth*i, 1, kScreenWidth, kSuperViewHeight - 40 - kTabBarHeight);

        [self addChildViewController:childVC];

        [selectSV.scrollView addSubview:childVC.view];
    }

}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
