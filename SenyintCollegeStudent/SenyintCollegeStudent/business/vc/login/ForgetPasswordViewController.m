//
//  ForgetPasswordViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "RegistInfoInputCell.h"
#import "VerificationCodeCell.h"
#import "YLRegularCheck.h"
@interface ForgetPasswordViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;

@end


@implementation ForgetPasswordViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:NSStringFromClass([RegistInfoInputCell class])];
    [self.tableView registerClass:[VerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([VerificationCodeCell class])];

    [self creatFooterView];
    
    
}




- (void)commitBtnClick
{
    NSLog(@"commitBtnClick");
    [self.view endEditing:YES];
    
//    if (self.userTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:self.userTF.text]) {
//        
//        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
//        return;
//    }
//    if (self.pwTF.text.length == 0 || ![YLRegularCheck checkpassword:self.pwTF.text]) {
//        [SCProgressHUD showInfoWithStatus:@"请输入6-20位字母或数字密码"];
//        return;
//    }
    
    [SCProgressHUD showInfoWithStatus:@"调接口"];
    //通过校验之后 调用登录接口
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
        mode2.infoName = @"验证码";
        mode2.textFieldPlaceholder = @"请输入验证码";
        mode2.verificationCodeCountdownKey = Countdown_ForgetPassWord;
        mode2.textFieldKeyboardType = UIKeyboardTypeNumberPad;
        mode2.cellClassName = NSStringFromClass([VerificationCodeCell class]);
        [_dataArray addObject:mode2];
        

        
        InfoTextFieldCellModel *mode3 = [[InfoTextFieldCellModel alloc] init];
        mode3.infoName = @"新密码";
        mode3.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
        mode3.textFieldPlaceholder = @"请输入密码";
        mode3.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode3.textFieldSetSecureRightView = YES;
        mode3.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode3];
        
        
        
    }
    return _dataArray;
    
}

- (void)creatFooterView
{
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    footer.backgroundColor = [UIColor clearColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - 55 * 2, .5)];
    line.backgroundColor = self.tableView.separatorColor;
    [footer addSubview:line];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 30, Screen_Width - 50 * 2, 45)];
    commitBtn.backgroundColor = [UIColor colorWithRed:22 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    commitBtn.layer.masksToBounds = YES;
    commitBtn.layer.cornerRadius = 5;
    //    UIImage *image = [UIImage imageNamed:@"Button_graybg"];
    //    [loginBtn setBackgroundImage:[[UIImage imageNamed:@"Button_graybg"] stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateSelected];
    
    [commitBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"确认" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:15], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:commitBtn];
    
    [self.tableView setTableFooterView:footer];
    
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
