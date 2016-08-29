//
//  SelectTitleViewController.h
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"
#import "InfoTextFieldCellModel.h"
#import "SCTitleModel.h"
@interface SelectTitleViewController : SCBaseTableViewController

@property (nonatomic, strong) InfoTextFieldCellModel *cellModel;
@property (nonatomic, strong) SCTitleModel *titleModel;
@end
