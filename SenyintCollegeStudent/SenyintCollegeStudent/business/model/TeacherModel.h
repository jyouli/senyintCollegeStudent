//
//  TeacherModel.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TeacherModel : NSObject
@property (nonatomic, copy) NSString *teacher_user_name;
@property (nonatomic, copy) NSString *teacher_uid;
@property (nonatomic, copy) NSString *teacher_mobile;
@property (nonatomic, copy) NSString *teacher_head_image;
@property (nonatomic, copy) NSString *teacher_title;
@property (nonatomic, copy) NSString *teacher_tags;
@property (nonatomic, copy) NSString *teacher_summary;
@property (nonatomic, copy) NSString *teacher_hos;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, assign) float tapViewWidth;
@property (nonatomic, assign) float  tapsHeight;
@property (nonatomic, strong) NSDictionary *introductionAttributes;
@property (nonatomic, assign) CGSize introductionSize;
@property (nonatomic, assign) BOOL isShowMoreIntroduction;


- (void)setDataFromResponseObject:(id)responseObject;


@end
