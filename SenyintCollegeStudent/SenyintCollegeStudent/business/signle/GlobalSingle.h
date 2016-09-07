//
//  Globalsingle.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "YLStringTool.h"

@interface GlobalSingle : NSObject
+(instancetype)sharedGlobalSingle;


+ (NSString *)baseUrl;

+ (BOOL)isFirstRunApp;
+ (BOOL)isLocalBuildCodeNewest;
+ (BOOL)isNeedAutoLogin;
//用户基本信息 请求的基本参数
+ (NSDictionary *)userBaseInfo;
//登录成功后服务器返回信息
+ (void)setToken:(NSString *)token;
+ (NSString *)token;
+ (void)setUid:(NSString *)uid;
+ (void)setMobile:(NSString *)mobile;
+ (NSString *)userMobile;
+ (void)setPassword:(NSString *)password;
+ (NSString *)userPassword;

@end
