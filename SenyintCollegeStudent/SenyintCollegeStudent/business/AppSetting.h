//
//  AppSetting.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#ifndef AppSetting_h
#define AppSetting_h

#import "CommonMacroDefinition.h"
#import "GlobalSingle.h"
#import "SCProgressHUD.h"

#import "AFHTTPSessionManager.h"


#import "YLStringTool.h"



#define USERINFO_UID                     @"uid"             // x
#define USERINFO_TOKEN                   @"token"           // x
#define USERINFO_ROLE                    @"role"            //num x
#define USERINFO_USERNAME                @"userName"
#define USERINFO_REALNAME                @"realName"        //x
#define USERINFO_PHONENUM                @"phoneNum"
#define USERINFO_PASSWORD                @"password"
#define USERINFO_APNTOKEN                @"apn_token"

#define USERINFO_HEADIMAGEURL            @"headImageUrl"    //用户头像地址，
#define USERINFO_DEVICEID                @"deviceId"        //程序第一次启动时生成的标示设备的deviceID
#define USERINFO_BUILDCODE               @"buildCode"       //版本号  用于校验是否现实过桥页和是否创建deviceId
#define USERINFO_APPVERSION              @"appVersion"       //版本号 如1.2.1
#define USERINFO_IDFA                    @"idfa"            //广告标示符


#define K_REQUESTPUBLICPARAMETER_APPID @"app_id"
#define K_REQUESTPUBLICPARAMETER_DEVICEID @"device_id"
#define K_REQUESTPUBLICPARAMETER_APPID_VALUE @"1" //1:IOS 2:Android
#define K_REQUESTPUBLICPARAMETER_APPBUILDCODE @"appBuildCode"
#define K_REQUESTPUBLICPARAMETER_DEVICEINFO @"deviceInfo"
#define K_REQUESTPUBLICPARAMETER_CLIENT @"client" // 0学员端  1专家端区

/**
 * 获取验证码间隔最大时长
 */
#define GETINVALIDMAXINTERVAL 120

#define JoinConfCountDownTime  (15 * 60)


//宏文字
/**
 * 客服电话
 */
#define SCSERVER_TELEPHONE @"400-0000-000"

/**
 * emoji表情提示
 */
#define TINTMSG_FOR_CONTENT_ERROR                       @"暂不支持表情及特殊符号"

/**
 * 数据库版本
 */
#define INQUIRYCHAT_DATABASE_VERSION   @"1.0.0"

/**
 * 字典数据库维护版本号
 *
 */
#define DICTIONARY_DATABASE_VERSION   @"1.0.0"

#define collectionViewHeight 75 //视频直播界面底部的item的高
#define collectionViewWidth 135 //视频直播界面底部的item的宽


#endif
