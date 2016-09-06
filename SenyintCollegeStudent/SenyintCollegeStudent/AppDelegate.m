//
//  AppDelegate.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/1.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "AppDelegate.h"
#import "AppSetting.h"
#import "LoginViewController.h"
#import "TeskViewController.h"
#import "EnterViewController.h"

#import "UIImage+Rend.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [_window makeKeyAndVisible];
    
    Class vcClass;
    if ([GlobalSingle isFirstRunApp]) {
        
        vcClass = NSClassFromString(@"LoginViewController");
        
    } else {
        
        vcClass = NSClassFromString(@"TransitionViewController");

    }
//    [self setRootViewcontroller:vcClass];
    

    EnterViewController *tc = [[EnterViewController alloc] init];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tc];
    self.window.rootViewController = nc;

    //全局ui设置
    [self customizeAppearance];
    
    return YES;
}

//1. instancesRespondToSelector只能写在类名后面，respondsToSelector可以写在类名和实例名后面。
//
//2. [类 instancesRespondToSelector]判断的是该类的实例是否包含某方法，等效于：[该类的实例 respondsToSelector]。
//
//3. [类 respondsToSelector]用于判断是否包含某个类方法。
- (void)setRootViewcontroller:(Class) vcClass
{

    if ([vcClass respondsToSelector:@selector(setWindowRootViewController)]) {
        [vcClass setWindowRootViewController];
        
    }
    
}


#pragma mark --自定义全皮肤设置
- (void)customizeAppearance
{
    
    //设置导航条背景
    //[[UINavigationBar appearance] setBackgroundColor:[UIColor whiteColor]];//通过颜色设置的背景色去不掉下边的线（阴影）
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"green_nav_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTranslucent:NO];

    //设置阴影颜色
    [[UINavigationBar appearance] setShadowImage:[UIImage createImageWithColor:Shadow_Color]];
//
//    //隐藏阴影
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    //自已给UINavigationBar添加阴影
//    [UINavigationBar appearance].layer.shadowColor = [Shadow_Color CGColor];
//    [UINavigationBar appearance].layer.shadowOffset = CGSizeMake(0, 1);
//    [UINavigationBar appearance].layer.shadowRadius = 2;
//    [UINavigationBar appearance].layer.shadowOpacity = .9;
//    
    
    // 设置title
    [[UINavigationBar appearanceWhenContainedIn:[UINavigationController class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:NavBarSonControl_Font_Color,NSForegroundColorAttributeName,NavBarTitle_Font_Size,NSFontAttributeName ,nil]];
    
     //设置按钮
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationController class], nil] setBackgroundImage:[UIImage imageNamed:@"navBarItem_clearbg"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault ];
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationController class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:NavBarSonControl_Font_Color,NSForegroundColorAttributeName,NavBarSonControl_Font_Size,NSFontAttributeName ,nil] forState:UIControlStateNormal];
    
//    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"nav_back"] ];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"nav_back"] ];//不起作用

    
    [[UITabBarItem appearanceWhenContainedIn:[UINavigationController class], nil] setTitlePositionAdjustment:UIOffsetMake(80, 30)];
    [[UITabBarItem appearanceWhenContainedIn:[UINavigationController class], nil] setImageInsets:UIEdgeInsetsMake(0, -50, 0, 50)];

    
}

//
//#pragma mark 远程通知
//- (void)registRemoteNotification:(UIApplication *)application
//{
//    //注册推送
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0 ) {
//        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil]];
//        [application registerForRemoteNotifications];
//        
//    } else {
//        
//        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
//    }
//
//
//}
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//
//    NSString *tokenStr = [[deviceToken description]
//                          stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]]; //测试只能去掉字符串两端的"<>"
//    tokenStr = [tokenStr stringByReplacingOccurrencesOfString:@" " withString:@""];//去掉中间空格
////    NSLog(@"获取DeviceToken成功:%@",tokenStr);
//
////    NSString *tokenStr = [[[[deviceToken description]
//                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
//                            stringByReplacingOccurrencesOfString:@">" withString:@""]
//                           stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
////    NSLog(@"获取DeviceToken成功:%@",pushToken);
//    
//}
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    NSLog(@"获得deviceToken失败:%@",[error description]);
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo
//{
//    NSString *message = [[userInfo objectForKey:@"aps"] objectForKey:@"alert"]; //自己展示
//    NSString *sound = [[userInfo objectForKey:@"aps"] objectForKey:@"sound"];   //系统自动播放
//    NSString *badge = [[userInfo objectForKey:@"aps"] objectForKey:@"badge"];   //自己展示
//    NSLog(@"收到推送消息: \n message = %@\n sound=%@\n badge=%@", message, sound, badge);
//    NSLog(@"%ld",application.applicationIconBadgeNumber);
//}

#pragma mark - 设置所有界面（包括启动图  不包括LaunchScreen）只竖屏显示 以下两种方法都可实现
//用此方法设置支持方向 界面仍然可以旋转
#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

////用此方法设置支持方向 界面不可以旋转 如设置了shouldAutorotate为YES会崩
//- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//
//    
//    return UIInterfaceOrientationMaskPortrait;
//}

@end



