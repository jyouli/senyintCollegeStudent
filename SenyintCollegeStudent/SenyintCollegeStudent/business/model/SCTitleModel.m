//
//  SCTitleModel.m
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCTitleModel.h"

@implementation SCTitleModel

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@\n titleId:%@,name:%@,serverid:%@",[super description],self.titleId,self.name,self.severId];
}
- (void)setModel:(SCTitleModel *)model
{
    self.severId = model.severId;
    self.titleId = model.titleId;
    self.name = model.name;
}
@end
