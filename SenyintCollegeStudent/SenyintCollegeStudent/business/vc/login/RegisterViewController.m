//
//  RegisterViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegistInfoInputCell.h"
#import "VerificationCodeCell.h"
#import "YLRegularCheck.h"
#import "PasswordLoginViewController.h"
#import "ImproveRegistInfoViewController.h"
@interface RegisterViewController (){
    __weak UIButton *_registBtn;
}

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)  UITextField *userTF;
@property (nonatomic, weak)  UITextField *verTF;
@end

@implementation RegisterViewController

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
    self.title = @"注册";
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:NSStringFromClass([RegistInfoInputCell class])];
    [self.tableView registerClass:[VerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([VerificationCodeCell class])];
    
    [self creatFooterView];
        
}

- (void)loginBtnClick
{
    PasswordLoginViewController *loginvc = [[PasswordLoginViewController alloc] init];
    loginvc.userPhone = self.userTF.text;
    [self.navigationController pushViewController:loginvc animated:YES];
    
}
- (void)registBtnClick
{
    [self.view endEditing:YES];
    
    //格式校验
    
    if (self.userTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:self.userTF.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    if (self.verTF.text.length == 0 || ![YLRegularCheck checkpassword:self.verTF.text]) {
        [SCProgressHUD showInfoWithStatus:@"请输入6-20位字母或数字密码"];
        return;
    }
    
    
    [self.navigationController pushViewController:[[ImproveRegistInfoViewController alloc] init] animated:YES];
    
    
}


- (void)creatFooterView
{
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, Screen_Width - 40, 45)];
    registBtn.backgroundColor = [UIColor colorWithRed:22 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    registBtn.layer.masksToBounds = YES;
    registBtn.layer.cornerRadius = 5;
    //    UIImage *image = [UIImage imageNamed:@"Button_graybg"];
    //    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"Button_graybg"] stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateSelected];
    
    [registBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"注册" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:registBtn];
    _registBtn = registBtn;
    _registBtn.enabled = NO;
    
    
    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 70, 30)];
    loginBtn.center = CGPointMake(footer.center.x, 85);
    [loginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor redColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:14], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:loginBtn];
    
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:5];
        InfoTextFieldCellModel *mode1 = [[InfoTextFieldCellModel alloc] init];
        mode1.infoName = @"手机号";
        mode1.textFieldPlaceholder = @"请输入手机号";
        mode1.textFieldKeyboardType = UIKeyboardTypePhonePad;
        mode1.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        [_dataArray addObject:mode1];
        
        InfoTextFieldCellModel *mode2 = [[InfoTextFieldCellModel alloc] init];
        mode2.infoName = @"验证码";
        mode2.textFieldPlaceholder = @"请输入验证码";
        mode2.textFieldKeyboardType = UIKeyboardTypeNumberPad;
        mode2.cellClassName = NSStringFromClass([VerificationCodeCell class]);
        [_dataArray addObject:mode2];
        
        
    }
    return _dataArray;
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

- (UITextField *)verTF
{
    if (!_verTF) {
        InfoTextFieldCell *cell = [self.tableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        _verTF = cell.infoTextField;
        
    }
    return _verTF;
}

- (void)textFieldChange:(NSNotification *)noti
{
    if ([self.userTF.text length] && [self.verTF.text length]) {
        _registBtn.enabled = YES;
    } else {
        
        _registBtn.enabled = NO;
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
