//
//  HospitalModel.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HospitalModel : NSObject
@property (nonatomic, copy) NSString *hosId;
@property (nonatomic, copy) NSString *hosName;
@property (nonatomic, copy) NSString * provId;//医院所在省id
@property (nonatomic, copy) NSString * cityId;//市id  为省model时，此字段无效
@property (nonatomic, copy) NSString * provName;//省名字
@property (nonatomic, copy) NSString * cityName;//市名字
@end
