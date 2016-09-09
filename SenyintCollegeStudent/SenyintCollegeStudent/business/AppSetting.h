//
//  AppSetting.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#ifndef AppSetting_h
#define AppSetting_h

#pragma mark 用户信息参数名宏定义
/**
 公共请求头字段
 */
#define USERINFO_Uid             @"uid"             // 登录之后服务器返回
#define USERINFO_Token           @"token"           // 登录之后服务器返回
#define USERINFO_Device_Id       @"device_id"       //设备唯一标识
#define USERINFO_App_Build_Code  @"app_build_code"  //创建编号 如110
#define USERINFO_App_version     @"app_version"      //版本号 如1.2.1
//参数值固定
#define K_REQUESTPUBLICPARAMETER_APPID_Value @"app_id" // 内部应用ID来源 1:IOS 2:Android
#define K_REQUESTPUBLICPARAMETER_Client @"client"      // 客户端参数	0学员端  1专家端区

/**
 本地存储
 */
#define USERINFO_PhoneNumber     @"user_Phone"         //用户手机号
#define USERINFO_Password        @"user_Password"      //用户密码
#define USERINFO_APN_Token        @"APN_Token"         //push token



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
