



//
//  JusTalkObject.m
//  Test
//
//  Created by fafangshuai on 16/7/22.
//  Copyright © 2016年 YL. All rights reserved.
//

/*
 JusTalk SDK 使用
 准备 SDK 并创建应用 获取AppKey 如6cfbf9e075240e66a0334096
 1.导入jusTalk
 2.增加如下 Frameworks 和 Libraries 注意除了文档上的库还有VideoToolbox.framework
 3.设置头文件路径 Header Search Paths   $(PROJECT_DIR)/Test/jusTalk_6.8.1/jusLogin
 4.设置后台运行模式 TARGETS->Capabilties->Background Modes 设为YES 选中 Audio 和 Voice
 5.设置预处理宏定义 TARGETS->Build Settings 搜macros 在Apple LLVM7.0-Preprocessing的Preprocessing Macros
 6.在application:didFinishLaunchingWithOptions中做初始化操作
 **/

#import "JusTalkManager.h"
#import <AVFoundation/AVFoundation.h>
#import <JusLogin/JusLogin.h>

#import "mtc_api.h"
#import "mtc_conf.h" //注意mtc_conf.h 引入必须在mtc_api.h之后
#import "zmf_video.h"
#import "zmf_audio.h"
#import "mtc_user.h"

#define JusTalk_AuthAppKey "2f196808eb970afc3f635096" //senyint
//#define JusTalk_AuthAppKey "42b688581bfc14cae0765096" //ylTest


//菊风服务器地址（生产）
#define justalkIp @"sudp:ae.justalkcloud.com:9851"
// 测试服务器地址 @"sudp:dev.ae.justalkcloud.com:9851"

static JusTalkManager * _sharedManager = nil;

@interface JusTalkManager ()<MtcLoginDelegate>
{
    //会议信息
    NSString *_mtcConfNumber;
    NSString *_mtcConfUri;
    NSString *_mtcConfId;
    
    //自已信息
    NSString *_selfUri;
//    NSString *_selfName;
//    NSInteger _selfRoleId;
//    NSInteger _selfConfState;
    BOOL _isregisterJusTalkMeetingNotificationed;


}
@property (nonatomic , assign) BOOL isLogined;
@property (nonatomic , copy) NSString * justalkId;//菊风给的id
@property (nonatomic , copy) NSString * nonce;//菊风给的用于鉴权的随机码
@end
@implementation JusTalkManager
#pragma mark justlak初始化
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _sharedManager = nil;
}

+ (instancetype)sharedJusTalk
{
    if (!_sharedManager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _sharedManager = [[self alloc] init];
        });
    }
    return _sharedManager;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_sharedManager) {
            _sharedManager = [super allocWithZone:zone ];
            
        }
    });
    return _sharedManager;
}
- (instancetype)init
{
    if ((_sharedManager = [super init])) {

        
    }
    return _sharedManager;
}


- (void)jusTalkinitialize
{
    Zmf_AudioInitialize(NULL);
    Zmf_VideoInitialize(NULL);
    
    //sdk init  测试为阻塞式
    ZINT res = Mtc_Init(JusTalk_AuthAppKey);
    if ( res == ZOK) {
        NSLog(@"菊风初始化成功");
        [MtcLoginManager Init];
        if (self.justalkinitializeOkBlock) {
            self.justalkinitializeOkBlock();
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(justalkinitializeOk)]) {
            [self.delegate justalkinitializeOk];
        }
        
    } else {
        if (self.justalkinitializeFailBlock) {
            self.justalkinitializeFailBlock(@"菊风初始化失败");
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(justalkinitializeFail:)]) {
            [self.delegate justalkinitializeFail:res];
        }
        NSLog(@"菊风初始化失败");
    }
}
#pragma mark end=========================================================================


