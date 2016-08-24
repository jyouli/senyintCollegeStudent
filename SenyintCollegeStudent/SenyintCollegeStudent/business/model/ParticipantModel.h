//
//  ParticipantModel.h
//  JusTalkTest
//
//  Created by    任亚丽 on 16/7/27.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "RendView.h"
@interface ParticipantModel : NSObject
@property (nonatomic, copy) NSString *meetingUri;
@property (nonatomic, copy) NSString *meetingid;
@property (nonatomic, copy) NSString *meetingRoomid;
@property (nonatomic, copy) NSString *userUri;
@property (nonatomic, copy) NSString *username;//一般是手机号
@property (nonatomic, copy) NSString *nickName;//昵称
@property (nonatomic, copy) NSString *headimg;//头像
@property (nonatomic, assign) NSInteger confState;
@property (nonatomic, assign) NSInteger roleId;// 7=参与者  15=创建者
@property (nonatomic, copy) NSString *renderId;


@property (nonatomic, strong,readonly) RendView *rendView;//渲染的view

@property (nonatomic, assign) int picSize;//清晰度 自己的设置无效
@property (nonatomic, assign) int frameRate;//每秒帧数
@property (nonatomic, assign) int volume;
@property (nonatomic, getter=isSended) BOOL sended;
@property (nonatomic, assign) BOOL isOnline;//是否在直播室中
@property (nonatomic, assign) BOOL isExpert;//是不是专家
@property (nonatomic, assign) BOOL isSelf;//是不是自己 渲染的时候用到
@property (nonatomic, assign) float angle;//渲染角度 渲染自己的时候用到
@property (nonatomic, assign) BOOL isBack;//渲染摄像头 渲染自己的时候用到 YES 后置摄像头 NO 前置

- (void)updateRendViewSuperView:(UIView *)superView;

@end
