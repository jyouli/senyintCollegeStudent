//
//  JusTalkObject.h
//  Test
//
//  Created by fafangshuai on 16/7/22.
//  Copyright © 2016年 YL. All rights reserved.
//
/*
 菊风sdk封装
 **/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "mtc_api.h"
#import "mtc_conf.h"
#import "ParticipantModel.h"

@protocol JusTalkManagerDelegate <NSObject>

@optional
//初始化回调
- (void)justalkinitializeOk;
- (void)justalkinitializeFail:(ZINT)reason;
//登录回调
- (void)justalkSendLoginFile:(ZINT)reason;//登录发出失败
- (void)justalkLoginOk;
- (void)justalkLoginFail:(ZINT)reason;
- (void)justalkLogoutOk;//注销完成回调
- (void)justalkLogouted;//被异地登录回调

//创建会议回调
- (void)justalkCreateConferenceOk:(NSString *)roomid;
- (void)justalkCreateConferenceFail:(NSString *)reason;
//查询会议回调
- (void)justalkQueryConferenceOk:(NSDictionary *)dic;
- (void)justalkQueryConferenceFail:(NSString *)reason;
//自己加入会议回调
- (void)justalkJoinConferenceOk:(NSDictionary *)dic;
- (void)justalkJoinConferenceFail:(NSString *)reason;
- (void)justalkDidLeaveConference:(EN_MTC_CONF_REASON_TYPE)reason;
//有成员加入或离开会议回调
- (void)justalkOtherJoinConference:(NSDictionary *)dic;
- (void)justalkOtherLeaveConference:(NSDictionary *)dic;
@end


@interface JusTalkManager : NSObject
//初始化
+(instancetype)sharedJusTalk;
- (void)jusTalkinitialize;


@property (nonatomic , assign,readonly) BOOL isLogined;
@property (nonatomic, weak) id<JusTalkManagerDelegate> delegate;
//会议信息
@property (nonatomic, strong, readonly) NSString *mtcConfNumber;
@property (nonatomic, strong, readonly) NSString *mtcConfUri;
@property (nonatomic, strong, readonly) NSString *mtcConfId;

#pragma mark 菊风回调
//初始化回调
@property (nonatomic, copy) void (^justalkinitializeOkBlock)(void);
@property (nonatomic, copy) void (^justalkinitializeFailBlock)(NSString *reason);
//登录回调
@property (nonatomic, copy) void (^justalkLoginOkBlock)(void);
@property (nonatomic, copy) void (^justalkLoginFailBlock)(NSString *reason);
@property (nonatomic, copy) void (^justalkLogoutOkBlock)(void);//注销完成回调
@property (nonatomic, copy) void (^justalkLogoutedBlock)(void);//异地登录回调


//创建会议回调
@property (nonatomic, copy) void (^justalkCreateMeetingOkBlock)(NSString *roomid);
@property (nonatomic, copy) void (^justalkCreateMeetingFailBlock)(NSString *reason);
//查询会议回调
@property (nonatomic, copy) void (^justalkQueryMeetingOkBlock)(NSDictionary *dic);
@property (nonatomic, copy) void (^justalkQueryMeetingFailBlock)(NSString *reason);
//自己加入会议回调
@property (nonatomic, copy) void (^justalkJoinMeetingOkBlock)(NSDictionary *dic);
@property (nonatomic, copy) void (^justalkJoinMeetingFailBlock)(NSString *reason);
@property (nonatomic, copy) void (^justalkDidLeaveMeetingBlock)(int reason);
//有成员加入或离开会议回调
@property (nonatomic, copy) void (^justalkOtherJoinMeetingBlock)(NSDictionary *dic);
@property (nonatomic, copy) void (^justalkOtherLeaveMeetingBlock)(NSDictionary *dic);

#pragma mark end

typedef void (^resultBlock)(NSString* promptInformation);
//登录到菊风服务器
- (void)loginJustalkToRSAWithUserName:(NSString *)user PassWord:(NSString *)password;

//从菊风服务器登出
- (void)logoutFromJustalk;

//创建并加入会议
- (void)creatAndjoinMeetingWithTitle:(NSString*) meetTitle;

//查询会议
- (void)queryMeetingWithroomid:(NSString *)roomid;

//加入会议
- (void)joinMeetingWithConfUri:(NSString *)mtcUri;

//离开会议
- (void)leveMeetingWithMeetid:(ZUINT)confId;

//打开音频采集
- (BOOL)prepareAudioandopenResult:(void(^)(NSString* promptInformation))openAudio;

//打开视频采集并关联摄像头
- (BOOL)prepareVideoWith:(BOOL)captureFront withmtcConfId:(NSString *)confId openResult:(resultBlock) openVideo;
//渲染视频
- (void)renderinginView:(UIView *)view withParticipantModel:(ParticipantModel *)model resultBlock:(resultBlock)resrlt;
//停止渲染
- (void)stopRander:(UIView *)view;
//开始发送视频数据
- (void)startSendvideoandAudioData:(NSString *)uri;
//停止数据采集 输出 发送
- (void)stopSendvideoandAudioData;
//切换静音 Yes 静音,不发送音频 NO 发送音频
- (void)changeMuteState:(BOOL) ismute;
//切换前后摄像头
- (void)changeCaptureSelfModel:(ParticipantModel *)model;
//旋转摄像头角度
- (void) videoRenderRotateWithParticipantModel:(ParticipantModel *)selfModel;
@end