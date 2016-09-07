//
//  ForgetPasswordViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "LoginCell.h"
#import "LoginPasswordCell.h"
#import "LoginVerificationCodeCell.h"
#import "YLRegularCheck.h"
@interface ForgetPasswordViewController ()
{
    __weak  NSMutableArray *_dataArray; //用来做dataArray懒加载

}

@end


@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    [self creatFooterView];
    
    
}




- (void)commitBtnClick
{
    NSLog(@"commitBtnClick");
    [self.view endEditing:YES];
    
    if (self.userTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:self.userTF.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    if (self.pwTF.text.length == 0 || ![YLRegularCheck checkpassword:self.pwTF.text]) {
        [SCProgressHUD showInfoWithStatus:@"请输入6-20位字母或数字密码"];
        return;
    }
    
    [SCProgressHUD showInfoWithStatus:@"调接口"];
    //通过校验之后 调用登录接口
}



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [super dataArray];

        LoginCellModel *mode2 = [[LoginCellModel alloc] init];
        mode2.textFieldPlaceholder = @"请输入验证码";
        mode2.textFieldKeyboardType = UIKeyboardTypeNumberPad;
        mode2.verificationCodeCountdownKey = Countdown_ForgetPassWord;
        mode2.cellClassName = NSStringFromClass([LoginVerificationCodeCell class]);
        [_dataArray addObject:mode2];
        
        LoginCellModel *mode3 = [[LoginCellModel alloc] init];
        mode3.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
        mode3.textFieldPlaceholder = @"请输入6-20位的新密码";
        mode3.cellClassName = NSStringFromClass([LoginPasswordCell class]);
        mode3.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode3];
        
    }
    
    return _dataArray;
    
}

//表尾
- (void)creatFooterView
{
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, Screen_Width - 60, 45)];
    UIImage *image = [UIImage imageNamed:@"login"];
    [commitBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateNormal];
    [commitBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"完成" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:commitBtn];
    
}

@end
