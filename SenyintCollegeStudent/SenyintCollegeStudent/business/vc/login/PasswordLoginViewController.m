//
//  PasswordLoginViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "PasswordLoginViewController.h"
#import "RegistInfoInputCell.h"
#import "YLRegularCheck.h"
#import "VerificationCodeLoginViewController.h"
#import "ForgetPasswordViewController.h"
#import "RegisterViewController.h"

@interface PasswordLoginViewController ()
{
    __weak UIButton *_loginBtn;
}

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)  UITextField *userTF;
@property (nonatomic, weak)  UITextField *pwTF;
@end


@implementation PasswordLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [super viewWillAppear:animated];
    
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewWillDisappear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:NSStringFromClass([RegistInfoInputCell class])];
    
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
    [self.navigationController pushViewController:[[RegisterViewController alloc] init] animated:YES];
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


- (void)loginRequest
{
    
    //通过校验之后 调用登录接口
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] initWithDictionary:[GlobalSingle userBaseInfo]] ;
    [paraDic setValue:self.userTF.text forKey:@"mobile"];
    [paraDic setValue:self.pwTF.text forKey:@"password"];
    
    NSLog(@"%@",paraDic);
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    __weak typeof(self) safeSelf = self;
    [sessionManager GET:[[GlobalSingle baseUrl] stringByAppendingString:@"/v1/users/login"]  parameters:paraDic progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success:%@", responseObject);
        [safeSelf loginSuccess:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        [safeSelf loginFailure];
    }];
    
}
- (void)loginSuccess:(id)responseObject
{
    
    
    if ([[[responseObject objectForKey:@"header"] objectForKey:@"status"] integerValue] == 1) {
        
        [GlobalSingle setToken:[[responseObject objectForKey:@"content"] objectForKey:@"token"]];
        [GlobalSingle setUid:[[responseObject objectForKey:@"content"] objectForKey:@"uid"]];
        [GlobalSingle setMobile:self.userTF.text];
        [GlobalSingle setPassword:self.pwTF.text];
        
        //        [NSClassFromString(@"HomeViewController") setWindowRootViewController];
        
    } else {
        
        [SCProgressHUD showInfoWithStatus:[[responseObject objectForKey:@"header"] objectForKey:@"message"]];
    }
    
    
}

- (void)loginFailure
{
    [SCProgressHUD showErrorWithStatus:@"请求超时，请稍后再试"];
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:5];
        InfoTextFieldCellModel *mode1 = [[InfoTextFieldCellModel alloc] init];
        mode1.infoName = @"手机号";
        mode1.textFieldPlaceholder = @"请输入手机号";
        mode1.textFieldinfo = self.userPhone;
        mode1.textFieldKeyboardType = UIKeyboardTypePhonePad;
        mode1.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        [_dataArray addObject:mode1];
        
        InfoTextFieldCellModel *mode2 = [[InfoTextFieldCellModel alloc] init];
        mode2.infoName = @"密 码";
        mode2.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
        mode2.textFieldPlaceholder = @"请输入密码";
        mode2.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode2.textFieldSetSecureRightView = YES;
        mode2.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode2];

        
        
    }
    return _dataArray;
    
}

- (void)creatFooterView
{
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    
    
    UIButton *verloginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20,5, 70, 30)];
    [verloginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"验证码登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [verloginBtn addTarget:self action:@selector(loginUsedVerificationCode) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:verloginBtn];
    
    UIButton *forgetPwBtn = [[UIButton alloc] initWithFrame:CGRectMake(Screen_Width - 90,5, 70, 30)];
    [forgetPwBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"忘记密码" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [forgetPwBtn addTarget:self action:@selector(forgetPasswordBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:forgetPwBtn];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 40, Screen_Width - 40, 45)];
    loginBtn.backgroundColor = [UIColor colorWithRed:22 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    //    UIImage *image = [UIImage imageNamed:@"Button_graybg"];
    //    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"Button_graybg"] stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateSelected];
    
    [loginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:loginBtn];
    _loginBtn = loginBtn;
    _loginBtn.enabled = NO;
    
    
    UIButton *rigistBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    rigistBtn.center = CGPointMake(footer.center.x, 105);
    [rigistBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"注册" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [rigistBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:rigistBtn];

    
    
}

- (UITextField *)userTF
{
    ;
    if (!_userTF) {
        InfoTextFieldCell *cell = [self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        _userTF = cell.infoTextField;
    }
    
    return _userTF;
}

- (UITextField *)pwTF
{
    if (!_pwTF) {
        InfoTextFieldCell *cell = [self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        _pwTF = cell.infoTextField;
        
    }
    return _pwTF;
}

- (void)textFieldChange:(NSNotification *)noti
{
    if ([self.userTF.text length] && [self.pwTF.text length]) {
        _loginBtn.enabled = YES;
    } else {
        
        _loginBtn.enabled = NO;
    }
    
}
#pragma mark ==UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoTextFieldCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    NSString * cellIdentifier = model.cellClassName;
    InfoTextFieldCell *cell  = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.model = model;
    
    
    return cell;
}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

@end
