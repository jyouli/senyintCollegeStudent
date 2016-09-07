//
//  SCBaseTableViewController.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

#import "AppSetting.h"
/**
 继承自UITableViewController 系统处理了键盘遮挡问题 但是没有键盘消失处理
 处理edgesForExtendedLayout
 设置屏幕方向（竖屏 不允许旋转）
 */

@interface SCBaseTableViewController : UITableViewController
@property (nonatomic, copy) NSString *backImageStr;

- (void)navback;
@end
