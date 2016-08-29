//
//  YLRegularCheck.h
//  ToolClassDemo
//
//  Created by    任亚丽 on 16/8/16.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLRegularCheck : NSObject

#pragma mark 号码较验
/**
 *  手机号码校验
 *
 */
+(BOOL)checkMobilePhoneNumber:(NSString *)str;
/**
 *  去掉一些手机号前缀
 */
+(NSString *)mobileRemoveChinaPrefixNum:(NSString *)mobile;

/**
 *  座机校验
 *
 */

+(BOOL)checkTelephoneNumber:(NSString *)str;

/**
 *  身份证号校验
 *
 */
+(BOOL)checkIdentityID:(NSString *)str;

/**
 *  校验用户邮箱
 */
+ (BOOL) checkUserEmail:(NSString *) str;

/**
 *  邮编 校验
 *  @param str 邮编
 *  @return BOOL
 */
+ (BOOL)checkPostCode:(NSString *)str;

/**
 *  校验车牌号
 */
+ (BOOL)checkCarNo:(NSString *)carNum;

/**
 *  QQ号校验
 */
+(BOOL)CheckQQNo:(NSString *)str;


#pragma mark 校验字符串组成
/**
 *  密码校验(6-20位字母和数字组成)
 */
+ (BOOL)checkpassword:(NSString *)string;

/**
 *  真实中国姓名校验(2-20位含汉字和•)
 */
+ (BOOL)checkChineseRealName:(NSString *)string;

/**
 *  真实国际姓名校验(2-20位汉字•和大小写字母)
 */
+ (BOOL)checkInternationalRealName:(NSString *)string;

/**
 *  普通正常字符串 只包含字母数字汉字和空格
 */
+ (BOOL)checkNormalString:(NSString *)str;

/**
 *  汉字校验(只包含汉字)
 */
+ (BOOL)checkChinese:(NSString *)string;

/**
 *  汉字校验(只包含空格或汉字)
 */
+ (BOOL)checkChineseAndSpace:(NSString *)string;
/**
 *  字母数字校验(只包含字母和数字)
 */
+ (BOOL)checkLetterAndNum:(NSString *)string;

/**
 *  校验只包含字母和汉字
 */
+(BOOL)checkCharactorAndChinese:(NSString *)string;
@end
