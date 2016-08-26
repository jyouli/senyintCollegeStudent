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
 * 获取省市数据
 * @param provId：为0时表示获取所有的省，其他为该id对应的该省下所有的城市
 */
+ (NSArray *)getAddressArrayWithId:(int)provId;

/**
 * 根据id获取城市名字
 * @param cityId：城市的Id
 */
+ (NSString *)getcityNameWithId:(int)cityId;

/**
 * 获取科室数据
 * @param parentId：为0时表示获取一级专科数据，其他为该一级专科的所有下级数据
 */
+ (NSArray *)getSpecialtyArrayWithId:(int)parentId;

/**
 * 根据id获取专科名字
 * @param sepcialtyId：科室id
 */
+ (NSString *)getSpecialtyNameWithId:(int)sepcialtyId;

/**
 * 获取所有职称列表
 */
+ (NSArray *)getTitleArray;

/**
 * 获取职称名字根据职称id
 * @param titleId：职称id
 */
+ (NSArray *)getTitleNameWithId:(int)titleId;

@end
