//
//  SCTextTableViewController.h
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/19.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController.h"

/**
 继承自SCBaseTableViewController
 使用了自定义的TableView
 处理了键盘遮挡问题
 点击空白处键盘会消失
 */
@interface SCTextTableViewController : SCBaseViewController

@property (nonatomic, assign)UITableViewStyle style;

@property (nonatomic, weak, readonly)UITableView *tableView;
@end
