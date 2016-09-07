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

/**
 * 各个服务器IP
 */

//洪铭开发环境
//#define HTTP_BASEURL                    @"http://172.16.208.85:8080"
//#define HTTP_BASE_HTTPS_URL             @"http://172.16.208.85:8080"
//#define HTTP_FILEUPLOADURL              @"http://172.16.208.85:8080"
//#define HTTP_FILEDOWNLOADURL            @"http://172.16.208.85:8080/app/file/down?type=0&url="
//#define WEB_BASE_URL                    @"http://172.16.208.85:8080"

//测试环境
//#define HTTP_BASEURL                    @"http://192.168.20.161"
//#define HTTP_BASE_HTTPS_URL             @"http://192.168.20.161"
//#define HTTP_FILEUPLOADURL              @"http://192.168.20.161"
//#define HTTP_FILEDOWNLOADURL            @"http://192.168.20.161/app/file/down?type=0&url="
//#define WEB_BASE_URL                    @"http://192.168.20.161"

////外网生产环境
#define HTTP_BASEURL                    @"http://testapi.cinyi.com"
//#define HTTP_BASE_HTTPS_URL             @"http://testapi.cinyi.com"
//#define HTTP_FILEUPLOADURL              @"http://testapi.cinyi.com"
//#define HTTP_FILEDOWNLOADURL            @"http://testapi.cinyi.com"
//#define WEB_BASE_URL                    @"http://testapi.cinyi.com"
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
+ (NSString *)baseUrl
{
    return HTTP_BASEURL;
}

+ (BOOL)isFirstRunApp
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //根据本地是否保存有标示来判断是否需要加载过桥页
    if (![userDefaults stringForKey:USERINFO_BUILDCODE]) {
        
        //获取deviceID并储存到本地
        [userDefaults setObject:[YLStringTool generateUUID] forKey:USERINFO_DEVICEID];
        
        //保存当前软件buildCode
        [userDefaults setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:USERINFO_BUILDCODE];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        return YES;
    }
   
    return NO;
}

+ (BOOL)isLocalBuildCodeNewest
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if (![[userDefaults stringForKey:USERINFO_BUILDCODE] isEqualToString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]]) {
        
        //保存当前软件buildCode
        [userDefaults setObject:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:USERINFO_BUILDCODE];
        [userDefaults synchronize];
        
        return NO;
    }
    return YES;
}

+ (BOOL)isNeedAutoLogin
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //根据本地是否保存有用户Token来判断是否需要自动登录
    if (![userDefaults objectForKey:USERINFO_TOKEN] || [[userDefaults objectForKey:USERINFO_TOKEN] isEqualToString:@""]) {
        
        return NO;
    }
    
    return YES;
}

#pragma mark
+ (void)setToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:USERINFO_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_TOKEN];
    
}

+ (void)setUid:(NSString *)uid
{
    [[NSUserDefaults standardUserDefaults] setObject:uid forKey:USERINFO_UID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (void)setMobile:(NSString *)mobile
{
    [[NSUserDefaults standardUserDefaults] setObject:mobile forKey:USERINFO_PHONENUM];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)userMobile
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_PHONENUM];
    
}

+ (void)setPassword:(NSString *)password
{
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:USERINFO_PASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSString *)userPassword
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:USERINFO_PASSWORD];
    
}

#pragma mark
+ (NSDictionary *)userBaseInfo;
{
    if (!_userBaseInfo) {
        _userBaseInfo = [[NSMutableDictionary alloc] init];
        /*
         
         字段	描述	必填	备注
         token	唯一标识	N
         uid	User ID	N
         deviceId	设备唯一标志	Y
         appId	内部应用ID	Y
         appBuildCode	软件版本	Y
         deviceInfo	品牌－软硬件信息	Y
         client  int	0-学员端，1-专家端
         */
        
    }
    //测试键值是值传递 在其他地方修改了token偏好设置 字典token的值还是之前的 所以字典必须每次重新设值
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:USERINFO_TOKEN]){//token
        [_userBaseInfo setValue:[userDefaults objectForKey:USERINFO_TOKEN] forKey:USERINFO_TOKEN ];
    }else{
        [_userBaseInfo setValue:@"" forKey:USERINFO_TOKEN ];
    }
    if ([userDefaults objectForKey:USERINFO_UID]){//uid
        [_userBaseInfo setValue:[userDefaults objectForKey:USERINFO_UID] forKey:USERINFO_UID ];
    }else{
        [_userBaseInfo setValue:@"" forKey:USERINFO_UID ];
    }
    if ([userDefaults objectForKey:USERINFO_DEVICEID]){//deviceId
        [_userBaseInfo setValue:[userDefaults objectForKey:USERINFO_DEVICEID] forKey:K_REQUESTPUBLICPARAMETER_DEVICEID];
    }else{
        NSString *deviceID = [YLStringTool generateUUID];
        [userDefaults setValue:deviceID forKey:USERINFO_DEVICEID];
        [_userBaseInfo setValue:deviceID forKey:K_REQUESTPUBLICPARAMETER_DEVICEID ];
    }
    
    [_userBaseInfo setValue:K_REQUESTPUBLICPARAMETER_APPID_VALUE forKey:K_REQUESTPUBLICPARAMETER_APPID ];//appId
    [_userBaseInfo setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:K_REQUESTPUBLICPARAMETER_APPBUILDCODE];//appBuildCode
    [_userBaseInfo setValue:[self getDeviceInfo] forKey:K_REQUESTPUBLICPARAMETER_DEVICEINFO];//deviceInfo
    [_userBaseInfo setValue:@0 forKey:K_REQUESTPUBLICPARAMETER_CLIENT];//client 区分专家端和学员端
    
    //appVersion
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (app_Version.length>0) {
        [_userBaseInfo setValue:app_Version forKey:USERINFO_APPVERSION];
    }
    
    //idfa广告标示符 暂时不使用
    
    //    NSString *adId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //    if (adId.length>0) {
    //        [publicDic setValue:adId forKey:USERINFO_IDFA];
    //    }
    
    return _userBaseInfo;
}

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
