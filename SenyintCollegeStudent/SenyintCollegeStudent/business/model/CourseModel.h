//
//  CourseModel.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YLDateTimeTool.h"

@interface CourseModel : NSObject
@property (nonatomic, copy) NSString *courseId;
@property (nonatomic, copy) NSString *roomid;
@property (nonatomic, copy) NSString *courseTitle;
@property (nonatomic, strong) UIImage *courseImage;
@property (nonatomic, assign) NSTimeInterval course_start_time;
@property (nonatomic, copy) NSString *courseStateDate;
@property (nonatomic, copy) NSString *courseDutationDate;
@property (nonatomic, copy) NSString *course_duration;
@property (nonatomic, copy) NSString *courseIntroduction;
@property (nonatomic, assign) CGFloat introductionWidth;
@property (nonatomic, assign) CGSize introductionSize;
@property (nonatomic, assign) BOOL isShowMoreIntroduction;
- (void)setCourseDataFromResponseObject:(id)responseObject;
@end
