//
//  StudentModel.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentModel : NSObject
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *head_image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *summary;
@property (nonatomic, assign) BOOL state;
@property (nonatomic, assign) BOOL juskOnlineState;//菊风在线状态


- (void)setDataFromResponseObject:(id)responseObject;

@end
