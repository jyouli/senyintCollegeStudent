//
//  YLBaseTableView.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
/* YLBaseTableView继承自UITableView
 实现功能
 1、实现视图上下弹拉效果 避免输入文字时视图上的空间被键盘遮挡效果
 2、触摸视图空白处，实现键盘消失效果
 **/

@interface YLBaseTableView : UITableView

/**
 用来给获取bgview做参数设置  给UITableViewbackgroundView的添加tap点击 
 用来解决UITableView的点击截取cell点击的问题
 */
@property (nonatomic, weak, readonly) UIView *bgview;

- (void) setBaseTableViewContentInset:(UIEdgeInsets)contentInset;
@end
