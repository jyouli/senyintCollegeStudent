//
//  YLRegularCheck.m
//  ToolClassDemo
//
//  Created by    任亚丽 on 16/8/16.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLRegularCheck.h"

@implementation YLRegularCheck

#pragma mark 号码较验
/**
 *  手机号码校验
 *
 */
+(BOOL)checkMobilePhoneNumber:(NSString *)str
{
    if ([self isEmpty:str]) {
        return NO;
    }
    //@"^0?(13|14|15|18|17)[0-9]{9}$"
    NSString *regexStr = @"^(13[0-9]|14[5|7]|15[0-9]|18[0-9])\\d{8}$";
    
    NSPredicate *mobilePhonePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    if ([mobilePhonePredicate evaluateWithObject:str]) {
        return YES;
    } else {
    
        return [mobilePhonePredicate evaluateWithObject:[self mobileRemoveChinaPrefixNum:str]];
    }
    
}
/**
 *  去掉一些手机号前缀
 */
+(NSString *)mobileRemoveChinaPrefixNum:(NSString *)mobile
{
    if (mobile.length <= 6) {
        return @"";
    }
    mobile = [mobile stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];//去除左右的空格和换行
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];//去除所有空格
    if ([mobile hasPrefix:@"+86"]) {
        mobile = [mobile substringFromIndex:3];
    }
    
    if ([mobile hasPrefix:@"86"]) {
        mobile = [mobile substringFromIndex:2];
    }
    
    if ([mobile hasPrefix:@"0086"]) {
        mobile = [mobile substringFromIndex:4];
    }
    
    return mobile;
}


/**
 *  座机校验
 *
 */

+(BOOL)checkTelephoneNumber:(NSString *)str
{
    if ([self isEmpty:str]) {
        return NO;
    }
    // @"(\\d{3}-|\\d{4}-)?(\\d{8}|\\d{7})?";
    //@"(\\d{3}-|\\d{4}-)?(\\d{8}|\\d{7})?"
    NSString *regexStr = @"^(0[0-9]{2,3}(/-)?)?([2-9][0-9]{6,7})+((/-)?[0-9]{1,4})?$"; //座机号
    NSPredicate *telephone = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [telephone evaluateWithObject:str];
    
}



/**
 *  身份证号校验
 *
 */
+(BOOL)checkIdentityID:(NSString *)str
{
    if ([self isEmpty:str]) {
        return NO;
    }
    NSString *regexStr = @"^(\\d{6})(18|19|20)?(\\d{2})(\\d{4})(\\d{3})(\\d|X)?$";
    NSPredicate *identity = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    return [identity evaluateWithObject:str];
}
/**
 *  校验用户邮箱
 */
+ (BOOL) checkUserEmail:(NSString *) str
{
    if ([self isEmpty:str]) {
        return NO;
    }
    //@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
    // @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    NSString *emailRegex = @"^[a-zA-Z0-9_\\.]*@[a-zA-Z0-9_\\.]+(\\.[[a-zA-Z0-9_\\.]{2,4}]+)+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [predicate evaluateWithObject:str];
    
}

/**
 *  邮编 校验
 *
 *  @param postCode 邮编
 *
 *  @return BOOL
 */
+ (BOOL)checkPostCode:(NSString *)str {
    if ([self isEmpty:str]) {
        return NO;
    }
    
    NSString *emailRegex = @"^[1-9][0-9]{5}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [predicate evaluateWithObject:str];
    
}

/**
 *  校验车牌号
 */
+ (BOOL)checkCarNo:(NSString *)carNum
{

    if ([self isEmpty:carNum]) {
        return NO;
    }
    @try {
        NSString *regexStr = @"^[\u4e00-\u9fa5]{1}[A-z]{1}[A-z0-9]{5}$";
        
        NSPredicate *carNumPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
        BOOL flag = [carNumPredicate evaluateWithObject:carNum];
        
        [carNum uppercaseString];  //首字母大字
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"ex = %@", [exception description]);
    }
    @finally {
        NSLog(@"ok");
    }
    return NO;
}

