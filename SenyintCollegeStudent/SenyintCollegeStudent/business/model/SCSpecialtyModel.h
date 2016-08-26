//
//  SCSpecialtyModel.h
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCSpecialtyModel : NSObject

@property (nonatomic , strong) NSString * severId;//该科室对应的服务器id
@property (nonatomic , strong) NSString * pid;//父id 一级父id为0
@property (nonatomic , strong) NSString * specialtyId;//市id
@property (nonatomic , strong) NSString * name;//科室名字

@end
