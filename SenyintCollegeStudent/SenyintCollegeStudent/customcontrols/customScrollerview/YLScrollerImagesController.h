//
//  YLScrollerImagesController.h
//  MingyiMedicalService
//
//  Created by  haole on 15-5-7.
//  Copyright (c) 2015年 haole. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 可滑动自动滚动图片控制器
 */
@interface YLScrollerImagesController : UIView<UIScrollViewDelegate>
{
    UIScrollView *_scrollerview;
    CGFloat scrollerviewX;
    CGFloat scrollerviewY;
    UIImageView *iv1;
    UIImageView *iv2;
    UIImageView *iv3;
    UIPageControl *pageController;
    UILabel *progessView; //展示当前图片是第几张或是用来展示图片名称等
    
    NSTimer *timer;
    
}
@property (nonatomic, strong)NSMutableArray *itemArray; //图片数组
@property (nonatomic, strong)NSMutableArray *imgTitleArray; //图片名称数组
@property (nonatomic, assign)NSInteger currIndex; //当前显示的图片在数组中的索引  从0开始
@property (nonatomic, assign)BOOL isImgUrl; //图片数组里边是图片还是图片链接标记
@property (nonatomic, assign)BOOL isAutomaticScroller; //是否添加定时自动滚动
@property (nonatomic, assign)BOOL isShowPageController; //是否展示pageController
@property (nonatomic, assign)BOOL isShowProgress;//是否展示当前图片是第几张（也可用来展示图片名称）
@property (nonatomic, assign)BOOL isTitle;//展示的是否是图片名称
@property (nonatomic, strong)UIImage *placeHolderImg;//图片占位图
@property (nonatomic, assign)BOOL canTouch;//是否添加图片点击事件
@property (nonatomic, strong)void (^ScrollerImageControllerClickBlock)(YLScrollerImagesController *imgController, NSUInteger);
@property (nonatomic, strong)void (^ScrollerImageControllerDidDeleteImageBlock)(YLScrollerImagesController *imgController, NSMutableArray *);


//加载/更新图片相关数据
- (void)reloadData;
- (void)deleteCurrentShwoImage;

//设置图片参数
- (void)setImageViewbackgroundColor:(UIColor *)backgroundColor;
- (void)setImageViewContentMode:(UIViewContentMode)contentMode;

- (void)setScrollerViewScrollEnabled:(BOOL)enable;

//设置pageController参数
- (void)setPageControllerFrame:(CGRect)frame;
- (void)setPageControllerHidden:(BOOL)hidden;
- (void)setPageControllerBackgroundCorlor:(UIColor *)backgroundColor;
- (void)setPageControllercurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor;
- (void)setPageControllerpageIndicatorTintColor:(UIColor *)pageIndicatorTintColor;
- (void)setPageControllerHidesForSinglePage:(BOOL)hidesForSinglePage;
- (void)setPageControllercanTouch:(BOOL)canTouchpageController;


//设置progessView参数
- (void)setprogessViewFrame:(CGRect)frame;
- (void)setprogessViewHidden:(BOOL)hidden;
- (void)setprogessViewBackgroundCorlor:(UIColor *)backgroundColor;
- (void)setprogessViewTextCorlor:(UIColor *)textColor;
- (void)setprogessViewTextAlignment:(NSTextAlignment )alignment;
- (void)setprogessViewNumberOfLines:(NSInteger )num;
- (void)setprogessViewFont:(UIFont *)font;


@end
