
#import "NSString+Custom.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Custom)

- (NSString *)linebreakAtMiddle
{
    if ([self length] < 3) {
        return self;
    }
    
    int mid = ceil((double)[self length]/2);
    return [NSString stringWithFormat:@"%@\n%@", [self substringToIndex:mid], [self substringFromIndex:mid]];
}

- (NSString *)trim
{
    // 去掉空格和换行
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimNonCharDigt
{
    // 转为小写
    NSString *targetString = [self lowercaseString];
    // 去掉空格和换行
    targetString = [targetString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    // 去掉空格
    targetString = [targetString stringByReplacingOccurrencesOfString:@" " withString:@""];
    targetString = [targetString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    targetString = [targetString stringByReplacingOccurrencesOfString:@"_" withString:@""];
    return targetString;
}

+ (BOOL)isBlankString:(NSString *)string{
    // nil为空
    if (string == nil) {
        return YES;
    }

    // NULL为空
    if (string == NULL) {
        return YES;
    }

    // NSNull则为空
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }

    // 去掉空格和换行后长度为0，则为空
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        return YES;
    }
    
    return NO;
}

+ (NSString *)getTheCorrectNum:(NSString *)text
{
    // 循环去掉数字头部的0，如果是0.则不再处理
    while ([text hasPrefix:@"0"] && ![text hasPrefix:@"0."])
    {
        text = [text substringFromIndex:1];
        
    }
    return text;
}

//+ (NSString *)transferHTMLTag:(NSString *)content
//{
//    if ([NSString isBlankString:content]) {
//        return nil;
//    }
//    NSString *targetString = content;
//    // 去掉空格
//    targetString = [targetString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//    // 小写标签
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"</p>" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<br >" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<strong>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<b>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"</b>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
//    // 大写标签
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<P>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"</P>" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<BR>" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<BR/>" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<BR >" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<BR />" withString:@"\n"];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<STRONG>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"</STRONG>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"<B>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"</B>" withString:@""];
//    targetString = [targetString stringByReplacingOccurrencesOfString:@"&NBSP;" withString:@""];
//
//    return targetString;
//}


+ (NSString *)md5:(NSString *)str
{
    if (str.length == 0) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

// JSON字符串转成Dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if (err) {
        NSLog(@"json字符串解析失败：%@",err);
        return nil;
    }
    return dic;
}

// 字典或数组转JSON
+ (NSString *)toJSONData:(id)theData
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                     encoding:NSUTF8StringEncoding];
        return jsonString;
    } else {
        return nil;
    }
}

// 对字符串进行URL编码
- (NSString *)URLEncodedString
{
    //    NSString *encodedString = (__bridge_transfer NSString *)
    //    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
    //                                            (CFStringRef)self,
    //                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
    //                                            NULL,
    //                                            kCFStringEncodingUTF8);
    static NSString * const kAFCharactersToBeEscapedInQueryString = @":/?&=;+!@#$()',*";
    NSString *encodedString = (__bridge_transfer  NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)kAFCharactersToBeEscapedInQueryString, CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return encodedString;
}

// 判断是否包含字符串
- (BOOL)customContainsString:(NSString*)other
{
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

// 返回文本行数
- (NSUInteger)numberOfLines {
    return [[self componentsSeparatedByString:@"\n"] count] + 1;
}

@end
