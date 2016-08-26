//
//  SCBaseTableViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"

@interface SCBaseTableViewController ()
@end

@implementation SCBaseTableViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ((floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) ) {
        
        //设置4周的都不拉伸
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
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


#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
