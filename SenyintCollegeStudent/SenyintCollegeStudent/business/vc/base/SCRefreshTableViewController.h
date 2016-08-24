//
//  SCRefreshTableViewController.h
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"

/**
 继承自SCBaseTableViewController
 方便给tableview添加下拉刷新 上拉加载功能
 */
@interface SCRefreshTableViewController : SCBaseTableViewController

/**
 * 添加下拉刷新
 */
- (void) setRefreshNormalHeaderWithRefreshingBlock:(void (^)(void)) headerFresh;


/**
 * 添加上拉刷新
 */
- (void) setRefreshBackNormalFooterWithRefreshingBlock:(void (^)())footerFresh;


/**
 * 停止下拉刷新
 */
- (void)endRefreshingHeaderFreshView;


/**
 * 停止上拉刷新
 */
- (void)endRefreshingFooterFreshView;
@end
