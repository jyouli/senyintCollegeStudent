//
//  ParticipantModel.m
//  JusTalkTest
//
//  Created by    任亚丽 on 16/7/27.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ParticipantModel.h"
@implementation ParticipantModel

- (instancetype)init
{
    if (self == [super init]) {
        
        _rendView = [[RendView alloc] init];
        _rendView.model = self;
 
    }
    
    return self;
}
- (NSString *)description
{

    return [NSString stringWithFormat:@"model={\nuserUri:%@\nusername:%@\nroleId:%ld\nconfState:%ld\nisSelf:%d\nisBack:%d\angle:%f\n%@,}",self.userUri,self.username,self.roleId,self.confState,self.isSelf,self.isBack,self.angle,_rendView];
}

- (void)updateRendViewSuperView:(UIView *)superView
{
    [_rendView updateRendViewSuperView:superView];
}
@end
