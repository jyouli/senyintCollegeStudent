//
//  SCProgressHUD.h
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"


@interface SCProgressHUD : NSObject

#pragma mark 默认设置
/**
 * 设置提示图片（默认i）
 */
+ (void)setInfoImage:(UIImage*)image;

/**
 * 设置成功图片（默认√）
 */
+ (void)setSuccessImage:(UIImage*)image;

/**
 * 设置失败图片（默认X）
 */
+ (void)setErrorImage:(UIImage*)image;

/**
 * 设置ProgressHUD显示时的用户交互机制
 */
+ (void)setDefaultMaskType:(SVProgressHUDMaskType)maskType;


#pragma mark ==========卸载弹框
+ (void)dismiss;

#pragma mark  加载内容的时候展示（转圈效果） 加载完成之后手动调dismiss方法消失
+ (void)show;
+ (void)showWithMaskType:(SVProgressHUDMaskType)maskType;
+ (void)showWithStatus:(NSString*)status;
/**
 * 正在加载时展示
 * status:加载时展示的提示语
 * maskType:加载时是否允许用户交互（如不设会按上一次的设置）
 */
+ (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

#pragma mark  用来展示进度（圈填充比例） 需手动调dismiss方法消失
+ (void)showProgress:(float)progress;
+ (void)showProgress:(float)progress maskType:(SVProgressHUDMaskType)maskType;
+ (void)showProgress:(float)progress status:(NSString*)status;
/**
 * 展示进度
 * progress:进度值（0~1）
 * status:加载时展示的提示语
 * maskType:加载时是否允许用户交互（如不设会按上一次的设置）
 */
+ (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

#pragma mark  如果ProgressHUD正在展示，仅修改ProgressHUD的展示文字,如果ProgressHUD没有在显示中，刚不做任何操作
+ (void)setStatus:(NSString*)string;

#pragma mark 展示提示信息 一定时间后会自动消失（停留时间和提示文字长度有关系）
+ (void)showInfoWithStatus:(NSString *)string;
+ (void)showInfoWithStatus:(NSString *)string duration:(NSTimeInterval)duration;
+ (void)showInfoWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;
/**
 * 展示提示语（默认图片为i）
 * string:展示的提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */
+ (void)showInfoWithStatus:(NSString *)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType;

#pragma mark 成功提示信息 一定时间后会自动消失（停留时间和提示文字长度有关系）
+ (void)showSuccessWithStatus:(NSString*)string;
+ (void)showSuccessWithStatus:(NSString*)string duration:(NSTimeInterval)duration;
+ (void)showSuccessWithStatus:(NSString*)string maskType:(SVProgressHUDMaskType)maskType;
/**
 * 成功提示语 （默认图片为√）
 * string:成功提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */
+ (void)showSuccessWithStatus:(NSString*)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType;

#pragma mark 成功提示信息 一定时间后会自动消失（停留时间和提示文字长度有关系）
+ (void)showErrorWithStatus:(NSString *)string;+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration;
+ (void)showErrorWithStatus:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;
/**
 * 失败提示语 （默认图片为X）
 * string:成功提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */
+ (void)showErrorWithStatus:(NSString *)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType;

#pragma mark 自定义图片提示信息 会自动消息
+ (void)showImage:(UIImage *)image status:(NSString *)string;

+ (void)showImage:(UIImage *)image status:(NSString *)string maskType:(SVProgressHUDMaskType)maskType;

/**
 * 自定义图片提示信息 （use 28x28 white pngs）
 * image:自定义图片
 * string:提示语
 * duration:提示停留时间（如不设会按string长度计算）
 * maskType:提示框展示时用户交互机制（如不设会按上一次的设置）
 */
+ (void)showImage:(UIImage *)image status:(NSString *)string duration:(NSTimeInterval)duration maskType:(SVProgressHUDMaskType)maskType;
@end
