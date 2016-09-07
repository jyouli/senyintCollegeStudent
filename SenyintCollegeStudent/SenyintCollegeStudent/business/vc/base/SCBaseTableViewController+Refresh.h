//
//  SCBaseTableViewController+Refresh.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"
#import "MJRefresh.h"

/**
 SCBaseTableViewController扩展
 方便给tableview添加下拉刷新 上拉加载功能
 */
@interface SCBaseTableViewController (Refresh)

/**
 * 给self.tableview添加下拉刷新
 * headerFresh: 下拉回调Block
 */
- (void) setRefreshNormalHeaderWithRefreshingBlock:(void (^)(void)) headerFresh;


/**
 * 给self.tableview添加上拉刷新
 * footerFresh: 上拉回调Block
 */
- (void) setRefreshBackNormalFooterWithRefreshingBlock:(void (^)())footerFresh;


/**
 * self.tableview停止下拉刷新
 */
- (void)endRefreshingHeaderFreshView;


/**
 * self.tableview停止上拉刷新
 */
- (void)endRefreshingFooterFreshView;
@end
