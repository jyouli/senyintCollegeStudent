//
//  LoginVerificationCodeCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/5.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LoginVerificationCodeCell.h"
#import "NSString+Attribute.h"

@interface LoginVerificationCodeCell ()
{

    __weak UIButton *countdownBtn;
}
@end

@implementation LoginVerificationCodeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.icon.image = [UIImage imageNamed:@"mail"];
        
        self.tf.rightViewMode = UITextFieldViewModeAlways;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 30)];
        UIButton  *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 80, 30)];
        [view addSubview:btn];
        [btn setBackgroundImage:[[UIImage imageNamed:@"yzm_bg"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
        [btn setBackgroundImage:[[UIImage imageNamed:@"yzm_bg_gray"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateDisabled];

        [btn addTarget:self action:@selector(getVerificationCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:BodyContentImportantText_Font_Color Fount:BodyContentText_Font_Size] forState:UIControlStateNormal];
        self.tf.rightView = view;
        self.tf.rightViewMode = UITextFieldViewModeAlways;
        
        countdownBtn = btn;

        
    }
    return self;
}

- (void)setModel:(LoginCellModel *)model
{
    [super setModel:model];
    NSInteger  countdown = [VerificationCodeCountdownSingle getCurrentRemainingsecondSWithKey:model.verificationCodeCountdownKey AndCountdown_Second:0];
    if (countdown == Countdown_Second) {
        [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:BodyContentImportantText_Font_Color Fount:BodyContentText_Font_Size] forState:UIControlStateNormal];
        countdownBtn.enabled = YES;
        
    } else {
        countdownBtn.enabled = NO;
        [self performSelectorInBackground:@selector(startCountdown) withObject:nil];
        
    }
    
    __weak typeof(countdownBtn) safeBtn = countdownBtn;
    if ([Countdown_UserRegist isEqualToString:model.verificationCodeCountdownKey]) {
        [VerificationCodeCountdownSingle sharedCodeCountdownSingle].userRegistUpdateUI = ^(NSInteger countdown){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdown == 0) {
                    [safeBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:BodyContentImportantText_Font_Color Fount:BodyContentText_Font_Size] forState:UIControlStateNormal];
                    safeBtn.enabled = YES;
                } else {
                    [safeBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds后重发",countdown] Color:Disabledgray_Color Fount:BodyContentText_Font_Size] forState:UIControlStateDisabled];
                    
                }
                
                
            });
            
        };
        
    }
    
    if ([Countdown_ForgetPassWord isEqualToString:model.verificationCodeCountdownKey]) {
        
        [VerificationCodeCountdownSingle sharedCodeCountdownSingle].forgetPassWordUpdateUI = ^(NSInteger countdown){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdown == 0) {
                    [safeBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:BodyContentImportantText_Font_Color Fount:BodyContentText_Font_Size] forState:UIControlStateNormal];
                    safeBtn.enabled = YES;
                } else {
                    [safeBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds后重发",countdown] Color:Disabledgray_Color Fount:BodyContentText_Font_Size] forState:UIControlStateDisabled];
                    
                }
                
                
            });
            
        };
        
    }
    
    if ([Countdown_VerificationCodeLogin isEqualToString:model.verificationCodeCountdownKey]) {
        
        [VerificationCodeCountdownSingle sharedCodeCountdownSingle].verificationCodeLoginUpdateUI = ^(NSInteger countdown){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdown == 0) {
                    [safeBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:BodyContentImportantText_Font_Color Fount:BodyContentText_Font_Size] forState:UIControlStateNormal];
                    safeBtn.enabled = YES;
                } else {
                    [safeBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds后重发",countdown] Color:Disabledgray_Color Fount:BodyContentText_Font_Size] forState:UIControlStateDisabled];
                    
                }
                
                
            });
            
        };
        
    }
    
    
}


- (void)getVerificationCodeBtnClick:(UIButton *)btn
#warning 服务器获取验证码
{
    btn.enabled = NO;
    [self performSelectorInBackground:@selector(startCountdown) withObject:nil];
}

- (void)startCountdown
{
    [[VerificationCodeCountdownSingle sharedCodeCountdownSingle] startCountdownWith:self.model.verificationCodeCountdownKey];
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.tf.frame;
    rect.origin.y = 25;
    self.tf.frame = rect;
}

@end
