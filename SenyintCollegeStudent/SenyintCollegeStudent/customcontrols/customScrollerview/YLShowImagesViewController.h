//
//  YLShowImagesViewController.h
//  MingyiMedicalService
//
//  Created by  haole on 15/6/16.
//  Copyright (c) 2015年 haole. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface YLShowImagesViewController : UIViewController

@property (nonatomic, strong) NSMutableArray *imgArray;
@property (nonatomic, assign)NSInteger currIndex; //当前显示的数在数组中的索引  从0开始

@property (nonatomic, assign)BOOL isImgUrl; //图片数组里边是图片还是图片链接标记
@property (nonatomic, assign)BOOL isAutomaticScroller; //是否添加定时自动滚动
@property (nonatomic, assign)BOOL isShowPageController; //是否展示pageController
@property (nonatomic, assign)BOOL isShowProgress;//是否展示当前图片是第几张（也可用来展示图片名称）
@property (nonatomic, assign)BOOL isTitle;//展示的是图片名称
@property (nonatomic, strong)UIImage *placeHolderImg;//图片占位图
@property (nonatomic, assign)BOOL canTouch;//是否添加图片点击事件

@property (nonatomic, strong) void (^YLShowImagesViewControllerDidFinishDeleateImageBlock)(NSMutableArray *);//删除图片成功

@end