#pragma mark justalk login & logout
- (void)loginJustalkToRSAWithUserName:(NSString *)user PassWord:(NSString *)pd
{
    NSLog(@"登录%@=%@==",user,pd);
    
    [MtcLoginManager Set:_sharedManager];
    /*
     user: 账号，可以是客户账号系统下的账号，账号中不能包含 @ 和 : 字符，不能以 _ 开头
     password: 账号密码必须是6位字符
     server: 登录服务器接入地址
     **/
    //RSA鉴权登录方式(OC)
    ZINT ret = [MtcLoginManager Login:user password:pd server:justalkIp];
    if (ret == ZOK) {
        NSLog(@"jusTalk 登陆发出成功");
    }else{
        if (self.delegate && [self.delegate respondsToSelector:@selector(justalkSendLoginFile:)]) {
            [self.delegate justalkSendLoginFile:ret];
        }
        NSLog(@"jusTalk 登陆发出失败===%d",ret);

    }
    return;
    
    /********登录方式(C)**账号密码必须是0*********/
    NSDictionary *dict = @{@MtcServerAddressKey : justalkIp, @MtcPasswordKey : @"0"};
    ZINT  ret2 = Mtc_Login([user UTF8String], dict);
    if (ret2 == ZOK) {
        NSLog(@"jusTalk 登陆发出成功");
    }else{
        NSLog(@"jusTalk 登陆发出失败");
        
    }


}

//退出菊风登录
- (void)logoutFromJustalk
{
    [MtcLoginManager Logout];
}

#pragma mark MtcLoginDelegate
- (void)loginOk
{
    self.isLogined = YES;
    if (self.justalkLoginOkBlock) {
        self.justalkLoginOkBlock();
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkLoginOk)]) {
        [self.delegate justalkLoginOk];
    }
    NSLog(@"%s登录成功**************",__func__);
}
- (void)loginFailed:(NSInteger)reason
{
    self.isLogined = NO;
    if (self.justalkLoginFailBlock) {
        self.justalkLoginFailBlock([NSString stringWithFormat:@"菊风登录=====%ld",reason]);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkLoginFail:)]) {
        [self.delegate justalkLoginFail:(ZINT)reason];
    }
    
    /*
     AccountExist = 0,
     AccountNotExist = 1,
     AuthCodeError = 2,
     AuthCodeExpired = 3,
     AuthBlocked = 4,
     UnknownReason = 5,
     */
    NSLog(@"%s登录失败**************%ld",__func__,reason);
}

- (void)didLogout
{
    self.isLogined = NO;
    if (self.justalkLogoutOkBlock) {
        self.justalkLogoutOkBlock();
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkLogoutOk)]) {
        [self.delegate justalkLogoutOk];
    }
    NSLog(@"%s退出登录**************",__func__);
}

//异地登录回调
- (void)logouted
{
    self.isLogined = NO;
    if (self.justalkLogoutedBlock) {
        self.justalkLogoutedBlock();
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkLogouted)]) {
        [self.delegate justalkLogouted];
    }
    
    NSLog(@"%s异地登录***********************",__func__);
}
- (void)authRequire:(NSString *)account withNonce:(NSString *)nonce
{
    NSLog(@"%s-%@-%@",__func__,account,nonce);
    NSString *url = @"http://192.168.20.161/v1/app/justalkcloud/sign";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"POST"; // 设置为POST请求
    request.timeoutInterval = 40;
    
    NSString *body = [NSString stringWithFormat:@"justcloud_id=%@&nonce=%@",account,nonce];
    request.HTTPBody = [body dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (data) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSLog(@"%@",dic);
            NSString *code = [[dic  objectForKey:@"content"] objectForKey:@"code"];
            [MtcLoginManager PromptAuthCode:code];
            
        }
    }];
    
}
- (void)queryLoginInfoOk:(NSString *)user
                  status:(NSString *)status
                    date:(NSDate *)date
                   brand:(NSString *)brand
                   model:(NSString *)model
                 version:(NSString *)version
              appVersion:(NSString *)appVersion
{
    NSLog(@"%s",__func__);
    
}
- (void)queryLoginInfoFailed:(NSInteger)reason
{
    NSLog(@"%s",__func__);
    
}

#pragma mark end ===============================================================


