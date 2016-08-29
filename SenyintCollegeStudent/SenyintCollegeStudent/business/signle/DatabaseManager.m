//
//  DataBaseManager.m
//  cmaEduApp
//
//  Created by 蒋友利 on 16/4/19.
//  Copyright © 2016年 蒋友利. All rights reserved.
//

#import "DatabaseManager.h"
#import "NSFileManager+util.h"
#import "FMDatabase.h"
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMResultSet.h"
#import "FMDatabaseAdditions.h"


#import "SCCityModel.h"
#import "SCTitleModel.h"
#import "SCSpecialtyModel.h"

@implementation DatabaseManager

+ (NSString *)getDatabasePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/database.sqlite"];
    //    if (![NSFileManager removeFileFromPath:filePath]) {
    //        // 删除失败
    //        NSLog(@"Documents/database.sqlite remove failed or file not exists!");
    //    }
    
    NSString *sandboxVerDBPath = [NSString stringWithFormat:@"Documents/data/database001.sqlite"];
    NSString *verFilePath = [NSHomeDirectory() stringByAppendingPathComponent:sandboxVerDBPath];
    //如果沙盒中数据库文件不存在则从APP包中拷贝一份
    if (![fileManager fileExistsAtPath:verFilePath]) {
        NSString *sandboxPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/data"];
        if ([fileManager fileExistsAtPath:sandboxPath]) {
            if ([NSFileManager removeFromPath:sandboxPath ofFile:nil] < 1) {
                // 删除失败
                NSLog(@"%@ remove failed or file not exists!", sandboxPath);
            }
        } else {
            // 不存在，则创建目录
            [fileManager createDirectoryAtPath:sandboxPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        NSString *srcPath = [[NSBundle mainBundle]pathForResource:@"database" ofType:@"sqlite"];
        NSError *error;
        if (![fileManager copyItemAtPath:srcPath toPath:verFilePath error:&error]) {
            // 拷贝失败
            NSLog(@"database.sqlite When setup db: %@", [error localizedDescription]);
        }
    }
    return verFilePath;
}

+ (NSArray *)getAddressArrayWithId:(int)provId
{
    NSMutableArray *listArray = [[NSMutableArray alloc] init];
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return listArray;
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    
    [fmdb open];
    
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"dict_city"] || ![fmdb tableExists:@"dict_province"]) {
        [fmdb close];
        return listArray;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    if (provId == 0) {
        
        FMResultSet *rs = [fmdb executeQuery:@"select sever_id,prov_id,name from dict_province"];
        while ([rs next])
        {
            SCCityModel *model  = [[SCCityModel alloc] init];
            model.severId       = [rs stringForColumn:@"sever_id"];
            model.provId        = [rs stringForColumn:@"prov_id"];
            model.name          = [rs stringForColumn:@"name"];
            [listArray addObject:model];
        }
        
        [rs close];
    }
    else{
        
        FMResultSet *rs = [fmdb executeQuery:@"select sever_id,prov_id,city_id,name,area_id from dict_city where prov_id=?",[NSString stringWithFormat:@"%d",provId]];
        
        while ([rs next])
        {
            SCCityModel *model  = [[SCCityModel alloc] init];
            model.severId       = [rs stringForColumn:@"sever_id"];
            model.provId        = [rs stringForColumn:@"prov_id"];
            model.cityId        = [rs stringForColumn:@"city_id"];
            model.name          = [rs stringForColumn:@"name"];
            [listArray addObject:model];
        }
        
        [rs close];
    }
    
    [fmdb close];
    
    return listArray;
}

+ (NSArray *)getSpecialtyArrayWithId:(int)parentId
{
    NSMutableArray *listArray = [[NSMutableArray alloc] init];
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return listArray;
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    
    [fmdb open];
    
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"dict_specialty"]) {
        [fmdb close];
        return listArray;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select sever_id,pid,specialty_id,specialty_name from dict_specialty where pid=?",[NSString stringWithFormat:@"%d",parentId]];
    
    while ([rs next])
    {
        SCSpecialtyModel *model  = [[SCSpecialtyModel alloc] init];
        model.severId       = [rs stringForColumn:@"sever_id"];
        model.pid           = [rs stringForColumn:@"pid"];
        model.specialtyId   = [rs stringForColumn:@"specialty_id"];
        model.name          = [rs stringForColumn:@"specialty_name"];
        [listArray addObject:model];
    }
    
    [rs close];
    
    [fmdb close];
    
    return listArray;
}

+ (NSString *)getSpecialtyNameWithId:(int)sepcialtyId
{
    NSString *name = nil;
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return @"";
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    [fmdb open];
    
    //如果表或者数据库文件不存在则直接返回空
    if (![fmdb tableExists:@"dict_specialty"]) {
        [fmdb close];
        return @"";
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select specialty_name from dict_specialty where specialty_id=?",[NSNumber numberWithInt:sepcialtyId]];
    
    while ([rs next])
    {
        
        name  = [rs stringForColumn:@"specialty_name"];
    }
    
    [rs close];
    [fmdb close];
    
    return name;
}


/**
 * 获取职称列表
 */
+ (NSArray *)getTitleArray
{
    
    NSMutableArray *listArray = [[NSMutableArray alloc] init];
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return listArray;
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    [fmdb open];
    
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"dict_medical_title"]) {
        [fmdb close];
        return listArray;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select sever_id,title_id,title_name from dict_medical_title"];
    
    while ([rs next])
    {
        SCTitleModel *model = [[SCTitleModel alloc] init];
        model.severId   = [rs stringForColumn:@"sever_id"];
        model.titleId   = [rs stringForColumn:@"title_id"];
        model.name      = [rs stringForColumn:@"title_name"];
        [listArray addObject:model];
    }
    
    [rs close];
    [fmdb close];
    
    return listArray;
}

+ (NSString *)getTitleNameWithId:(int)titleId
{
    
    NSString *name = nil;
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return @"";
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    [fmdb open];
    
    //如果表或者数据库文件不存在则直接返回空
    if (![fmdb tableExists:@"dict_medical_title"]) {
        [fmdb close];
        return @"";
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select title_name from dict_medical_title where title_id=?",[NSNumber numberWithInt:titleId]];
    
    while ([rs next])
    {
        
        name  = [rs stringForColumn:@"title_name"];
    }
    
    [rs close];
    [fmdb close];
    
    return name;
}

@end
