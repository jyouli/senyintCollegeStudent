//
//  DataBaseManager.h
//  cmaEduApp
//
//  Created by 蒋友利 on 16/4/19.
//  Copyright © 2016年 蒋友利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DatabaseManager : NSObject


/**
 * 获取省市数据，cityId为0时表示获取所有的省，其他为该id对应的该省下所有的城市
 */
+ (NSArray *)getAddressArrayWithId:(int)cityId;

/**
 * 根据id获取城市名字
 */
+ (NSString *)getcityNameWithId:(int)cityId;

/**
 * 获取科室数据，specialtyNo为0时表示获取一级专科数据，其他为对应的一级专科下级数据
 */
+ (NSArray *)getSpecialtyArrayWithId:(int)sepcialtyId;

/**
 * 根据id获取专科名字
 */
+ (NSString *)getSpecialtyNameWithId:(int)sepcialtyId;

/**
 * 获取所有职称列表
 */
+ (NSArray *)getTitleArray;

/**
 * 获取职称名字根据职称id
 */
+ (NSArray *)getTitleNameWithId:(int)titleId;

@end
