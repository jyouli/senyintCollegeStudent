//
//  SCBaseTableViewController+Refresh.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController+Refresh.h"
@implementation SCBaseTableViewController (Refresh)

/**
 * 添加下拉刷新
 */
- (void) setRefreshNormalHeaderWithRefreshingBlock:(void (^)(void)) headerFresh
{
    __weak typeof(self.tableView) safeview = self.tableView;
    if (headerFresh) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerFresh];
        
    } else {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [NSThread sleepForTimeInterval:.5];
            [safeview.mj_header endRefreshing];
        }];
        
    }
    
    
}

/**
 * 添加上拉刷新
 */
- (void) setRefreshBackNormalFooterWithRefreshingBlock:(void (^)())footerFresh
{
    
    __weak typeof(self.tableView) safeview = self.tableView;
    if (footerFresh) {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footerFresh];
        
    } else {
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [NSThread sleepForTimeInterval:.5];
            [safeview.mj_footer endRefreshing];
        }];
        
    }
    
}

/**
 * 停止下拉刷新
 */
- (void)endRefreshingHeaderFreshView
{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
        
    }
}

/**
 * 停止上拉刷新
 */
- (void)endRefreshingFooterFreshView
{
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
        
    }
}


@end
