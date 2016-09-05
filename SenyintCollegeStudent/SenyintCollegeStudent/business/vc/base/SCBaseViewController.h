//
//  SCBaseViewController.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"

#import "AppSetting.h"
/**
 继承自UIViewController
 处理edgesForExtendedLayout
 设置屏幕方向（竖屏 不允许旋转）
 */
@interface SCBaseViewController : UIViewController
@property (nonatomic, copy) NSString *backImageStr;

@end
