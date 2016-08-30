//
//  InfoTextFieldCellModel.h
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "CellModel.h"
#import "VerificationCodeCountdownSingle.h"

@interface InfoTextFieldCellModel : CellModel
@property (nonatomic, copy) NSString *infoName;       //infoLabel text

#pragma  mark textTield属性
@property (nonatomic, copy) NSString *textFieldinfo; //text
@property (nonatomic, copy) NSString *textFieldPlaceholder;  //Placeholder
@property (nonatomic, assign) UIKeyboardType textFieldKeyboardType;//键盘类型
@property (nonatomic, assign) UIReturnKeyType textFieldReturnKeyType;//键盘返回按钮类型
@property (nonatomic, weak) id<UITextFieldDelegate> textFieldDelegate;//delegate  不设的时候为cell
@property (nonatomic, assign) BOOL textFieldEnabled;   //textField是否可以获取焦点 默认为YES
@property (nonatomic, assign) BOOL textFieldSecureTextEntry;    //YES 密文 NO明文  默认为NO
@property (nonatomic, assign) UITextFieldViewMode textFieldClearBtnMode; //clearBtn展示的ViewMode 默认UITextFieldViewModeWhileEditing
@property (nonatomic, assign) UITextFieldViewMode textFieldRightviewMode;//rightvie展示的ViewMode 默认UITextFieldViewModeUnlessEditing
@property (nonatomic, assign) BOOL textFieldSetSecureRightView;//是否展示明密文切换view 默认为NO不展示
@property (nonatomic, copy) NSString *verificationCodeCountdownKey;//用于验证码倒计时标记

@end
