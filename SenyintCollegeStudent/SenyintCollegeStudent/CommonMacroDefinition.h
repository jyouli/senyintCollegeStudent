//
//  CommonMacroDefinition .h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#ifndef CommonMacroDefinition__h
#define CommonMacroDefinition__h

//输出
#ifdef DEBUG
# define NSLog(frmt, ...) NSLog((@"%s -%d " frmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
# define NSLog(...) {}
#endif


//屏幕尺寸
#define Screen_Bounds ([UIScreen mainScreen].bounds)
#define Screen_Height ([UIScreen mainScreen].bounds.size.height)
#define Screen_Width ([UIScreen mainScreen].bounds.size.width)


//系统判断
#define iOS6_OR_Before ((floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1))

#define IOS7_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )

#define IOS8_OR_LATER  ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )


//机型判断
#define iPhone4_4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_5C_5S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)) : NO)


//RGB三元色简写
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
//RGB三元色十六进制数简写
#define COLOR_RGBA_HEX(rgbValue) COLOR_RGBA((((rgbValue) & 0xFF000000) >> 24), (((rgbValue) & 0xFF0000) >> 16), (((rgbValue) & 0xFF00) >> 8), (((rgbValue) & 0xFF)/255.0f))


#endif
