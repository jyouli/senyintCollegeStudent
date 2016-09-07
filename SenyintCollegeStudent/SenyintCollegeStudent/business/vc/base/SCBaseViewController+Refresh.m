//
//  SCBaseViewController+Refresh.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController+Refresh.h"


@implementation SCBaseViewController (Refresh)

/**
 * 添加下拉刷新
 */
- (void) setRefreshNormalHeader:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)(void)) headerFresh
{
    __weak typeof(scrollview) safeview = scrollview;
    if (headerFresh) {
        scrollview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:headerFresh];
        
    } else {
        scrollview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [NSThread sleepForTimeInterval:2];
            [safeview.mj_header endRefreshing];
        }];
        
    }
    
    
}

/**
 * 添加上拉刷新
 */
- (void) setRefreshBackNormalFooter:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)())footerFresh
{
    __weak typeof(scrollview) safeview = scrollview;
    if (footerFresh) {
        scrollview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:footerFresh];
        
    } else {
        scrollview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [NSThread sleepForTimeInterval:2];
            [safeview.mj_footer endRefreshing];
        }];
        
    }
    
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
