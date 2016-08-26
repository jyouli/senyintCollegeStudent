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


#import "ImproveRegistInfoViewController.h"

@interface EnterViewController ()

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"开启新的教与学体验之旅";
   
    self.tableView.tableHeaderView = label;
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
            [self.navigationController pushViewController:[[PasswordLoginViewController alloc] init] animated:YES];

            break;
        case 1:
        {
            RegisterViewController *vc = [[RegisterViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 2:
            [self.navigationController pushViewController:[[ImproveRegistInfoViewController alloc] init] animated:YES];

            break;
        default:
            break;
    }



}



@end
