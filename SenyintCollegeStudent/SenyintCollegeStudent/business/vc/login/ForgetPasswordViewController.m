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
@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, weak)  UITextField *userTF;
@property (nonatomic, weak)  UITextField *pwTF;
@property (nonatomic, weak)  UITextField *vercodeTF;


@end


@implementation ForgetPasswordViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [[VerificationCodeCountdownSingle sharedCodeCountdownSingle] closeTimer];
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    [self.tableView registerClass:[LoginCell class] forCellReuseIdentifier:NSStringFromClass([LoginCell class])];
    [self.tableView registerClass:[LoginVerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([LoginVerificationCodeCell class])];
    [self.tableView registerClass:[LoginPasswordCell class] forCellReuseIdentifier:NSStringFromClass([LoginPasswordCell class])];

    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self creatHeaderView];
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
        
        LoginCellModel *mode3 = [[LoginCellModel alloc] init];
        mode3.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
        mode3.textFieldPlaceholder = @"请输入6-20位的新密码";
        mode3.cellClassName = NSStringFromClass([LoginPasswordCell class]);
        mode3.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode3];
        
    }
    
    return _dataArray;
    
}

//表头
- (void)creatHeaderView
{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, (Screen_Height - 64)/2 )];
    header.contentMode = UIViewContentModeCenter;
    header.image = [UIImage imageNamed:@"logo_senyint"];
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
    [commitBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"完成" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:commitBtn];
    
    
    
    
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
