
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
    NSTimer *timer;
    CFRunLoopRef timerRunLoop;
    __weak UIButton  *countdownBtn;
    NSUInteger countdown;
}
@end

@implementation VerificationCodeCell

- (void)dealloc
{
    if (timer) {
        [self closeTimer];

    }
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

- (void)setModel:(InfoTextFieldCellModel *)model
{
    [super setModel:model];
    

}


- (void)getVerificationCodeBtnClick:(UIButton *)btn
#warning 服务器获取验证码
{
    btn.enabled = NO;
    sleep(1);
    [self performSelectorInBackground:@selector(startCountdown) withObject:nil];
}

- (void)closeTimer
{
    [timer invalidate];
    timer = nil;
    CFRunLoopStop(timerRunLoop);

}
- (void)startCountdown
{

    if (timer) {
        [self closeTimer];
    }
    countdown = 10;

    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(setCountdown) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    timerRunLoop = CFRunLoopGetCurrent();
    CFRunLoopRun();

    
}

- (void)setCountdown
{
    if (countdown) {
        [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"%lds",countdown] Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateDisabled];
        countdown --;

    } else {
    
        [self closeTimer];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [countdownBtn setAttributedTitle:[NSString getAttributedStringFromString:@"获取验证码" Color:[UIColor redColor] Fount:TextFont] forState:UIControlStateNormal];
            countdownBtn.enabled = YES;

        });
        
    }    
    

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
