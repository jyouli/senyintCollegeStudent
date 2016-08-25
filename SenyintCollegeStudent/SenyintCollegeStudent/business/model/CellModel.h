//
//  CellModel.h
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
/**
 定义选中cell的执行操作类型
 */
typedef NS_ENUM(NSInteger, YLSelectedCellJumpType) {
    YLSelectedCellJumpNone  = 0,  //选中cell不做任何事 （默认为0）
    YLSelectedCellJumpBlock = 1,  //选中cell后执行一段代码
    YLSelectedCellJumpPush  = 2,  //选中cell Push推出一个vc
    YLSelectedCellJumpPresent = 3,//选中cell Present出一个vc
    
} ;


@interface CellModel : NSObject
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType; //cell的AccessoryType 默认为None
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;//cell的SelectionStyle 默认为None

@property (nonatomic, copy) NSString *cellClassName;  //cell的ClassName字符串
@property (nonatomic, assign) YLSelectedCellJumpType jumpType; //选中cell的操作类型 默认为0
@property (nonatomic, copy) NSString *jumpVCClassName; //跳转的目标vc的ClassName字符串
@property (nonatomic, copy) void (^selectedCell)(void); //选中后的执行代码


@end
