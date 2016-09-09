
//
//  NetworkManager.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/30.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "NetworkManager.h"
#import"sys/utsname.h"
#import "YLStringTool.h"
@interface NSURLSession (dealloc)


@end

@implementation NSURLSession (dealloc)

- (void)dealloc
{
    NSLog(@"%@-------->dealloc",self);
}
@end

@interface NSURLSessionTask (dealloc)


@end
@implementation NSURLSessionTask (dealloc)
- (void)dealloc
{
    NSLog(@"%@-------->dealloc",self);
}
@end

@interface AFHTTPSessionManager (dealloc)


@end
@implementation AFHTTPSessionManager (dealloc)
- (void)dealloc
{
    NSLog(@"%@-------->dealloc",self);
}
@end



static NetworkManager *_sharedNetworkManager = nil;

@implementation NetworkManager
@synthesize dataTaskArray = _dataTaskArray;

////参数值随时可变
//#define USERINFO_Uid             @"uid"             // 登录之后服务器返回
//#define USERINFO_Token           @"token"           // 登录之后服务器返回
//#define USERINFO_App_Build_Code  @"app_build_code"  //创建编号 如110
//#define USERINFO_App_version     @"app_version"      //版本号 如1.2.1
//
//
////参数名宏定义 参数值不可变
//#define USERINFO_Device_Id       @"device_id"       //设备唯一标识
//#define K_REQUESTPUBLICPARAMETER_APPID_Value @"app_id" // 内部应用ID来源 1:IOS 2:Android
//#define K_REQUESTPUBLICPARAMETER_Client @"client"      // 客户端参数	0学员端  1专家端区
//


//#define USERINFO_ROLE        @"role"            //num x
//#define USERINFO_USERNAME    @"userName"
//#define USERINFO_REALNAME    @"realName"        //x
//#define USERINFO_PHONENUM    @"phoneNum"
//#define USERINFO_PASSWORD    @"password"
//#define USERINFO_APNTOKEN    @"apn_token"
//
//#define USERINFO_HEADIMAGEURL    @"headImageUrl"    //用户头像地址，
//#define USERINFO_BUILDCODE       @"buildCode"       //版本号  用于校验是否现实过桥页和是否创建deviceId
//#define USERINFO_APPVERSION      @"appVersion"       //版本号 如1.2.1
//#define USERINFO_IDFA            @"idfa"            //广告标示符
//
//
//#define K_REQUESTPUBLICPARAMETER_DEVICEID @"device_id"
//#define K_REQUESTPUBLICPARAMETER_APPBUILDCODE @"appBuildCode"
//#define K_REQUESTPUBLICPARAMETER_DEVICEINFO @"deviceInfo"


//网络请求失败（系统级）提示语
#define SystemError_prompt @"网络不给力"


#pragma mark BaseUrl
+ (NSString *)baseURLString
{
    return [NetworkManager developmentBaseURLString];
}

//调试url
+ (NSString *)developmentBaseURLString
{
    return @"http://192.168.20.162/";
}

//发布url
+ (NSString *)releaseBaseURLString
{
    return @"http://testapi.cinyi.com";
}
#pragma end

#pragma mark 基础参数
+ (NSMutableDictionary *)userBaseInfo;
{
    /*
     字段	            描述      	必填	      备注
     token          	唯一标识     	N	      登录后必填
     uid	            User ID	    N
     device_id         	设备唯一标志  Y
     app_id             内部应用ID   Y       1: iOS 2: android
     app_build_code     创建编号     Y       如 110
     app_version        软件版本     Y       如 1.2.1
     client             客户端参数   Y        0:学员端，1:专家端
     */
    
    //测试键值是值传递 在其他地方修改了token偏好设置 字典token的值还是之前的 所以字典必须每次重新设值
    NSMutableDictionary *_userBaseInfo = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:USERINFO_Token]){//token
        [_userBaseInfo setValue:[userDefaults objectForKey:USERINFO_Token] forKey:USERINFO_Token ];
    }else{
        [_userBaseInfo setValue:@"" forKey:USERINFO_Token ];
    }
    if ([userDefaults objectForKey:USERINFO_Uid]){//uid
        [_userBaseInfo setValue:[userDefaults objectForKey:USERINFO_Uid] forKey:USERINFO_Uid ];
    }else{
        [_userBaseInfo setValue:@"" forKey:USERINFO_Uid ];
    }
    if ([userDefaults objectForKey:USERINFO_Device_Id]){//deviceId
        [_userBaseInfo setValue:[userDefaults objectForKey:USERINFO_Device_Id] forKey:USERINFO_Device_Id];
    }else{
        NSString *deviceID = @"";
        [userDefaults setValue:deviceID forKey:USERINFO_Device_Id];
        [_userBaseInfo setValue:deviceID forKey:USERINFO_Device_Id ];
    }
    
    [_userBaseInfo setValue:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] forKey:USERINFO_App_Build_Code];//appBuildCode
    
    //appVersion
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (app_Version.length>0) {
        [_userBaseInfo setValue:app_Version forKey:USERINFO_App_version];
    }
    
    [_userBaseInfo setValue:@"1" forKey:K_REQUESTPUBLICPARAMETER_APPID_Value ];

    [_userBaseInfo setValue:@"0" forKey:K_REQUESTPUBLICPARAMETER_Client];//client 区分专家端和学员端

    
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

