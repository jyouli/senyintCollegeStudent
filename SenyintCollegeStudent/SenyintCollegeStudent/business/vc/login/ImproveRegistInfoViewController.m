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
#import "YLStringTool.h"
#import "SCSpecialtyModel.h"
#import "SCTitleModel.h"
@interface ImproveRegistInfoViewController ()
{
    SCTitleModel *titleModel;
    SCSpecialtyModel *deptModel;
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
    titleModel = [[SCTitleModel alloc] init];

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
//    _commitBtn = commitBtn;
    
    [self.tableView setTableFooterView:footer];
    
}



- (void)commitBtnClick
{
    [self.view endEditing:YES];
    InfoTextFieldCell *namecell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([YLStringTool isEmpty:namecell.infoTextField.text ] || ![YLRegularCheck checkChineseRealName:namecell.infoTextField.text]) {
        
        [SCProgressHUD showInfoWithStatus:@"请输入真实姓名"];
        return;
    }
    
    InfoTextFieldCell *pwCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];

    if ([YLStringTool isEmpty:pwCell.infoTextField.text ] || ![YLRegularCheck checkpassword:pwCell.infoTextField.text]) {
        [SCProgressHUD showInfoWithStatus:@"请输入6-20位字母或数字密码"];
        return;
    }

    InfoTextFieldCell *hosCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if ([YLStringTool isEmpty:hosCell.infoTextField.text ]) {
        [SCProgressHUD showInfoWithStatus:@"请选择医院"];
        return;
    }

    
    if ([YLStringTool isEmpty:deptModel.name]) {
        [SCProgressHUD showInfoWithStatus:@"请选择科室"];
        return;
    }

    
    if ([YLStringTool isEmpty:titleModel.name]) {
        [SCProgressHUD showInfoWithStatus:@"请选择职称"];
        return;
    }

    [SCProgressHUD showInfoWithStatus:@"调接口"];
    
}

- (NSMutableArray *)dataArray
{
    if (!deptModel) {
        deptModel = [[SCSpecialtyModel alloc] init];
    }
    if (!titleModel) {
        titleModel = [[SCTitleModel alloc] init];
    }
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
        mode2.textFieldKeyboardType = UIKeyboardTypeASCIICapable;
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
        if ([vc respondsToSelector:@selector(setCellModel:)]) {
            [vc performSelector:@selector(setCellModel:) withObject:model];
        }
        
        
        if ([model.jumpVCClassName isEqualToString:NSStringFromClass([SelectTitleViewController class])]) {
            if ([vc respondsToSelector:@selector(setTitleModel:)]) {
                [vc performSelector:@selector(setTitleModel:) withObject:titleModel];
            }

        }
        
        if ([model.jumpVCClassName isEqualToString:NSStringFromClass([SelectDepartmentViewController class])]) {
            if ([vc respondsToSelector:@selector(setDeptModel:)]) {
                [vc performSelector:@selector(setDeptModel:) withObject:deptModel];
            }
            [vc performSelector:@selector(setDeptModel:) withObject:deptModel];
        }

        
        
        [self.navigationController pushViewController:vc animated:YES];
    }

    
   
}


@end
