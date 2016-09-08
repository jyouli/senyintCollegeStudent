//
//  SCTextTableViewController.h
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/19.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController.h"
#import "YLBaseTableView.h"

/**
 继承自SCBaseViewController
 使用了自定义的TableView YLBaseTableView为self.view
 处理了键盘遮挡问题
 点击空白处键盘会消失
 cell默认不触发点击事件，如需触发，设置canSelectedCell属性为YES
 注意：YLBaseTableView与MJRefresh冲突，所以不支持MJRefresh刷新
 */
@interface SCTextTableViewController : SCBaseViewController<UITableViewDelegate,UITableViewDataSource>

/**
 *style: 设置UITableViewStyle的style Loadview之前有效
 */
@property (nonatomic, assign) UITableViewStyle style;
/**
 *canSelectedCell: 设置cell是否可以触发点击事件
 */
@property (nonatomic, assign) BOOL canSelectedCell;//cell是否有点击事件 默认为NO

@property (nonatomic, weak,readonly)YLBaseTableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;

- (instancetype)initWithStyle:(UITableViewStyle)style CanSelectedCell:(BOOL)canSelectedCell;
@end
