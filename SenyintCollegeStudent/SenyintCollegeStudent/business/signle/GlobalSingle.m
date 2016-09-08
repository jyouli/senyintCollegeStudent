//
//  Globalsingle.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "GlobalSingle.h"
#import"sys/utsname.h"


static GlobalSingle *_sharedGlobalSingle = nil;
static NSMutableDictionary *_userBaseInfo = nil;

@interface GlobalSingle ()
@property (nonatomic, strong)NSMutableDictionary *userBaseInfo;

@end
@implementation GlobalSingle

+ (instancetype)sharedGlobalSingle
{
    if (!_sharedGlobalSingle) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedGlobalSingle = [[self alloc] init];
        });
    }
    return _sharedGlobalSingle;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedGlobalSingle) {
            _sharedGlobalSingle = [super allocWithZone:zone ];
            
        }
    });
    return _sharedGlobalSingle;
}
- (instancetype)init
{
    if ((_sharedGlobalSingle = [super init])) {
        
        
    }
    return _sharedGlobalSingle;
}
#pragma mark

#pragma mark ===========================================
+ (BOOL)isFirstRunApp
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //根据本地是否保存有标示来判断是否需要加载过桥页
    if (![userDefaults stringForKey:USERINFO_App_Build_Code]) {
        
        //获取deviceID并储存到本地
        [userDefaults setObject:[YLStringTool generateUUID] forKey:USERINFO_Device_Id];
        
        //保存当前软件buildCode
        [userDefaults setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:USERINFO_App_Build_Code];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
   
    return NO;
}

+ (BOOL)isLocalBuildCodeNewest
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![[userDefaults stringForKey:USERINFO_App_Build_Code] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]) {
        
        //保存当前软件buildCode
        [userDefaults setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:USERINFO_App_Build_Code];
        [userDefaults synchronize];
        
        return NO;
    }
    return YES;
}

+ (BOOL)isNeedAutoLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //根据本地是否保存有用户Token来判断是否需要自动登录
    if (![userDefaults objectForKey:USERINFO_Token] || [[userDefaults objectForKey:USERINFO_Token] isEqualToString:@""]) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark
+ (void)setToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USERINFO_Token];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_Token];
    
}

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:USERINFO_Uid];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)uid
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_Uid];
    
}


+ (void)setUserPhoneNumber:(NSString *)phone;
{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:USERINFO_PhoneNumber];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
+ (NSString *)userPhoneNumber
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_PhoneNumber];
    
}

+ (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:USERINFO_Password];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)userPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_Password];
    
}

+ (void)setAPNToken:(NSString *)apnToken
{
    [[NSUserDefaults standardUserDefaults] setObject:apnToken forKey:USERINFO_APN_Token];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


+ (NSString *)apnToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_APN_Token];
    
}


#pragma mark

+ (NSString *)getDeviceInfo
{
    UIDevice *device =[[UIDevice alloc] init];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //手机所有者名字 & 手机型号 & 手机系统版本
    NSString *deviceInfo = [NSString stringWithFormat:@"%@&%@&%@",device.name,deviceString,device.systemVersion];
    
    return deviceInfo;
    
}


@end
