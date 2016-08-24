//
//  NetWorkManager.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/23.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "NetWorkManager.h"

@implementation NetWorkManager
+ (instancetype)manager {
    
    
    NSLog(@"%s",__func__);
    
    return [[[self class] alloc] initWithBaseURL:nil];
}

- (instancetype)init {
    
    NSLog(@"%s",__func__);
    
    return [self initWithBaseURL:nil];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    NSLog(@"%s",__func__);
    
    return [self initWithBaseURL:url sessionConfiguration:nil];
}

- (instancetype)initWithSessionConfiguration:(NSURLSessionConfiguration *)configuration {
    NSLog(@"%s",__func__);
    
    return [self initWithBaseURL:nil sessionConfiguration:configuration];
    
    
}

+ (void)initialize
{
    NSLog(@"initialize");
}


- (void)test {
    NSLog(@"test");
}
- (instancetype)initWithBaseURL:(NSURL *)url
           sessionConfiguration:(NSURLSessionConfiguration *)configuration
{
    
    //    self = [super initWithSessionConfiguration:configuration];
    if (!self) {
        return nil;
    }
    
    // Ensure terminal slash for baseURL path, so that NSURL +URLWithString:relativeToURL: works as expected
    if ([[url path] length] > 0 && ![[url absoluteString] hasSuffix:@"/"]) {
        url = [url URLByAppendingPathComponent:@""];
    }
    
    //    self.baseURL = url;
    
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return self;
}
@end
