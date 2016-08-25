//
//  CellModel.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "CellModel.h"

@implementation CellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellAccessoryType = UITableViewCellAccessoryNone;
        self.cellSelectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return self;
}

@end
