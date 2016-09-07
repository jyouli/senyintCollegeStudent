//
//  LoginController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginCell.h"
#import "YLRegularCheck.h"

@interface LoginViewController ()<UITextFieldDelegate>
{
    __weak UIButton *_loginBtn;
    __weak UITextField *_userTF;
    __weak UITextField *_pdTF;
}
@end

@implementation LoginViewController

+ (void)setWindowRootViewController
{
    LoginViewController *loginvc = [[LoginViewController alloc] init];
    
//    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:loginvc];
    [UIApplication sharedApplication].keyWindow.rootViewController = loginvc;
}

/*
 status	响应结果标识	-1，版本不一致，强制更新
 -2，uID和token不匹配 异地登陆
 -3，用户已停用
 0，访问接口成功，业务校验失败或服务器内部错误,
 1，成功
 2, TBD
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(inputViewTextChanged:) name:UITextFieldTextDidChangeNotification object:nil];

    UITableView *tableview = (UITableView *)self.view;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.title = @"登录";

//    tableview.separatorColor = RGBACOLOR(17, 83, 146, 1);
//    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
//        tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
//        
//    }
//    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
//        [tableview setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)
//         ];
//    }

    [tableview registerClass:[LoginCell class] forCellReuseIdentifier:@"LoginCell"];
    tableview.tableHeaderView = [self createHeaderView];
    tableview.tableFooterView = [self createFooterView];
    
}


- (void)loginBtnClick
{
    
    [self.view endEditing:YES];
    
    //格式校验
    
    if (_userTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:_userTF.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    if (_pdTF.text.length == 0 || ![YLRegularCheck checkpassword:_pdTF.text]) {
        [SCProgressHUD showInfoWithStatus:@"请输入6-24位字母或数字密码"];
        return;
    }
    

    
    [self loginRequest];
    //通过校验之后 调用登录接口
}

- (void)loginRequest
{

    _loginBtn.enabled = NO;
    
    
    
    
    //通过校验之后 调用登录接口
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] initWithDictionary:[GlobalSingle userBaseInfo]] ;
    [paraDic setValue:_userTF.text forKey:@"mobile"];
    [paraDic setValue:_pdTF.text forKey:@"password"];
    
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
        [GlobalSingle setMobile:_userTF.text];
        [GlobalSingle setPassword:_pdTF.text];
        
//        [NSClassFromString(@"HomeViewController") setWindowRootViewController];
        
    } else {
    
        [SCProgressHUD showInfoWithStatus:[[responseObject objectForKey:@"header"] objectForKey:@"message"]];
    }
    _loginBtn.enabled = YES;

   
}

- (void)loginFailure
{
    _loginBtn.enabled = YES;
    [SCProgressHUD showErrorWithStatus:@"请求超时，请稍后再试"];
}


- (UIView *)createHeaderView
{
    //表头
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 300)];
    header.backgroundColor = [UIColor clearColor];
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, Screen_Width, 50)];
    l1.font = [UIFont systemFontOfSize:30];
    l1.textColor = [UIColor colorWithRed:20 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    l1.text = @"心医学院";
    l1.textAlignment = NSTextAlignmentCenter;
    [header addSubview:l1];
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, Screen_Width, 15)];
    l2.font = [UIFont systemFontOfSize:14];
    l2.textColor = [UIColor colorWithRed: 252/ 255. green: 204/ 255. blue: 104/ 255. alpha:1];
    l2.text = @"学员端 beta";
    l2.textAlignment = NSTextAlignmentCenter;
    [header addSubview:l2];
    return header;
}

- (UIView *)createFooterView
{
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    footer.backgroundColor = [UIColor clearColor];
    
    //    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(55, 0, Screen_Width - 55 * 2, .5)];
    //    line.backgroundColor = RGBACOLOR(17, 83, 146, 1);
    //    [footer addSubview:line];
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 30, Screen_Width - 50 * 2, 45)];
    loginBtn.backgroundColor = [UIColor colorWithRed:22 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    //    UIImage *image = [UIImage imageNamed:@"Button_graybg"];
    //    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"Button_graybg"] stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateSelected];
    
    [loginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:15], NSFontAttributeName ,nil]] forState:UIControlStateNormal];    
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:loginBtn];
    _loginBtn = loginBtn;
    _loginBtn.enabled = NO;
    
    
    
    
    
    
    return footer;
}
#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"LoginCell";
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tf.font = [UIFont systemFontOfSize:13];
    cell.tf.textColor = COLOR_RGB(17, 83, 146);
    cell.tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!(indexPath.row % 2)) {
        cell.icon.image = [UIImage imageNamed:@"phoneIcon"];
        cell.tf.placeholder = @"请输入手机号码";
//        cell.tf.keyboardType = UIKeyboardTypeNumberPad;
        cell.tf.secureTextEntry = NO;
        cell.tf.text = _userTF.text;
        cell.tf.delegate = self;
        _userTF = cell.tf;
 
    } else {
        
        cell.icon.image = [UIImage imageNamed:@"lockIcon"];
        cell.tf.placeholder = @"请输入密码";

//        cell.tf.keyboardType = UIKeyboardTypeASCIICapable;
        cell.tf.secureTextEntry = YES;
        cell.tf.text = cell.tf.text;
        cell.tf.delegate = self;
        _pdTF = cell.tf;
    }
    
//    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld",indexPath.row];
//    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 55, 0, 55);
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 55, 0, 55)];
    }

}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _userTF) {

    } else {
        if ([_userTF.text length]) {
            [self loginBtnClick];
        }
    }
    return YES;
}

- (void)inputViewTextChanged:(NSNotification *)noti
{
    if ([_userTF.text length] && [_pdTF.text length]) {
        
        _loginBtn.enabled = YES;
    } else {
     
        _loginBtn.enabled = NO;
    }
}

@end
