//
//  VerificationCodeCountdownSingle.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#define Countdown_UserRegist @"Countdown_UserRegist"
#define Countdown_VerificationCodeLogin  @"Countdown_VerificationCodeLogin"
#define Countdown_ForgetPassWord @"Countdown_ForgetPassWord"
#define Countdown_Second  20 //一次验证码等待的时间

@interface VerificationCodeCountdownSingle : NSObject

@property (nonatomic,copy) void (^userRegistUpdateUI)(NSInteger countdown);
@property (nonatomic,copy) void (^verificationCodeLoginUpdateUI)(NSInteger countdown);
@property (nonatomic,copy) void (^forgetPassWordUpdateUI)(NSInteger countdown);
//获取单例
+ (instancetype)sharedCodeCountdownSingle;

//关闭定时器
- (void)closeTimer;

//开始计时
- (void)startCountdownWith:(NSString *)countdownKey;

/**
 * 保存验证码类型(如 忘记密码界面)的当前时间
 
 * countdownKey：验证码类型
 */
+(void)saveCountdownStartDateWithKey:(NSString *)countdownKey;
/**
 * 获取验证码类型(如 忘记密码界面)的当前剩余秒数 <60 直接显示 >= 60秒
 * countdownKey：验证码类型
 * second：一次验证码等待的时间 默认60
 */
+(NSInteger)getCurrentRemainingsecondSWithKey:(NSString *)countdownKey AndCountdown_Second:(NSInteger)second;

@end
