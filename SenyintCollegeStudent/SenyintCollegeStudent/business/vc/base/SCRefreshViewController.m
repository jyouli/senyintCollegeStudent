//
//  SCRefreshViewController.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCRefreshViewController.h"
#import "MJRefresh.h"
@interface SCRefreshViewController ()
//@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation SCRefreshViewController

/**
 * 添加下拉刷新
 */
- (void) setRefreshNormalHeader:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)(void)) headerFresh
{
    _headerScrollView = scrollview;
    __weak typeof(_headerScrollView) safeview = _headerScrollView;
    if (headerFresh) {
        _headerScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerFresh];

    } else {
        _headerScrollView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [NSThread sleepForTimeInterval:1];
            [safeview.mj_header endRefreshing];
        }];

    }
    

}

/**
 * 添加上拉刷新
 */
- (void) setRefreshBackNormalFooter:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)())footerFresh
{
    _footerScrollView = scrollview;
    __weak typeof(_footerScrollView) safeview = _footerScrollView;
    if (footerFresh) {
        _footerScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footerFresh];
        
    } else {
        _footerScrollView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
            [NSThread sleepForTimeInterval:1];
            [safeview.mj_footer endRefreshing];
        }];
        
    }

}

/**
 * 停止下拉刷新
 */
- (void)endRefreshingHeaderFreshView
{
    [self endRefreshingHeaderFreshView:self.headerScrollView];
    
}

/**
 * 停止上拉刷新
 */
- (void)endRefreshingFooterFreshView
{
    [self endRefreshingFooterFreshView:self.footerScrollView];
 
}

/**
 * 停止下拉刷新
 */
- (void)endRefreshingHeaderFreshView:(UIScrollView *)scrollview
{
    if (scrollview.mj_header.isRefreshing) {
        [scrollview.mj_header endRefreshing];
        
    }

}

/**
 * 停止上拉刷新
 */
- (void)endRefreshingFooterFreshView:(UIScrollView *)scrollview
{
    if (scrollview.mj_footer.isRefreshing) {
        [scrollview.mj_footer endRefreshing];
        
    }
}

@end
