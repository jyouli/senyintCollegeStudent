//
//  SCBaseTableViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"

@interface SCBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SCBaseTableViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc",self.class);
}

- (instancetype)init
{
    
    return [self initWithStyle:UITableViewStylePlain];
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    if (self = [super init]) {
        
        self.style = style;
    }
    
    return self;
}
- (void)loadView {
    [super loadView];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.frame style:self.style];
    tableview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableview.delegate = self;
    tableview.dataSource = self;
    self.view = tableview;
    _tableView = tableview;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
    
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
