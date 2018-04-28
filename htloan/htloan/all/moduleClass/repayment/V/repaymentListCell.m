//
//  repaymentListCell.m
//  htloan
//
//  Created by apple on 2018/4/27.
//  Copyright © 2018年 myteam. All rights reserved.
//
#define kColor [UIColor colorWithHexString:@"#3184fd"];
#import "repaymentListCell.h"

//Category
#import "NSString+Date.h"
#import "UILabel+Extension.h"
#import "NSString+Extension.h"

@interface repaymentListCell()
@property (nonatomic, strong) UIImageView *dot;
@property (nonatomic, strong) UILabel *contentLbl;
@property (nonatomic, strong) UILabel *timeLbl;

@property (nonatomic, strong) UILabel *status;

@end
@implementation repaymentListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self initSubviews];
        
    }
    
    return self;
}

#pragma mark - Init
- (void)initSubviews {
    
    
    
    
    //车贷内容
    self.contentLbl = [UILabel labelWithBackgroundColor:kClearColor textColor:kAppCustomMainColor font:16.0];
    self.contentLbl.numberOfLines = 3;//行数
    
    [self addSubview:self.contentLbl];
    //日期
    
    self.timeLbl = [UILabel labelWithBackgroundColor:kClearColor  textColor:[UIColor colorWithHexString:@"#999999"] font:13.0];
    [self addSubview:self.timeLbl];
    //还款状态

    self.status = [UILabel labelWithBackgroundColor:kClearColor  textColor:kAppCustomMainColor font:13.0];
    //collor
    
    [self addSubview:self.timeLbl];

    //点
    self.dot = [[UIImageView alloc] initWithImage:kImage(@"更多")];
    [self addSubview:self.dot];

    //布局
    [self setSubviewLayout];
}

- (void)setSubviewLayout {
    
    //内容
    [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(@(kPublictextMargin));
        make.top.equalTo(@(kPublictextMargin));
        
    }];

   
    //时间
    [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.offset(-kPublictextMargin);
        make.left.offset(kPublictextMargin);
        
        
    }];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.mas_centerY);
        make.right.offset(-35);
        
        
    }];
    //
    [self.dot mas_makeConstraints:^(MASConstraintMaker *make) {
        
    make.centerY.equalTo(self.mas_centerY);
        make.right.offset(-15);

    }];

}

#pragma mark - Setting
-(void)setRepaymentModel:(repaymentModel *)repaymentModel
{
    _repaymentModel = repaymentModel;
    

    
    
    
    [self layoutSubviews];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