#pragma mark 会议相关
//创建并加入会议
- (void)creatAndjoinMeetingWithTitle:(NSString *)meetTitle
{
    if (self.isLogined) {
        if (!meetTitle) {
            meetTitle = @"ylTest";
        }
        const char *pcTitle = meetTitle.UTF8String;
        const char *pcPW = "123456";//密码必须传123456
        ZINT ret =  Mtc_ConfCreate(0, pcTitle, pcPW, 1);
        if (ret == ZOK) {
            if (!_isregisterJusTalkMeetingNotificationed) {
                [self registerJusTalkMeetingNotification];

            }
            NSLog(@"jusTalk发起创建会议请求成功");
            
        }else{
            
            NSLog(@"jusTalk发起创建会议请求失败");
            
        }
        
    } else {
        
        
        NSLog(@"非登录状态");
    }
    
    
    
}

//查询会议
- (void)queryMeetingWithroomid:(NSString *)roomid
{
    if (self.isLogined) {
        ZINT ret = Mtc_ConfQuery(0, [roomid intValue]);
        if (ret == ZOK) {
            NSLog(@"会议查询发出成功");
            if (!_isregisterJusTalkMeetingNotificationed) {
                [self registerJusTalkMeetingNotification];
                
            }
        }else{
            NSLog(@"会议发出失败");
        }
        
        
    } else {
        
        
        NSLog(@"非登录状态");
    }
    
}

//加入会议
- (void)joinMeetingWithConfUri:(NSString *)mtcUri
{
    
    ZUINT ret = Mtc_ConfJoin(mtcUri.UTF8String, 0);
    if (ret == ZMAXUINT) {
        NSLog(@"加入会议请求失败");
        
    } else {
        NSLog(@"加入会议请求成功");
        
    }
//    //123456固定
//    ZUINT ret = Mtc_ConfJoinEx(mtcUri.UTF8String, 0, @"18735108707".UTF8String, 0, [@"123456" UTF8String]);
//        if (ret == ZMAXUINT) {
//            NSLog(@"加入会议请求失败");
//    
//        } else {
//            NSLog(@"加入会议请求成功");
//    
//        }

}
//离开会议
- (void)leveMeetingWithMeetid:(ZUINT)confId;
{
    NSLog(@"%d",confId);
    ZINT res = Mtc_ConfLeave(confId);
    if (res == ZOK) {
        
    } else {
     
        NSLog(@"离开会议发出失败＝＝＝＝%d",res);
    }
        
}





#pragma mark 渲染相关
//打开音频采集和播放
- (BOOL)prepareAudioandopenResult:(void(^)(NSString* promptInformation))openAudio
{
    // 获取 AEC 的开关状态
    ZBOOL bAec = Mtc_MdmGetOsAec();
    const char *pcId = bAec ? ZmfAudioDeviceVoice : ZmfAudioDeviceRemote;
    // 获取 AGC 的开关状态
    ZBOOL bAgc = Mtc_MdmGetOsAgc();
    // 开启音频采集
    int ret = Zmf_AudioInputStart(pcId, 0, 0, bAec ? ZmfAecOn : ZmfAecOff, bAgc ? ZmfAgcOn : ZmfAgcOff);
    if (ret == 0) {
        NSLog(@"开启音频采集成功");
        // 开启音频播放
        ret = Zmf_AudioOutputStart(pcId, 0, 0);
        if (ret == 0) {
            if (openAudio) {
                openAudio(@"开启音频采集播放成功");
            }

            NSLog(@"开启音频播放成功");
            AVAudioSession * _audioSession = [AVAudioSession sharedInstance];
            AVAudioSessionRouteDescription *routeDescription = _audioSession.currentRoute;
            for (AVAudioSessionPortDescription *portDescription in routeDescription.outputs) {
                if ([portDescription.portType isEqualToString:AVAudioSessionPortHeadphones] || [portDescription.portType isEqualToString:AVAudioSessionPortBluetoothA2DP]) {
                    [_audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:NULL];//当前插入了耳机或蓝牙 用听筒输出
                } else {
                    [_audioSession overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:NULL];//设置扬声器输出  注意默认是听筒输出 而且提前设了可能不起作用

                    
                }
            }
            

            return YES;
        }
        else{
            if (openAudio) {
                openAudio(@"开启音频采集成功开启音频播放失败");

            }
            NSLog(@"开启音频播放失败");
            return NO;

        }

    } else {
        if (openAudio) {
            openAudio(@"开启音频采集失败");

        }
        NSLog(@"开启音频采集失败");
        return NO;

    }
    

}


