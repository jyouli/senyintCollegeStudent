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
#import "NetworkManager.h"


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



#pragma mark  UI规范
//正文距左距离
#define  BodyContent_FlexibleLeft   12

//颜色
//内页背景颜色
#define  View_bg_Color   COLOR_RGB_HEX(0xf0f0f0)
//Cell等背景颜色
#define  Cell_bg_Color   COLOR_RGB_HEX(0xffffff)
//导航栏背景颜色
#define  NavBar_bg_Color   COLOR_RGB_HEX(0x157082)
//阴影颜色
#define Shadow_Color  COLOR_RGB_HEX(0xcbcbcb)
//分隔线颜色
#define SeparationLine_Color  COLOR_RGB_HEX(0xf0f2f5)
//灰色
#define  Disabledgray_Color   COLOR_RGB_HEX(0xa9a9a9)

//文字颜色
//登录提交类按钮文字字体颜色
#define  SubmitButtonText_Font_Color  COLOR_RGB_HEX(0xffffff)
//导航栏上子控件字体颜色
#define  NavBarSonControl_Font_Color  COLOR_RGB_HEX(0xffffff)
//标题性文字字体颜色
#define  BodyContentTitle_Font_Color  COLOR_RGB_HEX(0x000000)
//提示性文字字体颜色
#define  BodyContentPlaceholderText_Font_Color  COLOR_RGB_HEX(0xa9a9a9)
//纯黑文字颜色
#define  BlackText_Font_Color  COLOR_RGB_HEX(0x000000)
//正文辅助性文字字体颜色
#define  BodyContentAuxiliaryText_Font_Color  COLOR_RGB_HEX(0x787878)
//正文重要性文字字体颜色
#define  BodyContentImportantText_Font_Color  COLOR_RGB_HEX(0x157082)
//价格字体颜色
#define  BodyContentPrice_Font_Color  COLOR_RGB_HEX(0xff3333)
//体验一下按钮字体颜色
#define  Experience_Font_Color  COLOR_RGB_HEX(0x089300)

//文字大小
//登录提交类按钮文字字体大小
#define  SubmitButtonText_Font_Size  [UIFont systemFontOfSize:18]
//导航栏上title字体大小
#define  NavBarTitle_Font_Size [UIFont boldSystemFontOfSize:17]
//导航栏上子控件字体大小
#define  NavBarSonControl_Font_Size [UIFont boldSystemFontOfSize:14]
//标题性文字字体大小
#define  BodyContentTitle_Font_Size [UIFont boldSystemFontOfSize:15]
////正文常规文字字体大小
//#define  BodyContentText_Font_Size  [UIFont systemFontOfSize:14]
//正文辅助文字字体大小
#define  BodyContentAuxiliaryText_Font_Size  [UIFont systemFontOfSize:12]
//输入框文字字体大小
#define  TextFieldInputText_Font_Size  [UIFont systemFontOfSize:15]
//登录相关输入框文字字体大小
#define  LoginTextFieldInputText_Font_Size  [UIFont systemFontOfSize:12]
//Infocell分类名称文字字体大小
#define  InfoNameText_Font_Size  [UIFont boldSystemFontOfSize:15]


#endif
