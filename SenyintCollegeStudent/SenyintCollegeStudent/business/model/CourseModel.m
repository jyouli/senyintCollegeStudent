//
//  CourseModel.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "CourseModel.h"
@implementation CourseModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%p:courseTitle=%@,courseStateDate=%@,courseDutationDate=%@,courseIntroduction=%@,introductionSize=%@",self,self.courseTitle,self.courseStateDate,self.courseDutationDate,self.courseIntroduction,NSStringFromCGSize(self.introductionSize)];
}


- (void)setCourseDataFromResponseObject:(id)responseObject
{
    self.roomid = [[responseObject objectForKey:@"content"] objectForKey:@"course_room_id"];
    self.courseTitle = [[responseObject objectForKey:@"content"] objectForKey:@"course_title"];
    self.courseIntroduction = [[responseObject objectForKey:@"content"] objectForKey:@"course_summary"];
    self.introductionSize = CGSizeZero;
    if ([self.courseIntroduction length]) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        self.introductionSize = [self.courseIntroduction boundingRectWithSize:CGSizeMake(self.introductionWidth, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin   attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13.5],NSFontAttributeName,paragraphStyle.copy, NSParagraphStyleAttributeName, nil] context:Nil].size;

    }
    self.course_start_time = [[[responseObject objectForKey:@"content"] objectForKey:@"course_start_time"] longLongValue] / 1000;
    self.courseStateDate = [YLDateTimeTool dateStringWithTimeIntervalSince1970:self.course_start_time  andStyleStr:@"M月d日 aah:mm"];
    self.course_duration = [NSString stringWithFormat:@"%@",[[responseObject objectForKey:@"content"] objectForKey:@"course_duration"]];
    self.courseDutationDate = [[YLDateTimeTool getContinuedTimeWithSecons:[self.course_duration longLongValue]] substringToIndex:5];
    
}
@end
