//
//  EnterViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "EnterViewController.h"
#import "LoginViewController.h"
#import "VerificationCodeLoginViewController.h"
@interface EnterViewController ()

@end

@implementation EnterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"开启新的教与学体验之旅";
    label.backgroundColor = [UIColor lightGrayColor];
   
    self.tableView.tableHeaderView = label;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

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
    
    NSString * cellIdentifier = @"cell";
    UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor lightGrayColor];
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
            [self.navigationController pushViewController:[[VerificationCodeLoginViewController alloc] init] animated:YES];

            break;
        case 1:
        {
            VerificationCodeLoginViewController *vc = [[VerificationCodeLoginViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
            
        case 2:
            break;
        default:
            break;
    }



}

@end
