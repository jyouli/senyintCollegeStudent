//
//  ImproveRegistInfoViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ImproveRegistInfoViewController.h"
#import "RegistInfoInputCell.h"
#import "SelectHospitalViewController.h"
#import "SelectDepartmentViewController.h"
#import "SelectTitleViewController.h"
#import "YLRegularCheck.h"

@interface ImproveRegistInfoViewController ()
{
    __weak  UIButton *_commitBtn;
    __weak  UITextField *_nameTF;
    __weak  UITextField *_pwTF;
    __weak  UITextField *_hosTF;
    __weak  UITextField *_departTF;
    __weak  UITextField *_titleTF;

}

@property (nonatomic, strong)NSMutableArray *dataArray;
@end
@implementation ImproveRegistInfoViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"完善信息";
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:@"RegistInfoInputCell"];
    
    [self createFooterView];

}

- (void)createFooterView
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
    _commitBtn = commitBtn;
    
    [self.tableView setTableFooterView:footer];
    
}


//- (NSString *)description
//{
//    NSString *str = [super description];
//    
////    return [NSString stringWithFormat:@"%@\nname:%@,pw:%@,hos:%s,dep:%@,title:%@",str,_nameTF.text,_pwTF.text,_hosTF,depart,title];
//}
- (void)commitBtnClick
{
    [self.view endEditing:YES];
    NSLog(@"%@",self);
    
    //格式校验
    
    if (_nameTF.text.length == 0 || ![YLRegularCheck checkMobilePhoneNumber:_nameTF.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入正确手机号"];
        return;
    }
    if (_pwTF.text.length == 0 || ![YLRegularCheck checkpassword:_pwTF.text]) {
        [SCProgressHUD showInfoWithStatus:@"请输入6-24位字母或数字密码"];
        return;
    }

    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:5];
        InfoTextFieldCellModel *mode1 = [[InfoTextFieldCellModel alloc] init];
        mode1.infoName = @"姓 名";
        mode1.textFieldPlaceholder = @"请输入真实姓名";
        mode1.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        [_dataArray addObject:mode1];
        
        InfoTextFieldCellModel *mode2 = [[InfoTextFieldCellModel alloc] init];
        mode2.infoName = @"密 码";
        mode2.textFieldPlaceholder = @"请输入密码";
        mode2.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode2.textFieldSetSecureRightView = YES;
        mode2.textFieldSecureTextEntry = YES;
        [_dataArray addObject:mode2];
        
        InfoTextFieldCellModel *mode3 = [[InfoTextFieldCellModel alloc] init];
        mode3.infoName = @"医 院";
        mode3.textFieldPlaceholder = @"请选择所在医院";
        mode3.textFieldEnabled = NO;

        mode3.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mode3.jumpType = 2;
        mode3.jumpVCClassName = NSStringFromClass([SelectHospitalViewController class]);
        [_dataArray addObject:mode3];
        
        InfoTextFieldCellModel *mode4 = [[InfoTextFieldCellModel alloc] init];
        mode4.infoName = @"科 室";
        mode4.textFieldPlaceholder = @"请选择所在科室";
        mode4.textFieldEnabled = NO;
        mode4.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mode4.jumpType = 2;
        mode4.jumpVCClassName = NSStringFromClass([SelectDepartmentViewController class]);
        [_dataArray addObject:mode4];
        
        
        InfoTextFieldCellModel *mode5 = [[InfoTextFieldCellModel alloc] init];
        mode5.infoName = @"职 称";
        mode5.textFieldPlaceholder = @"请选择相应职称";
        mode5.textFieldEnabled = NO;
        mode5.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mode5.jumpType = 2;
        mode5.jumpVCClassName = NSStringFromClass([SelectTitleViewController class]);
        [_dataArray addObject:mode5];
        
        
//        for (int i = 0 ;i < 6 ; i ++) {
//            InfoTextFieldCellModel *mode1 = [[InfoTextFieldCellModel alloc] init];
//            mode1.infoName = @"姓 名";
//            mode1.textFieldPlaceholder = @"请输入真实姓名";
//            mode1.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
//            [_dataArray addObject:mode1];
//            
//            InfoTextFieldCellModel *mode2 = [[InfoTextFieldCellModel alloc] init];
//            mode2.infoName = @"密 码";
//            mode2.textFieldPlaceholder = @"请输入密码";
//            mode2.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
//            mode2.textFieldSetSecureRightView = YES;
//            mode2.textFieldSecureTextEntry = YES;
//            [_dataArray addObject:mode2];
//            
//            InfoTextFieldCellModel *mode3 = [[InfoTextFieldCellModel alloc] init];
//            mode3.infoName = @"医 院";
//            mode3.textFieldPlaceholder = @"请选择所在医院";
//            mode3.textFieldEnabled = NO;
//            
//            mode3.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
//            mode3.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            mode3.jumpType = 2;
//            //        mode.jumpVCClassName = NSStringFromClass([self class]);
//            [_dataArray addObject:mode3];
//
//        }
        
    }
    
    
    return _dataArray;
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
    RegistInfoInputCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    [cell setModel:model];
    if (indexPath.row == 0) {
        _nameTF = cell.infoTextField;
    }
    
    if (indexPath.row == 1) {
        _pwTF = cell.infoTextField;
    }
    return cell;
}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView endEditing:YES];
    
    InfoTextFieldCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.jumpType == 2) {
        UIViewController *vc = [[NSClassFromString(model.jumpVCClassName) alloc] init];
        if ([vc respondsToSelector:@selector(setModel:)]) {
            [vc performSelector:@selector(setModel:) withObject:model];
        }
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}


@end
