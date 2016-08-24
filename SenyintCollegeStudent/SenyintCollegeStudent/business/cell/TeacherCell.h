//
//  TeacherCell.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherModel.h"
@interface TeacherCell : UITableViewCell
@property (nonatomic, strong) TeacherModel *teacherInfo;
@property (nonatomic, weak) UITableView *tableview;
@end
