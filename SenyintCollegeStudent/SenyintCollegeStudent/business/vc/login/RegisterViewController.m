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
}

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)  UITextField *userTF;
@property (nonatomic, weak)  UITextField *vercodeTF;
@end

@implementation RegisterViewController

- (void)viewWillAppear:(BOOL)animated
{
    
    [self.navigationController. navigationBar setBackgroundImage:[[UIImage imageNamed:@"white_nav_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    
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

- (void)loadView
{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
   
    if (self.navigationController.navigationBar.hidden) {
        self.navigationController.navigationBar.hidden = NO;
        [self.navigationController. navigationBar setBackgroundImage:[[UIImage imageNamed:@"white_nav_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[UIImage new]];

    }
    
    [self.tableView registerClass:[LoginCell class] forCellReuseIdentifier:NSStringFromClass([LoginCell class])];
    [self.tableView registerClass:[LoginVerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([LoginVerificationCodeCell class])];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self creatHeaderView];
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
        
        _dataArray = [[NSMutableArray alloc] initWithCapacity:3];
        LoginCellModel *mode1 = [[LoginCellModel alloc] init];
        mode1.textFieldPlaceholder = @"请输入手机号";
        mode1.textFieldinfo = self.userPhone;
        mode1.textFieldKeyboardType = UIKeyboardTypePhonePad;
        mode1.cellClassName = NSStringFromClass([LoginCell class]);
        [_dataArray addObject:mode1];
        
        
        LoginCellModel *mode2 = [[LoginCellModel alloc] init];
        mode2.textFieldPlaceholder = @"请输入验证码";
        mode2.textFieldKeyboardType = UIKeyboardTypePhonePad;
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
