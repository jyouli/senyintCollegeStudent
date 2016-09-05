//
//  EnterViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "EnterViewController.h"
#import "LoginViewController.h"
#import "PasswordLoginViewController.h"
#import "VerificationCodeLoginViewController.h"
#import "RegisterViewController.h"
#import "SCVisitViewController.h"

#import "ImproveRegistInfoViewController.h"

#import "UIImage+Rend.h"

@interface EnterViewController ()

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIImage createAndSaveImageColor:[UIColor whiteColor] WithSize:CGSizeMake(300, 64 * 3)];
    [UIImage createAndSaveImageColor:[UIColor whiteColor] WithSize:CGSizeMake(200, 64 * 2)];

    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = nil;

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"开启新的教与学体验之旅";


    self.tableView.tableHeaderView = label;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark ==UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString * cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    cell.backgroundColor = [UIColor lightGrayColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"登录";
            break;
        case 1:
            cell.textLabel.text = @"注册";
            
            
            break;
        case 2:
            cell.textLabel.text = @"体验一下";
            break;
        default:
            break;
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
    
    
    switch (indexPath.row) {
        case 0:
        {
            
            PasswordLoginViewController *vc = [[PasswordLoginViewController alloc] init];
            vc.backImageStr = @"nav_back_gray";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        
        }

        case 1:
        {
            RegisterViewController *vc = [[RegisterViewController alloc] init];
            vc.backImageStr = @"nav_back_gray";
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 2:
            [self.navigationController pushViewController:[[SCVisitViewController alloc] init] animated:YES];

            break;
        default:
            break;
    }



}



@end
