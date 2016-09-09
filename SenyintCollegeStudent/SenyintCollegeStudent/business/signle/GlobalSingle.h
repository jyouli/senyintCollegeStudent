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


+ (BOOL)isFirstRunApp;
+ (BOOL)isLocalBuildCodeNewest;
+ (BOOL)isNeedAutoLogin;

+ (void)setUserPhoneNumber:(NSString *)phone;
+ (NSString *)userPhoneNumber;
+ (void)setPassword:(NSString *)password;
+ (NSString *)userPassword;
+ (void)setAPNToken:(NSString *)apnToken;
+ (NSString *)apnToken;


//登录成功后服务器返回信息存取,登录成功后公共请求头必传
+ (void)setToken:(NSString *)token;
+ (NSString *)token;
+ (void)setUid:(NSString *)uid;
+ (NSString *)uid;

@end
