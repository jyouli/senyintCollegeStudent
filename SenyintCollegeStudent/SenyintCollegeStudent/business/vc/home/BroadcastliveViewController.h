//
//  BroadcastliveViewController.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController.h"
#import "ParticipantModel.h"

@interface BroadcastliveViewController : SCBaseViewController

@property (nonatomic, strong) ParticipantModel *expertModel;//专家的渲染model
@property (nonatomic, strong) NSArray *studentModels;
@property (nonatomic, assign) NSTimeInterval startTime;

//有同学加入会议
- (void)studentAddMeeting:(ParticipantModel *)model;

//专家加入会议
- (void)expertAddMeeting:(ParticipantModel *)model;

//有人离开会议
- (void)otherLeaveMeeting:(ParticipantModel *)model;
@end
