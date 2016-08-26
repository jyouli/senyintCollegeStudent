
#import <Foundation/Foundation.h>

@interface NSString (Custom)

- (NSString*)linebreakAtMiddle;//字符串取中间折行
- (NSString*)trim;
- (NSString*)trimNonCharDigt;

/**
 * 自动去除数字之前的0
 */
+ (NSString*)getTheCorrectNum:(NSString *)text;//自动去除数字之前的零

/**
 * 判断是不是全空格字符串
 */
+ (BOOL)isBlankString:(NSString *)string;

/**
 * 对字符串进行md5加密
 */
+ (NSString *)md5:(NSString *)str;

// JSON字符串转成Dict
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

// 字典或数组转JSON
+ (NSString *)toJSONData:(id)theData;

// 对字符串进行URL编码
- (NSString *)URLEncodedString;

// 判断是否包含字符串
- (BOOL)customContainsString:(NSString*)other;

// 返回文本行数
- (NSUInteger)numberOfLines;

@end
