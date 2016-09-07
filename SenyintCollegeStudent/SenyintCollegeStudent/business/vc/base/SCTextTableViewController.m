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
    
    YLBaseTableView *baseTableView = [[YLBaseTableView alloc] initWithFrame:self.view.frame style:self.style];
    baseTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    self.view = baseTableView;
    self.tableView = baseTableView;
    
}
@end
