//
//  RegisterViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegistInfoInputCell.h"
#import "VerificationCodeCell.h"
@interface RegisterViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:NSStringFromClass([RegistInfoInputCell class])];
    [self.tableView registerClass:[VerificationCodeCell class] forCellReuseIdentifier:NSStringFromClass([VerificationCodeCell class])];
    
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:5];
        InfoTextFieldCellModel *mode1 = [[InfoTextFieldCellModel alloc] init];
        mode1.infoName = @"手机号";
        mode1.textFieldPlaceholder = @"请输入手机号";
        mode1.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        [_dataArray addObject:mode1];
        
        InfoTextFieldCellModel *mode2 = [[InfoTextFieldCellModel alloc] init];
        mode2.infoName = @"验证码";
        mode2.textFieldPlaceholder = @"请输入验证码";
        mode2.cellClassName = NSStringFromClass([VerificationCodeCell class]);
        [_dataArray addObject:mode2];
        
        
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
