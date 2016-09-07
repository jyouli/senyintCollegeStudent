//
//  BaseLoginViewController.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCTextTableViewController.h"

/**
 继承自SCTextTableViewController
 登录 注册 找回密码界面抽取
 */

@interface BaseLoginViewController : SCTextTableViewController
//model数组
@property (nonatomic, strong)NSMutableArray *dataArray;
//用来作用户名传参
@property (nonatomic, strong)NSString *userPhone;

//用于存储临时变量 默认不允许修改 只能get
@property (nonatomic, weak)  UITextField *userTF;
@property (nonatomic, weak)  UITextField *pwTF;
@property (nonatomic, weak)  UITextField *vercodeTF;

@end
