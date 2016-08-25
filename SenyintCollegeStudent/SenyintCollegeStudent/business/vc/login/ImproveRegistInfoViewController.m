//
//  ImproveRegistInfoViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ImproveRegistInfoViewController.h"
#import "RegistInfoInputCell.h"

@interface ImproveRegistInfoViewController ()

@property (nonatomic, strong)NSMutableArray *dataArray;
@end
@implementation ImproveRegistInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[RegistInfoInputCell class] forCellReuseIdentifier:@"RegistInfoInputCell"];
    
    self.tableView.separatorColor = [UIColor lightGrayColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)
         ];
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
        //        mode.jumpVCClassName = NSStringFromClass([self class]);
        [_dataArray addObject:mode3];
        
        InfoTextFieldCellModel *mode4 = [[InfoTextFieldCellModel alloc] init];
        mode4.infoName = @"科 室";
        mode4.textFieldPlaceholder = @"请选择所在科室";
        mode4.textFieldEnabled = NO;
        mode4.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode4.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mode4.jumpType = 2;
        //        mode.jumpVCClassName = NSStringFromClass([self class]);
        [_dataArray addObject:mode4];
        
        
        InfoTextFieldCellModel *mode5 = [[InfoTextFieldCellModel alloc] init];
        mode5.infoName = @"职 称";
        mode5.textFieldPlaceholder = @"请选择相应职称";
        mode5.textFieldEnabled = NO;
        mode5.cellClassName = NSStringFromClass([RegistInfoInputCell class]);
        mode5.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        mode5.jumpType = 2;
        //        mode.jumpVCClassName = NSStringFromClass([self class]);
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}

@end
