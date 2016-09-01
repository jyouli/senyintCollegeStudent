//
//  Networktools.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/1.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "Networktools.h"
#import "NetworkManager.h"

@interface Networktools ()


@property (nonatomic, strong) AFHTTPSessionManager *afnmanger;

@end

@implementation Networktools
- (void)dealloc
{
    NSLog(@"%@--dealloc",self);
}

- (AFHTTPSessionManager *)afnmanger
{
    
    if (!_afnmanger) {
        _afnmanger = [AFHTTPSessionManager manager];
        
        //AFN默认是AFJSONResponseSerializer acceptableContentTypes为@"application/json", @"text/json", @"text/javascript"
        NSMutableSet *acceptableTypesSet = [[NSMutableSet alloc] initWithSet:_afnmanger.responseSerializer.acceptableContentTypes];
        [acceptableTypesSet addObject:@"text/html"];
        _afnmanger.responseSerializer.acceptableContentTypes = acceptableTypesSet;
        
        
        
    }
    
    return _afnmanger;
}

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
                               failure:(nullable FailureBlock)failure
{
    return [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
    
}


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
                               failure:(nullable FailureBlock)failure
{
    
    
    
    NSURLSessionDataTask *task = [self.afnmanger GET:[NetworkManager getURLString:URLString] parameters:parameters progress:^(NSProgress * _Nonnull progress) {
        
        if (downloadProgress) {
            downloadProgress(progress);
            
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [NetworkManager systemSuccess:responseObject businessSuccessBlock:success businessSuccessBlock:failure];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //        NSLog(@"AFNfailure----%@",error);
        [NetworkManager systemFailure:error businessFailureBlock:failure];
        
        
        
    }];
    
    [self.afnmanger.session finishTasksAndInvalidate];
    self.afnmanger = nil;
    //因为self.afnmanger的session会对afnmanger强引用，所以这里直接设nil没有关系。但是urlstring出错的时候  其实self.afnmanger也可以直接用weak修饰
    return task;
    
    
}




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
                                failure:(nullable FailureBlock)failure
{
    return [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

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
{
    
    NSURLSessionDataTask *task = [self.afnmanger POST:[NetworkManager getURLString:URLString] parameters:parameters progress:^(NSProgress * _Nonnull progress) {
        
        if (uploadProgress) {
            uploadProgress(progress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [NetworkManager systemSuccess:responseObject businessSuccessBlock:success businessSuccessBlock:failure];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [NetworkManager systemFailure:error businessFailureBlock:failure];
        
    }];
    
    [self.afnmanger.session finishTasksAndInvalidate];
    self.afnmanger = nil;
    
    return task;
    
    
}

@end
