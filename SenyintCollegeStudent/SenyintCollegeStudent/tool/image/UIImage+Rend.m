//
//  UIImage+Rend.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/2.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "UIImage+Rend.h"

@implementation UIImage (Rend)

// 创建size为1的指定颜色的image
+ (UIImage *)createImageWithColor:(UIColor *)color
{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

// 载取view指定范围的Image
+ (instancetype) captureView:(UIView *)view withFrame:(CGRect)rect
{
    UIGraphicsBeginImageContext(view.frame.size);
    
    //    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //    CGContextSaveGState(ctx);
    UIRectClip(rect);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

// 创建指定大小，指定颜色的image
+ (UIImage *)createImageColor:(UIColor *)color WithSize:(CGSize) size
{
    
    
    UIGraphicsBeginImageContext(size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return theImage;
    
}

// 创建指定大小，指定颜色的image 并写入相册
+ (void )createAndSaveImageColor:(UIColor *)color WithSize:(CGSize) size
{
    
    
    UIImage *img = [self createImageColor:color WithSize:size];
    UIImageWriteToSavedPhotosAlbum(img,nil, nil, nil);

}


@end