+ (NSString *)getURLString:(NSString *)str
{
    NSString *urlStr = @"";
    if ([str isEqual:[NSNull null]] || str == NULL || str.length == 0) {
        
        return urlStr;
    }
    
    if ([str hasPrefix:[self baseURLString]]) {
        urlStr = str;
        
    } else {
        
        if ([str hasPrefix:@"http:"] || [str hasPrefix:@"https:"]) {
            urlStr = str;
            
        } else {
            
            urlStr = [[self baseURLString] stringByAppendingString:str];
        }
    }
    NSLog(@"%@",urlStr);
#warning 编码有题
//    urlStr = [YLStringTool URLEncodedString:urlStr];
//    NSLog(@"%@",urlStr);
    //编码
    return urlStr;
}
#pragma end

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
    failure:(nullable FailureBlock)failure
{
    [self GET:URLString parameters:parameters progress:nil success:success failure:failure];
}


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
    failure:(nullable FailureBlock)failure
{

    Networktools *tools = [[Networktools alloc] init];
    [tools GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];

}


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
     failure:(nullable FailureBlock)failure
{
    [self POST:URLString parameters:parameters progress:nil success:success failure:failure];
}

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
     failure:(nullable FailureBlock)failure
{
    Networktools *tools = [[Networktools alloc] init];
    [tools POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];

}
#pragma mark end


#pragma mark  网络请求回调业务处理
/*
 网络请求成功业务回调
 responseObject:服务器返回数据
 success:业务成功回调
 failure:业务失败回调
 */
+ (void)systemSuccess:(id)responseObject businessSuccessBlock:(SuccessBlock)success businessSuccessBlock:(FailureBlock)failure
{
    NSInteger status = [[[responseObject objectForKey:@"header"] objectForKey:@"status"] integerValue];
    if (status == 1) { //业务通过 返回内容
        if (success) {
            success([responseObject objectForKey:@"content"]);
        }
        
    } else {
        if (failure) {
            failure([[responseObject objectForKey:@"header"] objectForKey:@"message"],nil);
        }
        
        //业务出错  把message返回  自己做进一步处理
        [self businessFailure:[responseObject objectForKey:@"header"]];
        
    }
}

/*
 网络请求失败业务回调
 responseObject:服务器返回数据
 failure:业务失败回调
 */
+ (void)systemFailure:(NSError *)error businessFailureBlock:(FailureBlock)failure
{
    //网络不给力
    if (failure) {
        failure(SystemError_prompt, error);
    }
}
/*
 业务出错处理
 对传过来的url进行处理
 */
+ (void)businessFailure:(id)statusObject
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"业务失败" message:[NSString stringWithFormat:@"%@:%@",statusObject[@"status"],statusObject[@"message"]] delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [alert show];
    
}


#warning 测试数据
+ (void)testNetwork
{
     
}



//#pragma mark  dataTaskArray
//- (NSMutableArray<NSURLSessionDataTask *> *)dataTaskArray
//{
//    if (!_dataTaskArray) {
//        _dataTaskArray = [[NSMutableArray alloc] init];
//    }
//
//    return _dataTaskArray;
//}
//
//- (void)addDataTask:(NSURLSessionDataTask *)task
//{
//    if ((task.state == NSURLSessionTaskStateRunning || task.state == NSURLSessionTaskStateSuspended)&& task.state != NSURLSessionTaskStateCompleted && ![self.dataTaskArray containsObject:task] ) {
//        [self.dataTaskArray addObject:task];
//    }
//}
//
//- (void)dataTaskCompleted:(NSURLSessionDataTask *)task
//{
//    if (task.state == NSURLSessionTaskStateCompleted && [self.dataTaskArray containsObject:task]) {
//        [self.dataTaskArray removeObject:task];
//    }
//}
//
//- (void)cancleDataTask:(NSURLSessionDataTask *)task
//{
//    NSLog(@"%@",task);
//}
//- (void)cancleAllDataTask
//{
//    NSLog(@"%@",self.dataTaskArray);
//
//}


#pragma mark initialize
+ (instancetype)sharedGlobalSingle
{
    if (!_sharedNetworkManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedNetworkManager = [[self alloc] init];
        });
    }
    return _sharedNetworkManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedNetworkManager) {
            _sharedNetworkManager = [super allocWithZone:zone ];
            
        }
    });
    return _sharedNetworkManager;
}
- (instancetype)init
{
    
    if ((_sharedNetworkManager = [super init])) {
        
        
    }
    return _sharedNetworkManager;
}

- (id)copy
{
    return _dataTaskArray;
}

#pragma mark
@end
