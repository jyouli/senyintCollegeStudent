//
//  NetworkManager.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/30.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Networktools.h"
#define SystemError_prompt @"网络不给力"
@interface NetworkManager : NSObject
NS_ASSUME_NONNULL_BEGIN
@property (nonatomic, readonly) NSMutableArray <NSURLSessionDataTask*> *dataTaskArray;

+ (instancetype)sharedGlobalSingle;

#pragma mark 项目基础参数
/*
 项目的基础URLString
 */
+ (NSString *)baseURLString;
/**
 项目的基础参数字典
 */
+ (NSDictionary *)userBaseInfo;
/*
 URLString
 对传过来的url进行处理
 */
+ (NSString *)getURLString:(NSString *)str;

#pragma mark  网络请求
/**
 get请求
 URLString:urlstr可以是全部 也可以是不加base
 parameters: 入参
 success: 业务成功回调    回调在主线程
 failure: 业务或报错回调  回调在主线程
 */
+ (void)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                               success:(nullable SuccessBlock)success
                               failure:(nullable FailureBlock)failure;


/**
 get请求
 URLString: urlstr可以是全部 也可以是不加base部分
 parameters: 入参
 downloadProgress:  下载进度回调 默认是在子线程回调
 success: 业务成功回调    回调在主线程
 failure: 业务或报错回调  回调在主线程
 */
+ (void)GET:(NSString *)URLString
                            parameters:(nullable id)parameters
                              progress:(nullable void (^)(NSProgress *downloadProgress))downloadProgress
                               success:(nullable SuccessBlock)success
                               failure:(nullable FailureBlock)failure;




/**
 POST请求
 URLString:  urlstr可以是全部 也可以是不加base部分
 parameters: 入参
 success: 业务成功回调    回调在主线程
 failure: 业务或报错回调  回调在主线程
 */
+ (void)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                                success:(nullable SuccessBlock)success
                                failure:(nullable FailureBlock)failure;

/**
 POST请求
 URLString:  urlstr可以是全部 也可以是不加base
 parameters: 入参
 uploadProgress:  上传进度回调 默认是在子线程回调
 success: 业务成功回调    回调在主线程
 failure: 业务或报错回调  回调在主线程
 */
+ (void)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable SuccessBlock)success
                                failure:(nullable FailureBlock)failure;
#pragma mark end

#pragma mark  网络请求回调业务处理
/*
 网络请求成功业务回调
 responseObject:服务器返回数据
 success:业务成功回调
 failure:业务失败回调
 */
+ (void)systemSuccess:(nullable id)responseObject businessSuccessBlock:(nullable SuccessBlock)success businessSuccessBlock:(nullable FailureBlock)failure;

/*
 网络请求失败业务回调
 responseObject:服务器返回数据
 failure:业务失败回调
 */
+ (void)systemFailure:(nullable NSError *)error businessFailureBlock:(nullable FailureBlock)failure;



+ (void)testNetwork;

NS_ASSUME_NONNULL_END

@end
