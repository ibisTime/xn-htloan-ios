//
//  XIMyApplyForCell.m
//  htloan
//
//  Created by apple on 2018/4/17.
//  Copyright © 2018年 myteam. All rights reserved.
//

#import "XIMyApplyForCell.h"

@interface XIMyApplyForCell()
//订单编号
@property (nonatomic, strong) UILabel *orderNumber;
//处理情况
@property (nonatomic, strong) UILabel *ProcessingConditions;

//汽车标的
@property (nonatomic, strong) UIView *carPayShow;
@end
@implementation XIMyApplyForCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor =[UIColor grayColor];
        [self initSubviews];
        
    }
    
    return self;
}

#pragma mark - Setting
- (void)setXIMyApplyForModel:(XIMyApplyForModel *)XIMyApplyForModel{
    
    _XIMyApplyForModel = XIMyApplyForModel;
    
    self.orderNumber.text = [NSString stringWithFormat:@"订单编号:%@" ,XIMyApplyForModel.orderNumber];

    self.ProcessingConditions.text =XIMyApplyForModel.ProcessingConditions;
    self.carPayShow = XIMyApplyForModel.carPayShow;
    
    //
    [self layoutSubviews];
    
    //计算行高
    XIMyApplyForModel.cellHeight = self.ProcessingConditions.yy + 20;
}

#pragma mark - Init
- (void)initSubviews {
    
    //订单编号
    self.orderNumber = [UILabel labelWithBackgroundColor:kClearColor
textColor:kHexColor(@"#66666") font:17.0];
    self.orderNumber.numberOfLines = 0;
    
    [self addSubview:self.orderNumber];
    //处理情况
    self.ProcessingConditions = [UILabel labelWithBackgroundColor:kClearColor textColor:kHexColor(@"#6cboff") font:17.0];
    self.ProcessingConditions.numberOfLines = 0;
    
    [self addSubview:self.ProcessingConditions];

    //汽车标的
    
      self.carPayShow = [[UIView alloc]init];
    
    [self addSubview:self.orderNumber];

   
    //布局
    [self setSubviewLayout];
}

- (void)setSubviewLayout {
    
    //订单号
    [self.orderNumber mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.mas_left).offset(30);
        make.top.equalTo(@20);
        
    }];
    //处理结果
    [self.ProcessingConditions mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-130));
        make.top.equalTo(@20);
    }];
   
    //处理结果
    [self.carPayShow mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(@(-130));
        make.top.equalTo(self.orderNumber.mas_bottom).offset(20);
        
    }];

}
//







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
