//
//  SCProgressHUD.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCProgressHUD.h"
#import "SVProgressHUD.h"
@implementation SCProgressHUD

#define ProgressHUDDurationTime 2
//static SCProgressHUD *_sharedProgressHUD = nil;
//+ (instancetype)sharedGlobalSingle
//{
//    if (!_sharedProgressHUD) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            _sharedProgressHUD = [[self alloc] init];
//        });
//    }
//    return _sharedProgressHUD;
//}
//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (!_sharedProgressHUD) {
//            _sharedProgressHUD = [super allocWithZone:zone ];
//            
//        }
//    });
//    return _sharedProgressHUD;
//}

+ (void)initialize
{
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    /*
     SVProgressHUDMaskType 设置展示提示view时 其化界面的交互
     测试此处的设置是从未设置maskType的情况下调SVProgressHUD展示的默认设置；
     如果期间在其他地方设置了maskType，则以设置的maskType为准，且下一次调用的默认设置是上一次的设置
     */
    [self setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
}

#pragma mark 默认设置
/**
 * 设置提示图片（默认i）
 */
+ (void)setInfoImage:(UIImage*)image
{
    [SVProgressHUD setInfoImage:image];
}

/**
 * 设置成功图片（默认√）
 */
+ (void)setSuccessImage:(UIImage*)image
{
    [SVProgressHUD setSuccessImage:image];
}


/**
 * 设置失败图片（默认X）
 */
+ (void)setErrorImage:(UIImage*)image
{
    [SVProgressHUD setErrorImage:image];
}


/**
 * 设置ProgressHUD显示时的用户交互机制
 */
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD setDefaultMaskType:maskType];
}


#pragma mark ==========卸载弹框
+ (void)dismiss
{
    [SVProgressHUD dismiss];
}

#pragma mark  加载内容的时候展示（转圈效果） 加载完成之后手动调dismiss方法消失
+ (void)show
{
    [SVProgressHUD show];
}
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType
{
  [SVProgressHUD showWithMaskType:maskType];
  
}
+ (void)showWithStatus:(NSString*)status
{
    [SVProgressHUD showWithStatus:status];
}
/**
 * 正在加载时展示
 * status:加载时展示的提示语
 * maskType:加载时是否允许用户交互（如不设会按上一次的设置）
 */
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType
{

    [SVProgressHUD showWithStatus:status maskType:maskType];
}


#pragma mark  用来展示进度（圈填充比例） 需手动调dismiss方法消失
+ (void)showProgress:(float)progress
{
    [SVProgressHUD showProgress:progress];
}
+ (void)showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showProgress:progress maskType:maskType];
}
+ (void)showProgress:(float)progress status:(NSString*)status
{
    [SVProgressHUD showProgress:progress status:status];
}
/**
 * 展示进度
 * progress:进度值（0~1）
 * status:加载时展示的提示语
 * maskType:加载时是否允许用户交互（如不设会按上一次的设置）
 */
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showProgress:progress status:status maskType:maskType];
}


#pragma mark  如果ProgressHUD正在展示，仅修改ProgressHUD的展示文字,如果ProgressHUD没有在显示中，刚不做任何操作
+ (void)setStatus:(NSString*)string
{
    [SVProgressHUD setStatus:string];
}

#pragma mark 展示提示信息 一定时间后会自动消失（停留时间和提示文字长度有关系）
+ (void)showInfoWithStatus:(NSString *)string
{
    [SVProgressHUD showInfoWithStatus:string];
}
+ (void)showInfoWithStatus:(NSString *)string duration:(NSTimeInterval)duration
{
    [SVProgressHUD showInfoWithStatus:string duration:duration];
}
+ (void)showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showInfoWithStatus:string maskType:maskType];
}
/**
 * 展示提示语（默认图片为i）
 * string:展示的提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */
+ (void)showInfoWithStatus:(NSString *)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showInfoWithStatus:string duration:duration maskType:maskType];
}

#pragma mark 成功提示信息 一定时间后会自动消失（停留时间和提示文字长度有关系）
+ (void)showSuccessWithStatus:(NSString*)string
{
    [SVProgressHUD showSuccessWithStatus:string];
}
+ (void)showSuccessWithStatus:(NSString*)string duration:(NSTimeInterval)duration
{
    [SVProgressHUD showSuccessWithStatus:string duration:duration];
}
+ (void)showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showSuccessWithStatus:string  maskType:maskType];

}
/**
 * 成功提示语 （默认图片为√）
 * string:成功提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */

+ (void)showSuccessWithStatus:(NSString*)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showSuccessWithStatus:string duration:duration maskType:maskType];
}


#pragma mark 成功提示信息 一定时间后会自动消失（停留时间和提示文字长度有关系）
+ (void)showErrorWithStatus:(NSString *)string
{
    [SVProgressHUD showErrorWithStatus:string];
}
+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration
{
    [SVProgressHUD showErrorWithStatus:string duration:duration];
}
+ (void)showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showErrorWithStatus:string maskType:maskType];
}
/**
 * 失败提示语 （默认图片为X）
 * string:成功提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */

+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType
{
    [SVProgressHUD showErrorWithStatus:string duration:duration maskType:maskType];
}


#pragma mark 自定义图片提示信息 会自动消息
+ (void)showImage:(UIImage *)image status:(NSString *)string {
    [SVProgressHUD showImage:image status:string];
}

+ (void)showImage:(UIImage *)image status:(NSString *)string maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showImage:image status:string maskType:maskType];
}

/**
 * 自定义图片提示信息 （use 28x28 white pngs）
 * image:自定义图片
 * string:提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */
+ (void)showImage:(UIImage *)image status:(NSString *)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType {
    [SVProgressHUD showImage:image status:string duration:duration maskType:maskType];
}



@end
