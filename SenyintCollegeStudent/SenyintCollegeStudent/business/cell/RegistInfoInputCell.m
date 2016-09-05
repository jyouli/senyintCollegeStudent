//
//  RegistInfoInputCell.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RegistInfoInputCell.h"

@implementation RegistInfoInputCell

- (void)setModel:(InfoTextFieldCellModel *)model
{
    [super setModel:model];
    
    if (self.model.textFieldSetSecureRightView) {
        UIButton *btn = (UIButton *)self.infoTextField.rightView;
        if (!btn) {
            btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
            [btn setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:@"eye_gray"] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(secureTextRightViewClick:) forControlEvents:UIControlEventTouchUpInside];
            self.infoTextField.rightView = btn;
        }
        
        self.infoTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
        btn.selected = !self.model.textFieldSecureTextEntry;
        
    } else {
        
        self.infoTextField.rightViewMode = UITextFieldViewModeNever;
        
    }
    
}

- (void)secureTextRightViewClick:(UIButton *)btn
{
    self.model.textFieldSecureTextEntry = !self.model.textFieldSecureTextEntry;
    self.infoTextField.secureTextEntry = self.model.textFieldSecureTextEntry;
    btn.selected = !self.model.textFieldSecureTextEntry;
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.model.textFieldinfo = textField.text;
    
}


@end
