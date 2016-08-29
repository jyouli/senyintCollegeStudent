//
//  SelectDepartmentViewController.h
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"
#import "InfoTextFieldCellModel.h"
#import "SCSpecialtyModel.h"
@interface SelectDepartmentViewController : SCBaseTableViewController

@property (nonatomic, strong) InfoTextFieldCellModel *cellModel;
@property (nonatomic, strong) SCSpecialtyModel *deptModel;
@property (nonatomic, assign) int  parentId;//查数据库用到 一级科室为0 二级科室为其所属一级科室的id

@end
