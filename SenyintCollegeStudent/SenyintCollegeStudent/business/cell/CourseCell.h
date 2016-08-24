//
//  CourseCell.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CourseModel.h"
@interface CourseCell : UITableViewCell

@property (nonatomic, strong) CourseModel *course;
@property (nonatomic, weak,readonly) UIButton *moreBtn;
@property (nonatomic, weak) UITableView *tableview;
@end
