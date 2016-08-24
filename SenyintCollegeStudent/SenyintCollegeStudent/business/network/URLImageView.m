//
//  URLImageView.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/23.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "URLImageView.h"

@implementation URLImageView

- (void)setImageWithURLStr:(nonnull NSString *)url
{

    if ([url isEqual:[NSNull null]] || [url length] == 0) {
        
        return;
    }
    
    [self setImageWithURL:[NSURL URLWithString:url]];
    
}


- (void)setImageWithURLStr:(nullable NSString *)url
          placeholderImage:(nullable UIImage *)placeholderImage
{
    if ([url isEqual:[NSNull null]] || [url length] == 0) {
        
        return;
    }
    [self setImageWithURL:[NSURL URLWithString:url] placeholderImage:placeholderImage];
}

- (void)setImageWithURL:(NSURL *)url
{
    [self setImageWithURL:url placeholderImage:nil];
}


- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(nullable UIImage *)placeholderImage
{
    [super setImageWithURL: url placeholderImage:placeholderImage];
}



- (void)setImageWithURLRequest:(NSURLRequest *)urlRequest
              placeholderImage:(nullable UIImage *)placeholderImage
                       success:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, UIImage *image))success
                       failure:(nullable void (^)(NSURLRequest *request, NSHTTPURLResponse * _Nullable response, NSError *error))failure
{


    [super setImageWithURLRequest:urlRequest placeholderImage:placeholderImage success:success failure:failure];
}
@end
