//
//  SCBaseTableViewController.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController.h"
/**
 *继承自SCBaseViewController, self.view使用UITableView
 */
@interface SCBaseTableViewController :SCBaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, assign)UITableViewStyle style;

@property (nonatomic, weak,readonly)UITableView *tableView;

- (instancetype)initWithStyle:(UITableViewStyle)style;
@end
