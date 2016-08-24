//
//  NSString+Attribute.m
//  ToolClassDemo
//
//  Created by    任亚丽 on 16/8/16.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "NSString+Attribute.h"

@implementation NSString (Attribute)


/**
 * 组装NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttributedStringFromString:(NSString *)str Color:(UIColor *)color Fount:(UIFont *)font
{
    if ([str isEmpty]) {
        return nil;
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];

    if (font && color) {
        [attributedStr addAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:color} range:NSMakeRange(0, str.length)];
        
    } else {
    
        if (font) {
            
            [attributedStr addAttributes:@{NSFontAttributeName:font} range:NSMakeRange(0, str.length)];
            
        }
        if (color) {
            [attributedStr addAttributes:@{NSForegroundColorAttributeName:color} range:NSMakeRange(0, str.length)];
            
        }
    
    }
    return attributedStr;
}

/**
 * 组装NSMutableAttributedString
 */
+ (NSMutableAttributedString *)getAttributedStringFromString:(NSString *)str1 Color:(UIColor *)color1 Fount:(UIFont *)font1 AndString:(NSString *)str2 Color:(UIColor *)color2 Fount:(UIFont *)font2
{

    if ([str1 isEmpty] && [str2 isEmpty]) {
        return nil;
    }
    if ([str1 isEmpty]){
        str1 = @"";
    }
    if ([str2 isEmpty]){
        str2 = @"";
    }
    NSString *str = [NSString stringWithFormat:@"%@%@",str1,str2];
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    if (str1.length) {
        if (font1 && color1) {
            [attributedStr addAttributes:@{NSFontAttributeName:font1,NSForegroundColorAttributeName:color1} range:NSMakeRange(0, str1.length)];
            
        } else if (font1) {
            
            [attributedStr addAttributes:@{NSFontAttributeName:font1} range:NSMakeRange(0, str1.length)];
            
        } else if (color1) {
            [attributedStr addAttributes:@{NSForegroundColorAttributeName:color1} range:NSMakeRange(0, str1.length)];
            
        } else {
            
        }
        
    }
    if (str2.length) {
        if (font2 && color2) {
            [attributedStr addAttributes:@{NSFontAttributeName:font2,NSForegroundColorAttributeName:color2} range:[str rangeOfString:str2]];
            
        } else if (font2) {
            
            [attributedStr addAttributes:@{NSFontAttributeName:font2} range:[str rangeOfString:str2]];
            
        } else if (color2) {
            [attributedStr addAttributes:@{NSForegroundColorAttributeName:color2} range:[str rangeOfString:str2]];
            
        } else {
            
        }
        
    }
    return attributedStr;
    

}

/**
 * 组装attributesDictory
 */
+ (NSDictionary *)getAttributedStringDicWithTextColor:(UIColor *)textColor BackgroundColor:(UIColor *)bgColor Fount:(UIFont *)font LineSpace:(NSInteger)lineSpace
{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithCapacity:3];
    if (textColor) {
        [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    }
    if (bgColor) {
        [attributes setObject:bgColor forKey:NSBackgroundColorAttributeName];

    }
    if (font) {
        [attributes setObject:font forKey:NSFontAttributeName];

    }
    if (lineSpace > 0) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0;
        //    paragraphStyle.alignment = NSTextAlignmentLeft;
        //    paragraphStyle.headIndent = 4.0;
        //    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    }

    
    return attributes;
}

/**
 * 计算AttributedString的大小
 * attributesDic: AttributedString设置
 * maxSize: 边界size 返回的size不会大于maxSize
 */
+ (CGSize)attributesStringSizeWith:(NSString *)str andAttributes:(NSDictionary *)attributesDic andConstrainedToSize:(CGSize)maxSize
{
    if ([str isEmpty]) {
        return CGSizeZero;
    }
    return [str boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin   attributes:attributesDic context:Nil].size;

}


- (BOOL)isEmpty {
    
    if ([self isEqual:[NSNull null]] || [self length] == 0) {
        
        return YES;
    }
    
    return NO;
}

@end
