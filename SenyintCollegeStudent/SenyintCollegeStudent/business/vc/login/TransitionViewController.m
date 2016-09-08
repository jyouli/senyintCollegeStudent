//
//  TransitionViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "TransitionViewController.h"
@interface TransitionViewController ()

@end

@implementation TransitionViewController
+ (void)setWindowRootViewController
{
    TransitionViewController *vc = [[TransitionViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"login_bg"]];

    if ([GlobalSingle isNeedAutoLogin]) {
        
        [self autoLoginRequest];
    } else {
        
        [self performSelectorInBackground:@selector(checkVersionRequest) withObject:nil];
    }


}


/**
 * 校验版本接口
 注意该接口的错误处理，即使出错，也要进行相应登录或登录之后的界面切换 -1强制更新 0非强制更新版本 1正常 nil服务器未给东西，走登录
 */
//AFN的回调默认都在主线程
- (void)checkVersionRequest
{
    NSLog(@"%@",[NSThread currentThread]);

    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary] ;
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:[@"" stringByAppendingString:@"/v1/app/version"] parameters:paraDic progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"totalUnitCount:%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",[NSThread currentThread]);
        NSLog(@"success:%@", responseObject);
        NSLog(@"%@",[[responseObject objectForKey:@"header"] objectForKey:@"message"]);
        [NSClassFromString(@"LoginViewController")  setWindowRootViewController];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
}
/**
 * 自动登录
 注意自动登录的错误处理：根视图控制器切换到登陆界面，调用登出接口
 */
- (void)autoLoginRequest
{
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary] ;
    NSString * apnToken = [GlobalSingle apnToken];
    if (apnToken == nil || [apnToken isEqualToString:@""]) {
        [paraDic setValue:@"" forKey:USERINFO_APN_Token];
    }else{
        [paraDic setValue:apnToken forKey:USERINFO_APN_Token];
    }
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET: [@"" stringByAppendingString:@"/v1/users/login_auto"] parameters:paraDic progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success:%@", responseObject);
//        [NSClassFromString(@"HomeViewController")  setWindowRootViewController];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
