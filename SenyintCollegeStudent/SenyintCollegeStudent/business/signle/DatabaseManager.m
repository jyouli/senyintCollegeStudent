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

/**
 * 获取专科数据，specialtyNo为0时表示获取一级专科数据，其他为对应的一级专科下级数据
 */
+ (NSArray *)getSpecialtyArrayWithId:(int)sepcialtyId{
    
    //parentID = 0 获取所有一级专科  子专科则根据一级专科specialtyID作为parentID来搜索
    
    NSMutableArray *specialtyListArray = [[NSMutableArray alloc] init];
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return specialtyListArray;
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    [fmdb open];
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"med_specialty"]) {
        [fmdb close];
        return specialtyListArray;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select * from med_specialty where parent_id=?",[NSNumber numberWithInt:sepcialtyId]];
    
    while ([rs next])
    {
//        CMASpecialtyModel *specialty       = [[CMASpecialtyModel alloc] init];
//        specialty.specialtyID           = [rs intForColumn:@"id"];
//        specialty.specialtyParentID     = [rs intForColumn:@"parent_id"];
//        specialty.specialtyName         = [rs stringForColumn:@"name"];
//        specialty.specialtyImgUrl       = [rs stringForColumn:@"img_url"];
        //        specialty.specialtyDisplayOrder = [rs intForColumn:@"create_date"];
        
//        [specialtyListArray addObject:specialty];
    }
    
    [rs close];
    [fmdb close];
    
    return specialtyListArray;

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
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"med_specialty"]) {
        [fmdb close];
        return @"";
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select name from med_specialty where id=?",[NSNumber numberWithInt:sepcialtyId]];
    
    while ([rs next])
    {
        
        name         = [rs stringForColumn:@"name"];
    }
    
    [rs close];
    [fmdb close];
    
    return name;

}


/**
 * 获取职称列表
 */
+ (NSArray *)getTitleArrayWithId:(int)titleId
{
    //parentID = 0 获取所有一级专科  子专科则根据一级专科specialtyID作为parentID来搜索
    
    NSMutableArray *specialtyListArray = [[NSMutableArray alloc] init];
    
    NSString *filePath =  [DatabaseManager getDatabasePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return specialtyListArray;
    }
    
    FMDatabase *fmdb   = [[FMDatabase alloc] initWithPath:filePath];
    [fmdb open];
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"d_medical_title"]) {
        [fmdb close];
        return specialtyListArray;
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select * from d_medical_title where pid=?",[NSNumber numberWithInt:titleId]];
    
    while ([rs next])
    {
//        CMATitleModel *specialty    = [[CMATitleModel alloc] init];
//        specialty.titleId           = [rs intForColumn:@"id"];
//        specialty.pid               = [rs intForColumn:@"parent_id"];
//        specialty.name              = [rs stringForColumn:@"name"];
//        
//        [specialtyListArray addObject:specialty];
    }
    
    [rs close];
    [fmdb close];
    
    return specialtyListArray;
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
    //如果表或者数据库文件不存在则直接返回空数组
    if (![fmdb tableExists:@"d_medical_title"]) {
        [fmdb close];
        return @"";
    }
    
    [fmdb setShouldCacheStatements:YES];
    
    FMResultSet *rs = [fmdb executeQuery:@"select name from d_medical_title where id=?",[NSNumber numberWithInt:titleId]];
    
    while ([rs next])
    {
        
        name  = [rs stringForColumn:@"name"];
    }
    
    [rs close];
    [fmdb close];
    
    return name;
}


@end
