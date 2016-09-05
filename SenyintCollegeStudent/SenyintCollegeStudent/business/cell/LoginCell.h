//
//  LoginCell.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginCellModel.h"
@interface LoginCell : UITableViewCell

@property (nonatomic, weak, readonly) UITextField *tf;
@property (nonatomic, weak, readonly) UIImageView *icon;

@property (nonatomic, strong) LoginCellModel *model;

@end