//打开并关联摄像头
- (BOOL)prepareVideoWith:(BOOL)captureFront withmtcConfId:(NSString *)confId openResult:(resultBlock) openVideo
{
    if (!confId) {
        confId = _mtcConfId;
    }
    // 选择使用前置还是后置摄像头
    const char *pcCapture = captureFront? ZmfVideoCaptureFront : ZmfVideoCaptureBack;
    unsigned int iVideoCaptureWidth ;
    unsigned int iVideoCaptureHeight ;
    unsigned int iVideoCaptureFrameRate;
    
        
    // 设置 video 的大小和分辨率
    Mtc_MdmGetCaptureParms(&iVideoCaptureWidth, &iVideoCaptureHeight, &iVideoCaptureFrameRate);
    //    // 打开摄像头
    int ret = Zmf_VideoCaptureStart(pcCapture, iVideoCaptureWidth, iVideoCaptureHeight, iVideoCaptureFrameRate);
    if (ret == 0) {
        NSLog(@"打开摄像头成功");
        // 关联摄像头
        ZINT ret = Mtc_ConfSetVideoCapture([confId intValue], pcCapture);
        if (ret == ZOK) {
            NSLog(@"关联摄像头成功");
            if (openVideo) {
                openVideo(@"打开并关联摄像头成功");

            }
            return YES;
        } else {
            if (openVideo) {
                openVideo(@"打开摄像头成功关联失败");

            }
            NSLog(@"关联摄像头失败");
            return NO;
        }

        
    }
    else{
        NSLog(@"打开摄像头失败");
        if (openVideo) {
            openVideo(@"打开摄像头失败");

        }
        return NO;
    }


}

//渲染视频
- (void)renderinginView:(UIView *)view withParticipantModel:(ParticipantModel *)model resultBlock:(resultBlock)resrlt
{
    NSLog(@"%@",model);
    if (!view) {
        if (resrlt) {
            resrlt(@"请设置渲染的view");
        }
        return;
    }
    
    //注意MtcConfUserUriKey 自已是前置或后置摄像头 别人的是MtcConfUserUriKey的值
    const char *userUri = model.userUri.UTF8String;
    if (model.isSelf) {
       userUri =  ZmfVideoCaptureFront;
        if (model.isBack) {
            userUri = ZmfVideoCaptureBack;
        } else {
        
            userUri = ZmfVideoCaptureFront;
        }
        
        
        [self startSendvideoandAudioData:model.userUri];
        [self setSelfInfoWith:model];
    }
    
    //先command一下
    //command视频
    char videoJson[1024];
    sprintf(videoJson, "{\"MtcConfUserUriKey\" : \"%s\", \"MtcConfPictureSizeKey\" : %d, \"MtcConfFrameRateKey\" : %d}", userUri, model.picSize, model.frameRate);
    printf("videoJson: %s\n",videoJson);
    
    Mtc_ConfCommand([_mtcConfId intValue], MtcConfCmdRequestVideo, videoJson);
    

    //将视频(摄像头采集或url)渲染到指定view上
    Zmf_VideoRenderStart((__bridge void *)(view), ZmfRenderView);
    Zmf_VideoRenderAdd((__bridge void *)(view), userUri, 0, ZmfRenderFullScreen);
    
    
    if (model.isSelf) {
        //横屏状态下，需要使视频旋转270度方可正确角度显示
        Zmf_VideoRenderRotate((__bridge void *)(view),model.angle);
        

    }     
    
    
}

