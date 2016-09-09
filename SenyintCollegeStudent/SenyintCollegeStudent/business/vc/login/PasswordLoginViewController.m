//
//  PasswordLoginViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "PasswordLoginViewController.h"
#import "LoginPasswordCell.h"
#import "YLRegularCheck.h"
#import "VerificationCodeLoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"

@interface PasswordLoginViewController ()
{
    __weak UIButton *_loginBtn;
    
    __weak  NSMutableArray *_dataArray; //用来做dataArray懒加载
}

@end


@implementation PasswordLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    UIButton *verloginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 70, 30)];
    [verloginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"验证码登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBar_bg_Color, NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [verloginBtn addTarget:self action:@selector(loginUsedVerificationCode)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:verloginBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    [self creatFooterView];
    

}


- (void)loginUsedVerificationCode
{

    VerificationCodeLoginViewController *verLoginvc = [[VerificationCodeLoginViewController alloc] init];
    verLoginvc.userPhone = self.userTF.text;

    [self.navigationController pushViewController:verLoginvc animated:YES];
    
}

- (void)forgetPasswordBtnClick
{
    
    ForgetPasswordViewController *verLoginvc = [[ForgetPasswordViewController alloc] init];
    verLoginvc.userPhone = self.userTF.text;
    [self.navigationController pushViewController:verLoginvc animated:YES];
    
    
}


- (void)registBtnClick
{
    RegisterViewController *registvc = [[RegisterViewController alloc] init];
    registvc.userPhone = self.userTF.text;
    [self.navigationController pushViewController:registvc animated:YES];
}


- (void)loginBtnClick
{
    NSLog(@"loginBtnClick");      
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
//    [self loginRequest];
    //通过校验之后 调用登录接口
}





//表尾
- (void)creatFooterView
{
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    
    UIButton *forgetPwBtn = [[UIButton alloc] initWithFrame:CGRectMake(25,0, 70, 30)];
    [forgetPwBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"忘记密码?" attributes:[NSDictionary dictionaryWithObjectsAndKeys: COLOR_RGB_HEX(0xff9c00), NSForegroundColorAttributeName,[UIFont systemFontOfSize:12], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [forgetPwBtn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:forgetPwBtn];
    
    
    UIButton *rigistBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 60, 0, 30, 30)];
    [rigistBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"注册" attributes:[NSDictionary dictionaryWithObjectsAndKeys: COLOR_RGB_HEX(0xff9c00), NSForegroundColorAttributeName,[UIFont systemFontOfSize:12], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [rigistBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:rigistBtn];
    

    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, Screen_Width - 60, 45)];
    UIImage *image = [UIImage imageNamed:@"login"];
    [loginBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateNormal];
    [loginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:loginBtn];
    _loginBtn = loginBtn;
    _loginBtn.enabled = NO;
    
    
}



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [super dataArray];
       
        LoginCellModel *mode2 = [[LoginCellModel alloc] init];
        mode2.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
        mode2.textFieldPlaceholder = @"请输入密码";
        mode2.cellClassName = NSStringFromClass([LoginPasswordCell class]);
        mode2.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode2];
    }

    return _dataArray;
    
}

#pragma mark ==通知回调 重写父类
- (void)textFieldChange:(NSNotification *)noti
{
    NSLog(@"%@--textFieldChange",self);
    if ([self.userTF.text length] && [self.pwTF.text length]) {
        _loginBtn.enabled = YES;
    } else {
        
        _loginBtn.enabled = NO;
    }
    
}

@end
