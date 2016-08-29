//
//  SCSpecialtyModel.m
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCSpecialtyModel.h"

@implementation SCSpecialtyModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n pecialtyId:%@,pid:%@,name:%@,serverid:%@",[super description],self.specialtyId,self.pid,self.name,self.severId];
}
- (void)setModel:(SCSpecialtyModel *)model
{
    self.severId = model.severId;
    self.pid = model.pid;
    self.specialtyId = model.specialtyId;
    self.name = model.name;
}

@end
