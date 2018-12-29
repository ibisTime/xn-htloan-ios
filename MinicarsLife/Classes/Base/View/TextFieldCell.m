//
//  TextFieldCell.m
//  CarLoans
//
//  Created by QinBao Zheng on 2018/7/17.
//  Copyright © 2018年 QinBao Zheng. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [UILabel labelWithFrame:CGRectMake(15, 0, 90, 50) textAligment:(NSTextAlignmentLeft) backgroundColor:kClearColor font:HGfont(14) textColor:[UIColor blackColor]];
    }
    return _nameLabel;
}

-(UITextField *)nameTextField
{
    if (!_nameTextField) {
        _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(105, 0, SCREEN_WIDTH - 120, 50)];
        _nameTextField.font = HGfont(14);
        _nameTextField.textAlignment = NSTextAlignmentRight;
        [_nameTextField setValue:HGfont(14) forKeyPath:@"_placeholderLabel.font"];
    }
    return _nameTextField;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLabel];
        [self addSubview:self.nameTextField];

        UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineView1.backgroundColor = LineBackColor;
        [self addSubview:lineView1];


        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 49, SCREEN_WIDTH, 1)];
        lineView.backgroundColor = LineBackColor;
        [self addSubview:lineView];
       
    }
    return self;
}

-(void)setIsSwitchOn:(BOOL)isSwitchOn
{
    _isSwitchOn = isSwitchOn;
    if (self.isSwitchOn == YES) {
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(105, 0, SCREEN_WIDTH, 50)];
        lineView2.backgroundColor = kWhiteColor;
        [self addSubview:lineView2];
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-80, 10, 80, 30)];
        self.switchUser = sw;
        [self addSubview:sw];
        
//        self.userInteractionEnabled = NO;
        [sw addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    
}
-(void)switchAction:(id)sender{
        UISwitch *switchButton = (UISwitch*)sender;
        BOOL isButtonOn = [switchButton isOn];
        if (isButtonOn) {
//            showSwitchValue.text = @"是";
            
        }else {
//            showSwitchValue.text = @"否";
            
        }
    
}



-(void)setName:(NSString *)name
{
    _nameLabel.text = name;
    _nameLabel.frame = CGRectMake(15, 18, 0, 14);
    [_nameLabel sizeToFit];
    _nameTextField.frame = CGRectMake(_nameLabel.frame.size.width + 25, 0, SCREEN_WIDTH - _nameLabel.frame.size.width - 40, 50);
}

-(void)setNameText:(NSString *)nameText
{
    _nameTextField.placeholder = nameText;
}

-(void)setIsInput:(NSString *)isInput
{
    if ([isInput isEqualToString:@"0"]) {
        _nameTextField.enabled = NO;
    }
}

-(void)setTextFidStr:(NSString *)TextFidStr
{
//    _nameTextField.text = [BaseModel convertNull:TextFidStr];
}

@end
