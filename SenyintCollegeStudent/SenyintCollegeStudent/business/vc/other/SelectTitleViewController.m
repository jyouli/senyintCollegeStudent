//
//  SelectTitleViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SelectTitleViewController.h"
#import "DatabaseManager.h"
@interface SelectTitleViewController ()

@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation SelectTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择职称";
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:@"nav_close"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismissback) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = back;

    
}

- (void)dismissback
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithArray:[DatabaseManager getTitleArray]];
        
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
    return cell;

}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.titleModel  setModel:self.dataArray[indexPath.row]];
    self.cellModel.textFieldinfo = self.titleModel.name;
    [self dismissback];
}
@end
