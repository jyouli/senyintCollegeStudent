//
//  SelectProvincesCities.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"
#import "InfoTextFieldCellModel.h"
#import "SCCityModel.h"
@interface SelectProvincesCitiesViewController : SCBaseTableViewController

@property (nonatomic, assign)int provId;
@property (nonatomic, strong) InfoTextFieldCellModel *cellModel;
@property (nonatomic, strong)SCCityModel *cityModel;
@property (nonatomic, strong)SCCityModel *provModel;

@end
