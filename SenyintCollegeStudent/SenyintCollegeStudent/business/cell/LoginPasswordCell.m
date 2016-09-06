//
//  LoginPasswordCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/5.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LoginPasswordCell.h"

@implementation LoginPasswordCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.icon.image = [UIImage imageNamed:@"password"];

        
        self.tf.rightViewMode = UITextFieldViewModeAlways;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"eye_gray"] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(secureTextRightViewClick:) forControlEvents:UIControlEventTouchUpInside];
        self.tf.rightView = btn;
        self.tf.secureTextEntry = YES;
        btn.selected = !self.tf.secureTextEntry;
   
        
    }
    return self;
}

- (void)setModel:(LoginCellModel *)model
{
    [super setModel:model];
    
    self.tf.secureTextEntry = self.model.textFieldSecureTextEntry;
    UIButton *btn = (UIButton *)self.tf.rightView;
    btn.selected = !self.model.textFieldSecureTextEntry;

}

- (void)secureTextRightViewClick:(UIButton *)btn
{
    self.model.textFieldSecureTextEntry = !self.model.textFieldSecureTextEntry;
    self.tf.secureTextEntry = self.model.textFieldSecureTextEntry;
    btn.selected = !self.model.textFieldSecureTextEntry;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.tf.frame;
    rect.origin.y = 25;
    self.tf.frame = rect;
}
@end