//停止渲染
- (void)stopRander:(UIView *)view
{
    
    Zmf_VideoRenderStop((__bridge void *)view);
    Zmf_VideoRenderRemoveAll((__bridge void *)view);
}

//旋转摄像头角度
- (void) videoRenderRotateWithParticipantModel:(ParticipantModel *)selfModel
{
    Zmf_VideoRenderRotate((__bridge void *)(selfModel.rendView),selfModel.angle);

}

//切换前后摄像头
- (void)changeCaptureSelfModel:(ParticipantModel *)model
{
    Zmf_VideoRenderReplace((__bridge void *)(model.rendView), model.isBack? ZmfVideoCaptureFront : ZmfVideoCaptureBack, model.isBack? ZmfVideoCaptureBack: ZmfVideoCaptureFront);
    Zmf_VideoCaptureStopAll();
    [self prepareVideoWith:!model.isBack withmtcConfId:_mtcConfId openResult:nil];
    
}

- (void)setSelfInfoWith:(ParticipantModel *)selfModel
{
    _selfUri = selfModel.userUri;
    
}



#pragma mark 数据传输
//开始发送数据
- (void)startSendvideoandAudioData:(NSString *)selfuri
{
    if (!selfuri) {
        selfuri = _selfUri;
    }
    ZINT ret = Mtc_ConfStartSend([_mtcConfId intValue], MTC_CONF_MEDIA_ALL);
    if (ret == ZOK) {
        NSLog(@"发送成功");
    }else{
        NSLog(@"发送失败");
    }
    
    Zmf_VideoCaptureEnableRotation(YES, 0);

    /*
     MtcConfMediaOptionKey  1音频 2视频 3所有
     MtcConfCmdStartForward 开始发送
     MtcConfCmdStopForward  停止发送
     **/
    char videoJson[1024];
    sprintf(videoJson, "{\"MtcConfUserUriKey\" : \"%s\", \"MtcConfMediaOptionKey\" : 1}", [selfuri UTF8String]);
    printf("videoJson: %s\n",videoJson);
    Mtc_ConfCommand([_mtcConfId intValue], MtcConfCmdStartForward , videoJson);
}

//切换静音 Yes 静音,不发送音频 NO 发送音频
- (void)changeMuteState:(BOOL) ismute
{
    NSLog(@"changeMuteState==%d",ismute);
    ZCHAR *cmd = MtcConfCmdStartForward;
    if (ismute) {
        cmd = MtcConfCmdStopForward;
    }
    char videoJson[1024];
    sprintf(videoJson, "{\"MtcConfUserUriKey\" : \"%s\", \"MtcConfMediaOptionKey\" : 1}", [_selfUri UTF8String]);
    printf("videoJson: %s\n",videoJson);
    Mtc_ConfCommand([_mtcConfId intValue], cmd, videoJson);
    
}


//停止数据采集 输出 发送
- (void)stopSendvideoandAudioData
{
    
    //停止发送
    ZINT ret = Mtc_ConfStopSend(_mtcConfId.intValue, MTC_CONF_MEDIA_ALL);
    if (ret == ZOK) {
        NSLog(@"停止发送成功");
    }else{
        NSLog(@"停止发送失败");
    }
    
    char videoJson[1024];
    sprintf(videoJson, "{\"MtcConfUserUriKey\" : \"%s\", \"MtcConfMediaOptionKey\" : 3}", [_selfUri UTF8String]);
    printf("videoJson: %s\n",videoJson);
    Mtc_ConfCommand([_mtcConfId intValue], MtcConfCmdStopForward , videoJson);

    Zmf_AudioInputStopAll();
    Zmf_AudioOutputStopAll();
    
    Zmf_VideoCaptureStopAll();

}



