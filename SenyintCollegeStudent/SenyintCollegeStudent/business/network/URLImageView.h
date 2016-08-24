//
//  URLImageView.h
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/23.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
/**
 使用UIImageView+AFNetworking
 */
@interface URLImageView : UIImageView


- (void)setImageWithURLStr:(nonnull NSString *)url;


- (void)setImageWithURLStr:(nullable NSString *)url
       placeholderImage:(nullable UIImage *)placeholderImage;



- (void)setImageWithURLRequest:(nullable NSURLRequest *)urlRequest
              placeholderImage:(nullable UIImage *)placeholderImage
                       success:(nullable void (^)(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response, UIImage * _Nullable image))success
                       failure:(nullable void (^)(NSURLRequest * _Nullable request, NSHTTPURLResponse * _Nullable response, NSError * _Nullable error))failure;
@end
