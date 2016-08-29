
//
//  VerificationCodeCell.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "VerificationCodeCell.h"
#import "NSString+Attribute.h"
#import "SCProgressHUD.h"
@interface VerificationCodeCell ()
{
    __weak UIButton  *countdownBtn;
}
@end

@implementation VerificationCodeCell

- (void)dealloc
{
    NSLog(@"VerificationCodeCell-dealloc");
    [[VerificationCodeCountdownSingle sharedCodeCountdownSingle] closeTimer];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setSubviews];
    
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setSubviews];
    }
    
    return self;
}

- (void)setSubviews
{
    [self setView:self.infoLabel FrameToSuperviewWithLeft:10 Width:45 Top:0 Bottom:0];
    
    [self setView:self.infoTextField FrameToSuperviewWithLeft:60 Right:10 Top:0 Bottom:0];
    self.infoLabel.textColor = TextColor;
    self.infoLabel.font = TextFont;
    self.infoLabel.textAlignment = NSTextAlignmentLeft;
    
    self.infoTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.infoTextField.textColor = TextColor;
    self.infoTextField.font = TextFont;
    self.infoTextField.textAlignment = NSTextAlignmentLeft;
    
    UIButton  *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    [btn addTarget:self action:@selector(getVerificationCodeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
    self.infoTextField.rightView = btn;
    self.infoTextField.rightViewMode = UITextFieldViewModeAlways;
  
    countdownBtn = btn;
    
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    NSInteger  countdown = [VerificationCodeCountdownSingle getCurrentRemainingsecondSWithKey:self.model.verificationCodeCountdownKey AndCountdown_Second:0];
    if (countdown == Countdown_Second) {
        [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
        countdownBtn.enabled = YES;
        
    } else {
        countdownBtn.enabled = NO;
        [self performSelectorInBackground:@selector(startCountdown) withObject:nil];
    }
}


#pragma mark ---交互
- (void)setModel:(InfoTextFieldCellModel *)model
{
    [super setModel:model];
    
    if ([Countdown_UserRegist isEqualToString:model.verificationCodeCountdownKey]) {
        [VerificationCodeCountdownSingle sharedCodeCountdownSingle].userRegistUpdateUI = ^(NSInteger countdown){
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdown == 0) {
                    [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
                    countdownBtn.enabled = YES;
                } else {
                    [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds",countdown] Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateDisabled];

                }
                
                
            });

        };
        
    }
    
    if ([Countdown_ForgetPassWord isEqualToString:model.verificationCodeCountdownKey]) {

        [VerificationCodeCountdownSingle sharedCodeCountdownSingle].forgetPassWordUpdateUI = ^(NSInteger countdown){
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdown == 0) {
                    [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
                    countdownBtn.enabled = YES;
              
                } else {
                    [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds",countdown] Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
                }
                
                
            });
            
        };
        
    }
    
    if ([Countdown_VerificationCodeLogin isEqualToString:model.verificationCodeCountdownKey]) {
        
        [VerificationCodeCountdownSingle sharedCodeCountdownSingle].verificationCodeLoginUpdateUI = ^(NSInteger countdown){
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if (countdown == 0) {
                    [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
                    countdownBtn.enabled = YES;
                } else {
                    [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds",countdown] Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateDisabled];
                    
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