#pragma mark meetingNotification (测试所得 通知回调都在主线程中)
- (void)registerJusTalkMeetingNotification
{
    //创建会议成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfCreateOk:) name:@MtcConfCreateOkNotification object:nil];
    //创建会议失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfCreateDidFail:) name:@MtcConfCreateDidFailNotification object:nil];
    //会议属性变化事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfPropertyChanged:) name:@MtcConfPropertyChangedNotfication object:nil];
    //加入会议成功
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfJoinOk:) name:@MtcConfJoinOkNotification object:nil];
    //加入会议失败
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfJoinDidFail:) name:@MtcConfJoinDidFailNotification object:nil];
    //离开会议事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfDidLeave:) name:@MtcConfDidLeaveNotification object:nil];
    //
    //查询会议成功事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfQueryOk:) name:@MtcConfQueryOkNotification object:nil];
    //查询会议失败事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfQueryDidFail:) name:@MtcConfQueryDidFailNotification object:nil];
    //    //收到会议邀请事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(:) name:@MtcConfInviteReceivedNotification object:nil];
    //    //邀请发送成功事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(:) name:@MtcConfInviteOkNotification object:nil];
    //    //邀请发送失败事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(:) name:@MtcConfInviteDidFailNotification object:nil];
    //    //踢人请求发送成功事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(:) name:@MtcConfKickOkNotification object:nil];
    //    //踢人请求发送失败事件
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(:) name:@MtcConfKickDidFailNotification object:nil];
    //有成员加入会议事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfJoined:) name:@MtcConfJoinedNotification object:nil];
    //有成员离开会议事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfLeaved:) name:@MtcConfLeavedNotification object:nil];
    //成员状态变化事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfParticipantStateChanged:) name:@MtcConfParticipantChangedNotification object:nil];
    //成员音量变化事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfVolumeChanged:) name:@MtcConfVolumeChangedNotification object:nil];
    //会议错误事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mtcConfError:) name:@MtcConfErrorNotification object:nil];
    //监听耳机插入拔出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioSessionRouteChange:) name:AVAudioSessionRouteChangeNotification object:nil];
    _isregisterJusTalkMeetingNotificationed = YES;
}
- (void)mtcConfCreateOk:(NSNotification *)notInfo
{
    NSLog(@"会议创建成功");
    NSLog(@"%@",notInfo);
    
    NSString *roomid = [NSString stringWithFormat:@"%d",[notInfo.userInfo[@MtcConfNumberKey] intValue]];
    if (self.justalkCreateMeetingOkBlock) {
        self.justalkCreateMeetingOkBlock(roomid);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkCreateConferenceOk:)]) {
        [self.delegate justalkCreateConferenceOk:roomid];
    }

    [self joinMeetingWithConfUri:notInfo.userInfo[@MtcConfUriKey]];
}

- (void)mtcConfCreateDidFail:(NSNotification *)notInfo
{
    if (self.justalkCreateMeetingFailBlock) {
        self.justalkCreateMeetingFailBlock(@"会议创建失败");
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkCreateConferenceFail:)]) {
        [self.delegate justalkCreateConferenceFail:@"会议创建失败"];
    }
    NSLog(@"会议创建失败");
    NSLog(@"%@",notInfo);
    
}
- (void)mtcConfPropertyChanged:(NSNotification *)notInfo
{
    NSLog(@"会议属性发生变化");
    NSLog(@"%@",notInfo);
    
}

- (void)mtcConfQueryOk:(NSNotification *)notInfo
{
    NSLog(@"查询会议成功");
    NSLog(@"%@",notInfo);
//    [self joinMeetingWithConfUri:notInfo.userInfo[@MtcConfUriKey]];
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkQueryConferenceOk:)]) {
        [self.delegate justalkQueryConferenceOk:notInfo.userInfo];
    }
    
}
- (void)mtcConfQueryDidFail:(NSNotification *)notInfo
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkQueryConferenceFail:)]) {
        [self.delegate justalkQueryConferenceFail:[notInfo.userInfo objectForKey:@"MtcConfReasonKey"]];
    }
    

    NSLog(@"查询会议失败");
    NSLog(@"%@",notInfo);
    
}

