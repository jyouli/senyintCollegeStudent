//
//  LoginCellModel.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/5.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "CellModel.h"

@interface LoginCellModel : CellModel
#pragma  mark textTield属性
@property (nonatomic, copy) NSString *textFieldinfo; //text
@property (nonatomic, copy) NSString *textFieldPlaceholder;  //Placeholder
@property (nonatomic, assign) UIKeyboardType textFieldKeyboardType;//键盘类型
@property (nonatomic, assign) UIReturnKeyType textFieldReturnKeyType;//键盘返回按钮类型
@property (nonatomic, assign) UITextFieldViewMode textFieldClearBtnMode; //clearBtn展示的ViewMode 默认UITextFieldViewModeNever
@property (nonatomic, assign) BOOL textFieldSecureTextEntry;    //YES 密文 NO明文  默认为NO
@property (nonatomic, copy) NSString *verificationCodeCountdownKey;//用于验证码倒计时标记
@end
