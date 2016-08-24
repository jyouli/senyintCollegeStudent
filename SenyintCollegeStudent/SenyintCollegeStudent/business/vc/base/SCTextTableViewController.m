//
//  SCTextTableViewController.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/19.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCTextTableViewController.h"
#import "YLBaseTableView.h"
@interface SCTextTableViewController ()

@end

@implementation SCTextTableViewController

- (void)loadView {
    [super loadView];
    
    YLBaseTableView *view = [[YLBaseTableView alloc] initWithFrame:self.view.frame style:self.tableView.style];
    view.delegate = self;
    view.dataSource = self;
    self.view = view;

}
@end
