//
//  SelectProvincesCities.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SelectProvincesCitiesViewController.h"

#import "DatabaseManager.h"

@interface SelectProvincesCitiesViewController ()
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation SelectProvincesCitiesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"选择地区";
    if (!self.provId) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [btn setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismissback) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
        
        self.navigationItem.leftBarButtonItem = back;

    }
    
}

- (void)dismissback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithArray:[DatabaseManager getAddressArrayWithId:self.provId]];
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
    if (self.provId == 0) {//当前是省
        
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
    if (self.provId == 0) {//当前是一级科室
        [self.provModel setModel:[self.dataArray objectAtIndex:indexPath.row]];
        self.cellModel.textFieldinfo = self.provModel.name;
        SelectProvincesCitiesViewController *cityvc = [[SelectProvincesCitiesViewController alloc] init];
        cityvc.cityModel = self.cityModel;
        cityvc.cellModel = self.cellModel;
        cityvc.provId = [self.provModel.provId intValue];
        [self.navigationController pushViewController:cityvc animated:YES];
    } else {  //当前是二级科室
        
        [self.cityModel setModel:[self.dataArray objectAtIndex:indexPath.row]];
        self.cellModel.textFieldinfo = [NSString stringWithFormat:@"%@-%@",self.cellModel.textFieldinfo,self.cityModel.name];

        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}
@end
