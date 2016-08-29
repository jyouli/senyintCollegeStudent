//
//  VerificationCodeCountdownSingle.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "VerificationCodeCountdownSingle.h"
static VerificationCodeCountdownSingle *_sharedCountdownSingle = nil;

@interface VerificationCodeCountdownSingle ()
{
    NSTimer *timer;
    CFRunLoopRef timerRunLoop;//定时器的RunLoop
    NSInteger countdown;
}

@end
@implementation VerificationCodeCountdownSingle
#pragma mark init
+ (instancetype)sharedCodeCountdownSingle
{
    if (!_sharedCountdownSingle) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedCountdownSingle = [[self alloc] init];
        });
    }
    return _sharedCountdownSingle;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedCountdownSingle) {
            _sharedCountdownSingle = [super allocWithZone:zone ];
            
        }
    });
    return _sharedCountdownSingle;
}
- (instancetype)init
{
    if ((_sharedCountdownSingle = [super init])) {
        
        
    }
    return _sharedCountdownSingle;
}
#pragma mark end

/**
 * 保存验证码类型(如 忘记密码界面)的当前时间
 
 * countdownKey：验证码类型
 */
+(void)saveCountdownStartDateWithKey:(NSString *)countdownKey
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:countdownKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(void)clearCountdownStartDateWithKey:(NSString *)countdownKey
{
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:countdownKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
/**
 * 获取验证码类型(如 忘记密码界面)的当前剩余秒数
 
 * countdownKey：验证码类型
 * second：一次验证码等待的时间 默认60
 */
+(NSInteger)getCurrentRemainingsecondSWithKey:(NSString *)countdownKey AndCountdown_Second:(NSInteger)second
{
    if (second == 0) {
        second = Countdown_Second;
    }
    NSInteger countdown; //需等待时间
    NSTimeInterval current =  [[NSDate date] timeIntervalSince1970];
    NSTimeInterval start;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:countdownKey]) {
       start = [[[NSUserDefaults standardUserDefaults] objectForKey:countdownKey] timeIntervalSince1970];
       countdown = current - start;
        if (countdown > Countdown_Second) { //如大于Countdown_Second 设为Countdown_Second重新开始
            countdown = second;
        }

    } else {
    
        countdown = second;
    }
    
    return countdown;
    
}


- (void)closeTimer
{
    if (timer.valid) {
        [timer invalidate];
        CFRunLoopStop(timerRunLoop);
        timer = nil;
    }
}

//只有一个当前显示的cell只能有一个   所以view每次出现的时候都需要刷新
- (void)startCountdownWith:(NSString *)countdownKey
{
    
    [self closeTimer];

    countdown = [VerificationCodeCountdownSingle getCurrentRemainingsecondSWithKey:countdownKey AndCountdown_Second:0];
    if (countdown > Countdown_Second) {
        [VerificationCodeCountdownSingle saveCountdownStartDateWithKey:countdownKey];

    }
    NSDictionary *dic = @{@"key":countdownKey,@"countdown": [NSNumber numberWithInteger:countdown]};
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountdown:) userInfo:dic repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    timerRunLoop = CFRunLoopGetCurrent();
    CFRunLoopRun();
    
}

- (void)updateCountdown:(NSTimer *)sender
{
    NSDictionary *dic = sender.userInfo;
    if ([Countdown_UserRegist isEqualToString:dic[@"key"]]) {
        if (self.userRegistUpdateUI) {
            self.userRegistUpdateUI(countdown);
        }
    }
    
    if ([Countdown_VerificationCodeLogin isEqualToString:dic[@"key"]]) {
        if (self.verificationCodeLoginUpdateUI) {
            self.verificationCodeLoginUpdateUI(countdown);
        }
    }

    
    if ([Countdown_ForgetPassWord isEqualToString:dic[@"key"]]) {
        if (self.forgetPassWordUpdateUI) {
            self.forgetPassWordUpdateUI(countdown);
        }
    }

    if (countdown == 0) {
        [VerificationCodeCountdownSingle clearCountdownStartDateWithKey:dic[@"key"]];
        [self closeTimer];
 
    } else {
        countdown --;

    }
    
}
@end