/**
 *  QQ号校验
 */
+(BOOL)CheckQQNo:(NSString *)str
{
    if ([self isEmpty:str]) {
        return NO;
    }

    NSString *patternQQ = @"^[1-9](\\d){4,9}$";
    NSError *error;
    NSRegularExpression *regexqq = [NSRegularExpression regularExpressionWithPattern:patternQQ options:0 error:&error];
    //    NSTextCheckingResult *isMatchQQ = [regexqq firstMatchInString:str options:0 range:NSMakeRange(0, [str length])];
    
    NSUInteger numberofMatch = [regexqq numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, [str length])];
    if (numberofMatch > 0) {
        return  YES;
    } else {
        
        return NO;
    }
    
    
}


#pragma mark 校验字符串组成
/**
 *  密码校验(6-20位字母和数字组成)
 */
+ (BOOL)checkpassword:(NSString *)string
{
    if ([self isEmpty:string]) {
        return NO;
    }

    NSString *regex = @"^[A-Za-z0-9]{6,20}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];

}

/**
 *  真实中国姓名校验(只包含汉字和.)
 */
+ (BOOL)checkChineseRealName:(NSString *)string
{
    if ([self isEmpty:string]) {
        return NO;
    }
    
    NSString *regex = @"^[.··•\u4e00-\u9fa5]{2,20}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/**
 *  真实国际姓名校验(只包含汉字和.和大小写字母)
 */
+ (BOOL)checkInternationalRealName:(NSString *)string
{
    if ([self isEmpty:string]) {
        return NO;
    }
    
    NSString *regex = @"^[.··•a-zA-Z\u4e00-\u9fa5]{2,20}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}


/**
 *  普通正常字符串 只包含字母数字汉字和空格
 */
+ (BOOL)checkNormalString:(NSString *)string
{
    if ([self isEmpty:string]) {
        
        return NO;
    }

    NSString *stringRegex = @"^[ |0-9a-zA-Z\u4e00-\u9fa5]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [predicate evaluateWithObject:string];
}



/**
 *  汉字校验(只包含汉字)
 */
+ (BOOL)checkChinese:(NSString *)string
{
    if ([self isEmpty:string]) {
        return NO;
    }

    @try {
        NSString *regex = @"^[\u4e00-\u9fa5]+$";
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        BOOL flag = [predicate evaluateWithObject:string];
        return flag;
    }
    @catch (NSException *exception) {
        NSLog(@"ex = %@", [exception description]);
    }
    @finally {
        //NSLog(@"ok");
    }
    return NO;
}

/**
 *  汉字校验(只包含空格或汉字)
 */
+ (BOOL)checkChineseAndSpace:(NSString *)string
{
    if ([self isEmpty:string]) {
        
        return NO;
    }

    NSString *regex = @"^[ \u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

/**
 *  字母数字校验(只包含字母和数字)
 */
+ (BOOL)checkLetterAndNum:(NSString *)string
{
    if ([self isEmpty:string]) {
        
        return NO;
    }

    NSString *regex = @"^[A-Za-z0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}



/**
 *  校验只包含字母和汉字
 */
+(BOOL)checkCharactorAndChinese:(NSString *)string{
    
    if ([self isEmpty:string]) {
        
        return NO;
    }

    NSString *regex = @"^[A-Za-z\u4E00-\u9FA5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}



/**
 *  非负整数校验
 *
 */
+ (BOOL)checkUnsignedInt:(NSString *)string
{
    if ([self isEmpty:string]) {
        
        return NO;
    }

    NSString *stringRegex = @"^\\d+$";
    NSPredicate *stringTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    return [stringTest evaluateWithObject:string];
    
    
    //    NSScanner* scan = [NSScanner scannerWithString:string];
    //    int val;
    //    return[scan scanInt:&val] && [scan isAtEnd];
    
}


+ (BOOL)isEmpty:(NSString *)str {
    
    if ([str isEqual:[NSNull null]] || str == NULL || [str length] == 0 ) {
        return YES;
    }
    
    return NO;
}

@end
