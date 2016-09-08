//
//  RefreshTool.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *给UIScrollView及其子类控件添加下拉刷新 上拉加载功能
 *加方法实现
 */
@interface RefreshTool : NSObject

/**
* 添加下拉刷新
* scrollview:  添加下拉效果的view
* headerFresh: 下拉回调block
*/
+ (void) setRefreshNormalHeader:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)(void)) headerFresh;

/**
 * 添加上拉刷新
 * scrollview:  添加上拉效果的view
 * footerFresh: 上拉回调block
 */
+ (void) setRefreshBackNormalFooter:(UIScrollView *)scrollview WithRefreshingBlock:(void (^)())footerFresh;


/**
 * 停止下拉刷新
 * scrollview: 正在下拉刷新的view
 */
+ (void)endRefreshingHeaderFreshView:(UIScrollView *)scrollview;

/**
 * 停止上拉刷新
 * scrollview: 正在上拉刷新的view
 */
+ (void)endRefreshingFooterFreshView:(UIScrollView *)scrollview;
@end
