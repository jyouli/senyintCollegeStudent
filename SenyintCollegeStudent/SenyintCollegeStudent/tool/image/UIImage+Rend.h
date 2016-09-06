//
//  UIImage+Rend.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/2.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rend)

// 创建size为1的指定颜色的image
+ (UIImage *)createImageWithColor:(UIColor *)color;

// 载取view指定范围的Image
+ (instancetype) captureView:(UIView *)view withFrame:(CGRect)rect;

// 创建指定大小，指定颜色的image
+ (UIImage *)createImageColor:(UIColor *)color WithSize:(CGSize) size;

// 创建指定大小，指定颜色的image 并写入相册
+ (void )createAndSaveImageColor:(UIColor *)color WithSize:(CGSize) size;

// 载取view指定范围的Image并存到相册
+ (instancetype) captureViewAndSaveImage:(UIView *)view withFrame:(CGRect)rect;

@end
