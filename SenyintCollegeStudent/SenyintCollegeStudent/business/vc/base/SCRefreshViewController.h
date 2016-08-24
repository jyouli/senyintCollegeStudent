//
//  SCRefreshViewController.h
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController.h"

/**
 继承自SCBaseViewController
 方便给UIScrollView及其子类控件添加下拉刷新 上拉加载功能
 */
@interface SCRefreshViewController : SCBaseViewController

/**
 *用于绑定上拉刷新控件，可能是子类的tableview等控件
 */
@property (nonatomic, weak,readonly) UIScrollView *headerScrollView;

/**
 *用于绑定下拉刷新控件，可能是子类的tableview等控件
 */
@property (nonatomic, weak,readonly) UIScrollView *footerScrollView;


/**
 * 添加下拉刷新
 */
- (void) setRefreshNormalHeader:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)(void)) headerFresh;

/**
 * 添加上拉刷新
 */
- (void) setRefreshBackNormalFooter:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)())footerFresh;

/**
 * 停止下拉刷新
 */
- (void)endRefreshingHeaderFreshView;

/**
 * 停止上拉刷新
 */
- (void)endRefreshingFooterFreshView;

/**
 * 停止下拉刷新
 * scrollview: 下拉刷新的view
 */
- (void)endRefreshingHeaderFreshView:(UIScrollView *)scrollview;

/**
 * 停止上拉刷新
 * scrollview: 上拉刷新的view
 */
- (void)endRefreshingFooterFreshView:(UIScrollView *)scrollview;

@end
