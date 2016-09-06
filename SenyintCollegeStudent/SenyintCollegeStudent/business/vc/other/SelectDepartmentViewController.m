//
//  SelectDepartmentViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SelectDepartmentViewController.h"
#import "DatabaseManager.h"

@interface SelectDepartmentViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation SelectDepartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"选择科室";
    
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithArray:[DatabaseManager getSpecialtyArrayWithId:self.parentId]];
    }
    
    return _dataArray;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.dataArray = nil;
}


#pragma mark ==UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.textLabel.text = [[self.dataArray objectAtIndex:indexPath.row] name];
    cell.textLabel.font = TextFieldInputText_Font_Size;
    cell.textLabel.textColor = BlackText_Font_Color;
    if (self.parentId == 0) {//当前是一级科室

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
    
}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.deptModel setModel:_dataArray[indexPath.row]];
    if (self.parentId == 0) {//当前是一级科室
        SelectDepartmentViewController *deptvc = [[SelectDepartmentViewController alloc] init];
        deptvc.cellModel = self.cellModel;
        deptvc.deptModel = self.deptModel;
        deptvc.parentId = [self.deptModel.specialtyId intValue];
        [self.navigationController pushViewController:deptvc animated:YES];
    } else {  //当前是二级科室
    
        self.cellModel.textFieldinfo = self.deptModel.name;

        
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers indexOfObject:self] - 2] animated:YES];
        
    }

}

@end
