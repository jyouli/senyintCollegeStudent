//
//  LoginCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LoginCell.h"

@interface LoginCell ()<UITextFieldDelegate>

@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, weak) UIImageView *icon;
@end
@implementation LoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, 45)];
        iv.contentMode = UIViewContentModeCenter;
        iv.image = [UIImage imageNamed:@"userIcon"];
        UITextField *tf = [[UITextField alloc] init];
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        tf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = iv;
        tf.borderStyle = UITextBorderStyleNone;
        tf.layer.masksToBounds = YES;
        tf.layer.cornerRadius = 5;
        tf.layer.borderWidth = 1;
        tf.layer.borderColor = [[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1] CGColor];
        tf.returnKeyType = UIReturnKeyDone;
        tf.textColor = BlackText_Font_Color;
        tf.font = LoginTextFieldInputText_Font_Size;
        tf.delegate = self;
        [self.contentView addSubview:tf];
        self.tf = tf;
        self.icon = iv;
                
    }
    return self;
}

- (void)setModel:(LoginCellModel *)model
{
    _model = model;
    
    self.accessoryType = self.model.cellAccessoryType;
    self.selectionStyle = self.model.cellSelectionStyle;
    
    self.tf.placeholder = self.model.textFieldPlaceholder;
    self.tf.text = self.model.textFieldinfo;
    self.tf.keyboardType = self.model.textFieldKeyboardType;
    self.tf.returnKeyType = self.model.textFieldReturnKeyType;
    self.tf.clearButtonMode = self.model.textFieldClearBtnMode;
    self.tf.secureTextEntry = self.model.textFieldSecureTextEntry;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tf.frame = CGRectMake(30, 0, self.bounds.size.width - 60 , 45);
    
}


#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}
//粘贴 剪切触发 程序写（tf.text=@""）不触发 清除按钮不触发
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.textFieldinfo = textField.text;
    
}

@end
