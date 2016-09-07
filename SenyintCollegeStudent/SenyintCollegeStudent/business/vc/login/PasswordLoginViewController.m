//
//  PasswordLoginViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "PasswordLoginViewController.h"
#import "LoginCell.h"
#import "LoginPasswordCell.h"
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
    
    [self.navigationController. navigationBar setBackgroundImage:[[UIImage imageNamed:@"white_nav_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
   
    UIButton *verloginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 70, 30)];
    [verloginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"验证码登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBar_bg_Color, NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [verloginBtn addTarget:self action:@selector(loginUsedVerificationCode)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:verloginBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

    
    [self.tableView registerClass:[LoginCell class] forCellReuseIdentifier:NSStringFromClass([LoginCell class])];
    [self.tableView registerClass:[LoginPasswordCell class] forCellReuseIdentifier:NSStringFromClass([LoginPasswordCell class])];

    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self creatHeaderView];
    [self creatFooterView];
    
    
}



- (void)loginUsedVerificationCode
{
    VerificationCodeLoginViewController *verLoginvc = [[VerificationCodeLoginViewController alloc] init];
    verLoginvc.userPhone = self.userTF.text;
    verLoginvc.backImageStr = @"nav_back_gray";

    [self.navigationController pushViewController:verLoginvc animated:YES];
    
}

- (void)forgetPasswordBtnClick
{
    
    ForgetPasswordViewController *verLoginvc = [[ForgetPasswordViewController alloc] init];
    verLoginvc.userPhone = self.userTF.text;
    verLoginvc.backImageStr = @"nav_back_gray";
    [self.navigationController pushViewController:verLoginvc animated:YES];
    
    
}


- (void)registBtnClick
{
    RegisterViewController *registvc = [[RegisterViewController alloc] init];
    registvc.userPhone = self.userTF.text;
    registvc.backImageStr = @"nav_back_gray";
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
        LoginCellModel *mode1 = [[LoginCellModel alloc] init];
        mode1.textFieldPlaceholder = @"请输入手机号";
        mode1.textFieldinfo = self.userPhone;
        mode1.textFieldKeyboardType = UIKeyboardTypeNumberPad;
        mode1.cellClassName = NSStringFromClass([LoginCell class]);
        [_dataArray addObject:mode1];
        
        LoginCellModel *mode2 = [[LoginCellModel alloc] init];
        mode2.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
        mode2.textFieldPlaceholder = @"请输入密码";
        mode2.cellClassName = NSStringFromClass([LoginPasswordCell class]);
        mode2.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode2];

        
        
    }
    return _dataArray;
    
}

//表头
- (void)creatHeaderView
{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, (Screen_Height - 64)/2 )];
    header.image = [UIImage imageNamed:@"logo_senyint"];
    header.contentMode = UIViewContentModeCenter;
    self.tableView.tableHeaderView = header;
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

#pragma mark ==通知回调
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

    LoginCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    NSString * cellIdentifier = model.cellClassName;
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.model = model;
    if ([model.cellClassName isEqualToString:NSStringFromClass([LoginCell class])]) {
        self.userTF = cell.tf;
    } else {
    
        self.pwTF = cell.tf;
    }
    
    return cell;

}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LoginCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if ([model.cellClassName isEqualToString:NSStringFromClass([LoginCell class])]) {
        return 45;
    }

    return 65;
}

@end
