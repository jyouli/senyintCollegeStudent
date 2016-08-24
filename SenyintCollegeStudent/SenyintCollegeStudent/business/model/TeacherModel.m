//
//  TeacherModel.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "TeacherModel.h"

@implementation TeacherModel
- (NSString *)description
{
    return [NSString stringWithFormat:@"%p:name=%@,title=%@,uid=%@,mobile=%@,image=%@,tags=%@,summary=%@,hos=%@,size=%@",self,self.teacher_user_name,self.teacher_title,self.teacher_uid,self.teacher_mobile,self.teacher_head_image,self.teacher_tags,self.teacher_summary,self.teacher_hos,NSStringFromCGSize(self.introductionSize)];
}


- (void)setDataFromResponseObject:(id)responseObject
{
    
    self.teacher_user_name = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_user_name"];
    self.teacher_uid = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_uid"];
    self.teacher_mobile = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_mobile"];
    self.teacher_head_image = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_head_image"];
    self.teacher_title = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_title"];
    self.teacher_tags = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_tags"];
    self.teacher_summary = [[responseObject objectForKey:@"content"] objectForKey:@"teacher_summary"];
    
    

    
    [self calculateTeacherOtherParameter];
    
    
}
//计算_teacherModel的其他辅助参数
- (void)calculateTeacherOtherParameter
{
    if (!self.teacher_tags) {
        return;
    } else {
        NSArray *tags = [self.teacher_tags componentsSeparatedByString: @"|"];
        if (tags.count <= 2) {
            self.teacher_hos = [[tags subarrayWithRange:NSMakeRange(0, tags.count)] componentsJoinedByString:@"  "];
        } else {
            
            self.teacher_hos = [[tags subarrayWithRange:NSMakeRange(0, 2)] componentsJoinedByString:@"  "];
            self.tags = [tags subarrayWithRange:NSMakeRange(2, tags.count - 2)];
            self.tapsHeight = [self getTapsHeight];
        }
        
    }
    
    self.introductionSize = CGSizeZero;
    if ([self.teacher_summary length]) {
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5.0;
        //    paragraphStyle.alignment = NSTextAlignmentLeft;
        //    paragraphStyle.headIndent = 4.0;
        //    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
        NSDictionary * attributes = @{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:14]};
        self.introductionSize = [self.teacher_summary boundingRectWithSize:CGSizeMake(self.tapViewWidth , CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin   attributes:attributes context:Nil].size;
        self.introductionAttributes = attributes;
    }
    self.tapsHeight = [self getTapsHeight];
    //0.09668
    
    
}
//计算专家标签的高度
- (float)getTapsHeight {
    
    float spaceH = 10;
    float spaceV = 5;
    float wmin = 60;
    float wmax = self.tapViewWidth;
    float h = 25;
    float x = 0;
    float y = 0;
    UIFont *font = [UIFont systemFontOfSize:13];
    BOOL isNeedAdd25 = NO;
    for (NSString *str in self.tags) {
        if (!str || ![str length] || [str isEqual:[NSNull null]]) {
            continue;
        } else {
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
            CGSize size = [str boundingRectWithSize:CGSizeMake(wmax, h) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin   attributes:[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,paragraphStyle.copy, NSParagraphStyleAttributeName, nil] context:Nil].size;

            if (wmax - x < 20) {
                x = 0;
                y += h + spaceH;
            }
            if (size.width + 30 <= wmax - x) {
                if (size.width < wmin) {
                    if (60 < wmax - x) {
                        x += 60 + spaceH;
                    }
                } else {
                    x += size.width + 30 + spaceH;
                    
                }
                
                isNeedAdd25 = YES;
            } else if (size.width + 30 > wmax - x && (size.width + 15 <= wmax - x)) {
                
                x = 0;
                y += h + spaceV;
                isNeedAdd25 = NO;
                
            } else {
                if (size.width + 15 < wmax - x) {
                    x = 0;
                    y += h + spaceV;
                    isNeedAdd25 = NO;
                } else {
                    x = 0;
                    y += h + spaceV;
                    
                    if (size.width + 30 < wmax - x) {
                        x += size.width + 30 + spaceH;
                        isNeedAdd25 = YES;
                    } else {
                        x = 0;
                        y += h + spaceV;
                        isNeedAdd25 = NO;
                        
                    }
                    
                }
                
                
            }
        }
        
    }
    if (isNeedAdd25) {
        y += h;
        
    } else {
        y -= spaceH;
    }
    
    return y;
}
@end
