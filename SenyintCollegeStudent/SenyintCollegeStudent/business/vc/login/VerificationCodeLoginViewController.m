//
//  VerificationCodeLoginViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "VerificationCodeLoginViewController.h"
#import "LoginVerificationCodeCell.h"
#import "PasswordLoginViewController.h"
#import "YLRegularCheck.h"

@interface VerificationCodeLoginViewController ()
{
    __weak UIButton *_loginBtn;
}

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)  UITextField *userTF;
@property (nonatomic, weak)  UITextField *vercodeTF;
@end

@implementation VerificationCodeLoginViewController

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [super viewWillAppear:animated];
    
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [[VerificationCodeCountdownSingle sharedCodeCountdownSingle] closeTimer];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    
    [self.tableView registerClass:[LoginCell class] forCellReuseIdentifier:NSStringFromClass([LoginCell class])];
    [self.tableView registerClass:[LoginVerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([LoginVerificationCodeCell class])];    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self creatHeaderView];
    [self creatFooterView];
    
    
    UIButton *verloginBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 60, 30)];
    [verloginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"密码登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBar_bg_Color, NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [verloginBtn addTarget:self action:@selector(loginUsedPassword)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:verloginBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    


    
    
}

- (void)loginUsedPassword
{
    PasswordLoginViewController *pwLoginvc = [[PasswordLoginViewController alloc] init];
    pwLoginvc.userPhone = self.userTF.text;
    pwLoginvc.backImageStr = @"nav_back_gray";
    [self.navigationController pushViewController:pwLoginvc animated:YES];
    
}

- (void)commitBtnClick
{
    NSLog(@"commitBtnClick");
    [self.view endEditing:YES];
    
    if (self.userTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:self.userTF.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
        
    [SCProgressHUD showInfoWithStatus:@"调接口"];
    //通过校验之后 调用登录接口
}



- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        _dataArray = [[NSMutableArray alloc] initWithCapacity:3];
        LoginCellModel *mode1 = [[LoginCellModel alloc] init];
        mode1.textFieldPlaceholder = @"请输入手机号";
        mode1.textFieldinfo = self.userPhone;
        mode1.textFieldKeyboardType = UIKeyboardTypeNumberPad;
        mode1.cellClassName = NSStringFromClass([LoginCell class]);
        [_dataArray addObject:mode1];
        
        
        LoginCellModel *mode2 = [[LoginCellModel alloc] init];
        mode2.textFieldPlaceholder = @"请输入验证码";
        mode2.textFieldKeyboardType = UIKeyboardTypeNumberPad;
        mode2.verificationCodeCountdownKey = Countdown_ForgetPassWord;
        mode2.cellClassName = NSStringFromClass([LoginVerificationCodeCell class]);
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
    
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, Screen_Width - 60, 45)];
    UIImage *image = [UIImage imageNamed:@"login"];
    [commitBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateNormal];
    [commitBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _loginBtn = commitBtn;
    _loginBtn.enabled = NO;
    [footer addSubview:commitBtn];
    
    
    
    
}


#pragma mark ==通知回调
- (void)textFieldChange:(NSNotification *)noti
{
    if ([self.userTF.text length] && [self.vercodeTF.text length]) {
        _loginBtn.enabled = YES;
    } else {
        
        _loginBtn.enabled = NO;
    }
    
}

#pragma mark ==UITableViewDataSource

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
    } else if ([model.cellClassName isEqualToString:NSStringFromClass([LoginVerificationCodeCell class])]) {
        
        self.vercodeTF = cell.tf;
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
