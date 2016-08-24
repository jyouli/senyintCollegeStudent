//
//  NSString+Attribute.h
//  ToolClassDemo
//
//  Created by    任亚丽 on 16/8/16.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 * AttributeString相关 均为类方法
 */
@interface NSString (Attribute)
/**
 * 组装NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttributedStringFromString:(NSString *)str Color:(UIColor *)color Fount:(UIFont *)font;

/**
 * 组装NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttributedStringFromString:(NSString *)str1 Color:(UIColor *)color1 Fount:(UIFont *)font1 AndString:(NSString *)str2 Color:(UIColor *)color2 Fount:(UIFont *)font2;

/**
 * 组装AttributesDictionary
 */
+ (NSDictionary *)getAttributedStringDicWithTextColor:(UIColor *)textColor BackgroundColor:(UIColor *)bgColor Fount:(UIFont *)font LineSpace:(NSInteger)lineSpace;


/**
 * 计算AttributedString的大小
 * attributesDic: AttributedString设置
 * maxSize: 边界size 返回的size不会大于maxSize
 */
+ (CGSize)attributesStringSizeWith:(NSString *)str andAttributes:(NSDictionary *)attributesDic andConstrainedToSize:(CGSize)maxSize;

@end
