//
//  AddHospitalViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "AddHospitalViewController.h"
#import "RegistInfoInputCell.h"
#import "SelectProvincesCitiesViewController.h"
@interface AddHospitalViewController ()
{
    SCCityModel *_cityModel;
    SCCityModel *_provModel;

}
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation AddHospitalViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加医院";
    
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 70, 30)];
    [sureBtn setBackgroundImage:[UIImage imageNamed:@"surebtn_bg"] forState:UIControlStateNormal];
    
    [sureBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"完成" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBarSonControl_Font_Color, NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [sureBtn addTarget:self action:@selector(commitBtnClick)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:sureBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:@"RegistInfoInputCell"];
    

}

- (void)commitBtnClick
{

}

- (NSMutableArray *)dataArray
{
    if (!_cityModel) {
        _cityModel = [[SCCityModel alloc] init];
    }
    
    if (!_provModel) {
        _provModel = [[SCCityModel alloc] init];
    }
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:5];
        InfoTextFieldCellModel *mode1 = [[InfoTextFieldCellModel alloc] init];
        mode1.infoName = @"地区";
        mode1.textFieldPlaceholder = @"请选择您所在的地区";
        mode1.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode1.textFieldEnabled = NO;
        mode1.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mode1.jumpType = 3;
        mode1.jumpVCClassName = NSStringFromClass([SelectProvincesCitiesViewController class]);
        [_dataArray addObject:mode1];
        
        InfoTextFieldCellModel *mode2 = [[InfoTextFieldCellModel alloc] init];
        mode2.infoName = @"医院";
        mode2.textFieldPlaceholder = @"请输入您的医院名称";
        mode2.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        [_dataArray addObject:mode2];
        
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
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView endEditing:YES];
    
    InfoTextFieldCellModel *model = [self.dataArray objectAtIndex:indexPath.row];
    if (model.jumpType == 3) {
        SelectProvincesCitiesViewController *vc = [[SelectProvincesCitiesViewController alloc] init];
        vc.cityModel = _cityModel;
        vc.provModel = _provModel;
        if ([vc respondsToSelector:@selector(setCellModel:)]) {
            [vc performSelector:@selector(setCellModel:) withObject:model];
        }
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nc animated:YES completion:nil];
    }
    
    
}

@end
