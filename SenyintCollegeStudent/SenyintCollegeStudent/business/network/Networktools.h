//
//  Networktools.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/1.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
/**
 Networktools 因为取消机制
 本工具类设定只绑定一个任务
 */

/**
 业务成功回调
 返回正文内容
 */
typedef void (^SuccessBlock)(id _Nullable responseObject);
/**
 业务出错或者系统级报错回调
 业务出错的时候返回服务器返回的message
 系统级报错的时候返回系统的Error
 */
typedef void (^FailureBlock)(NSString  * _Nullable message, NSError * _Nullable error);

@interface Networktools : NSObject

NS_ASSUME_NONNULL_BEGIN
/**
 get请求
 URLString:urlstr可以是全部 也可以是不加base
 parameters: 入参
 success: 业务成功回调    回调在主线程
 failure: 业务或报错回调  回调在主线程
 */
- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
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
- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
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
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
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
- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable SuccessBlock)success
                                failure:(nullable FailureBlock)failure;

NS_ASSUME_NONNULL_END


@end
