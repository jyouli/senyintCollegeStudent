//
//  SCTextTableViewController.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/19.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCTextTableViewController.h"
#import "YLBaseTableView.h"
@interface SCTextTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak)UITableView *tableView;

@end

@implementation SCTextTableViewController

- (void)loadView {
    [super loadView];
    
    YLBaseTableView *view = [[YLBaseTableView alloc] initWithFrame:self.view.frame style:self.style];
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    view.delegate = self;
    view.dataSource = self;
    self.view = view;
    self.tableView = view;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)
         ];
    }
    
    
    
    UIView *v = [[UIView alloc] init];
    self.tableView.tableFooterView = v;

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

#pragma mark ==UITableViewDelegate
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
