//
//  SCTitleModel.h
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCTitleModel : NSObject

@property (nonatomic , strong) NSString * severId;//该职称对应的服务器id
@property (nonatomic , strong) NSString * titleId;//id
@property (nonatomic , strong) NSString * name;//职称名字

/**
 设置参数
 */
- (void)setModel:(SCTitleModel *)model;
@end
