//
//  BaseLoginViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "BaseLoginViewController.h"
#import "LoginPasswordCell.h"
#import "LoginVerificationCodeCell.h"
#import "YLRegularCheck.h"
#import "YLStringTool.h"
@implementation BaseLoginViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [self.tableView reloadData];

    
}

- (void)viewWillDisappear:(BOOL)animated
{
    //关闭验证码定时器 避免循环引用
    [[VerificationCodeCountdownSingle sharedCodeCountdownSingle] closeTimer];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    self.dataArray = nil;
    [super didReceiveMemoryWarning];
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
                
    }
    return _dataArray;
    
}

- (void)viewDidLoad
{
    self.backImageName = @"nav_back_gray";
    [super viewDidLoad];
    
    [self.navigationController. navigationBar setBackgroundImage:[[UIImage imageNamed:@"white_nav_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.tableView registerClass:[LoginCell class] forCellReuseIdentifier:NSStringFromClass([LoginCell class])];
    [self.tableView registerClass:[LoginVerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([LoginVerificationCodeCell class])];
    [self.tableView registerClass:[LoginPasswordCell class] forCellReuseIdentifier:NSStringFromClass([LoginPasswordCell class])];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self creatHeaderView];


}

//表头
- (void)creatHeaderView
{
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height - 64)/2 )];
    header.contentMode = UIViewContentModeCenter;
    header.image = [UIImage imageNamed:@"logo_senyint"];
    self.tableView.tableHeaderView = header;
    
}


#pragma mark ==通知回调 子类重写
//粘贴 剪切触发 清除按钮触发   KVC程序写入（tf.text=@""）不触发
- (void)textFieldChange:(NSNotification *)noti
{
    NSLog(@"textFieldChange");
}

#pragma mark 重写_userT，_vercodeTF，_pwTF的set方法 默认不允许修改
- (void)setUserTF:(UITextField *)userTF
{
    return;
}

- (void)setVercodeTF:(UITextField *)vercodeTF
{
    return;
}

- (void)setPwTF:(UITextField *)pwTF
{

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
        _userTF = cell.tf;
    } else if ([model.cellClassName isEqualToString:NSStringFromClass([LoginVerificationCodeCell class])]) {
        
        _vercodeTF = cell.tf;
    } else {
        
        _pwTF = cell.tf;
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