- (void)mtcConfJoinOk:(NSNotification *)notInfo
{
    NSLog(@"自己加入会议成功");
    NSLog(@"%@",notInfo);
    _mtcConfId = notInfo.userInfo[@MtcConfIdKey];
    _mtcConfUri = notInfo.userInfo[@MtcConfUriKey];
    if (self.justalkJoinMeetingOkBlock) {
        self.justalkJoinMeetingOkBlock(notInfo.userInfo);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkJoinConferenceOk:)]) {
        [self.delegate justalkJoinConferenceOk:notInfo.userInfo];
    }
}



- (void)mtcConfJoinDidFail:(NSNotification *)notInfo
{
    
    NSLog(@"加入会议失败");
    NSLog(@"%@",notInfo);
    if (self.justalkJoinMeetingFailBlock) {
        self.justalkJoinMeetingFailBlock(@"加入会议失败");
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkJoinConferenceFail:)]) {
        [self.delegate justalkJoinConferenceFail:@"加入会议失败"];
    }

    
}

- (void)mtcConfDidLeave:(NSNotification *)notInfo
{
    NSLog(@"自己离开会议");
    NSLog(@"%@",notInfo);
    if (self.justalkDidLeaveMeetingBlock) {
        self.justalkDidLeaveMeetingBlock([notInfo.userInfo[@MtcConfReasonKey] intValue]);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkDidLeaveConference:)]) {
        [self.delegate justalkDidLeaveConference:[notInfo.userInfo[@MtcConfReasonKey] intValue]];
    }

}


- (void)mtcConfJoined:(NSNotification *)notInfo
{
    NSLog(@"有成员加入会议");
    NSLog(@"%@",notInfo);
    if (self.justalkOtherJoinMeetingBlock) {
        self.justalkOtherJoinMeetingBlock(notInfo.userInfo);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkOtherJoinConference:)]) {
        [self.delegate justalkOtherJoinConference:[notInfo userInfo]];
    }
}
- (void)mtcConfLeaved:(NSNotification *)notInfo
{
    NSLog(@"有成员离开会议");
    NSLog(@"%@",notInfo);
    NSMutableDictionary *userInfo = [[NSMutableDictionary alloc]initWithDictionary:notInfo.userInfo];
    
    [userInfo setObject:[NSString stringWithUTF8String:Mtc_UserGetId([notInfo.userInfo[@MtcConfUserUriKey] UTF8String])] forKey:@MtcConfDisplayNameKey];
    NSLog(@"%@",userInfo);

    if (self.justalkOtherLeaveMeetingBlock) {
        self.justalkOtherLeaveMeetingBlock(userInfo);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(justalkOtherLeaveConference:)]) {
        [self.delegate justalkOtherLeaveConference:userInfo];
    }
    
}
- (void)mtcConfParticipantStateChanged:(NSNotification *)notInfo
{
    NSLog(@"成员状态发生变化");
    NSLog(@"%@",notInfo);
    
}
- (void)mtcConfVolumeChanged:(NSNotification *)notInfo
{
//    NSLog(@"成员音量发生变化");
//    NSLog(@"%@",notInfo);
//    
}

- (void)mtcConfError:(NSNotification *)notInfo
{
    NSLog(@"会议错误事件");
    NSLog(@"%@",notInfo);
    
}


//监听声音输出设备改变
- (void)audioSessionRouteChange:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    AVAudioSessionRouteChangeReason changeReason = [userInfo[AVAudioSessionRouteChangeReasonKey] unsignedIntegerValue];
    
    if (changeReason == AVAudioSessionRouteChangeReasonNewDeviceAvailable) {
        //有耳机插入
        [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideNone error:NULL];
        
    }
    else if (changeReason==AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        
        AVAudioSessionRouteDescription *routeDescription = userInfo[AVAudioSessionRouteChangePreviousRouteKey];
        AVAudioSessionPortDescription *portDescription = [routeDescription.outputs firstObject];
        //原设备为耳机则
        if ([portDescription.portType isEqualToString:AVAudioSessionPortHeadphones]) {
            //改用扬声器
            [[AVAudioSession sharedInstance] overrideOutputAudioPort:AVAudioSessionPortOverrideSpeaker error:NULL];
        }
    }
}

@end
