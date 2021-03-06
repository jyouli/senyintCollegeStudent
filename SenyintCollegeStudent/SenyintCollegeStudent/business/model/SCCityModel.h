//
//  SCCityModel.h
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCCityModel : NSObject

@property (nonatomic , strong) NSString * severId;//该城市对应的服务器id
@property (nonatomic , strong) NSString * provId;//省id
@property (nonatomic , strong) NSString * cityId;//市id  为省model时，此字段无效
@property (nonatomic , strong) NSString * name;//省/市名字

/**
 设置参数
 */
- (void)setModel:(SCCityModel *)model;

@end
