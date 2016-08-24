//
//  StudentModel.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "StudentModel.h"

@implementation StudentModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%p:name=%@,uid=%@,mobile=%@,passwork= %@,image=%@,title=%@,tags=%@,summary=%@,state=%ld",self,self.user_name,self.uid,self.mobile,self.password,self.head_image,self.title,self.tags,self.summary,self.state];

}
- (void)setDataFromResponseObject:(id)responseObject
{
    self.user_name = [responseObject objectForKey:@"user_name"];
    self.uid = [responseObject objectForKey:@"uid"];
    self.mobile = [responseObject objectForKey:@"mobile"];
    self.password = [responseObject objectForKey:@"password"];
    self.head_image = [responseObject objectForKey:@"head_image"];
    self.state = [[responseObject objectForKey:@"status"] boolValue];
    self.title = [responseObject objectForKey:@"title"];
    self.tags = [responseObject objectForKey:@"tags"];
    self.summary = [responseObject objectForKey:@"summary"];


}
@end
