//
//  RegisterViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginVerificationCodeCell.h"
#import "YLRegularCheck.h"
#import "ImproveRegistInfoViewController.h"
@interface RegisterViewController (){
    __weak UIButton *_registBtn;
    __weak  NSMutableArray *_dataArray; //用来做dataArray懒加载

}

@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //从完善资料返回的时候 需重新设置navigationBar颜色
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"white_nav_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
   
    [self creatFooterView];

        
}

- (void)registBtnClick
{
    [self.view endEditing:YES];
    
    //格式校验
    
    if (self.userTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:self.userTF.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    
    
    ImproveRegistInfoViewController *improvetvc = [[ImproveRegistInfoViewController alloc] init];
    [self.navigationController pushViewController:improvetvc animated:YES];
    
    
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
    [commitBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"注册" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:commitBtn];
    
    _registBtn = commitBtn;
    _registBtn.enabled = NO;
    
    
    
}


#pragma mark ==通知回调
- (void)textFieldChange:(NSNotification *)noti
{
    if ([self.userTF.text length] && [self.vercodeTF.text length]) {
        _registBtn.enabled = YES;
    } else {
        
        _registBtn.enabled = NO;
    }
    
}
@end
