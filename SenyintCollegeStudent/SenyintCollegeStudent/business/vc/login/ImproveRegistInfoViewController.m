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
#import "UIImage+Rend.h"
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
    
    [self.navigationController. navigationBar setBackgroundImage:[[UIImage imageNamed:@"green_nav_bg"] stretchableImageWithLeftCapWidth:1 topCapHeight:1] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage createImageWithColor:Shadow_Color]];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 70, 30)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"surebtn_bg"] forState:UIControlStateNormal];
    
    [sureBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"确认" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBarSonControl_Font_Color, NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(commitBtnClick)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:@"RegistInfoInputCell"];
    
    [self createFooterView];

}

- (void)createFooterView
{
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 100)];
    footer.backgroundColor = [UIColor clearColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width - BodyContent_FlexibleLeft * 2, .5)];
    line.backgroundColor = self.tableView.separatorColor;
    [footer addSubview:line];
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 30, Screen_Width - 50 * 2, 45)];
    UIImage *image = [UIImage imageNamed:@"login"];
    [commitBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateNormal];
    
    [commitBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"确认" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:commitBtn];
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
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
        }

        
        
        [self.navigationController pushViewController:vc animated:YES];
    }

    
   
}


@end
