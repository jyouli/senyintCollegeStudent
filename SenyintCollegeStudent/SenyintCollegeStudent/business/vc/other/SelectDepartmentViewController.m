//
//  SelectDepartmentViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SelectDepartmentViewController.h"

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
        _dataArray = [[NSMutableArray alloc] init];
    }
    
    for (int i = 0; i < 100; i ++) {
        [_dataArray addObject:[NSString stringWithFormat:@"科室%d",i]];
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
    cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
    
    return cell;
    
}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.model.textFieldinfo = self.dataArray[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
