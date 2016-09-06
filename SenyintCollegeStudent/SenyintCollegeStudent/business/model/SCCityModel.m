//
//  SCCityModel.m
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCCityModel.h"

@implementation SCCityModel
- (void)setModel:(SCCityModel *)model
{
    self.severId = model.severId;
    self.provId = model.provId;
    self.cityId = model.cityId;
    self.name = model.name;
}

@end
