//
//  YLScrollerImagesController.m
//  MingyiMedicalService
//
//  Created by  haole on 15-5-7.
//  Copyright (c) 2015年 haole. All rights reserved.
//

#import "YLScrollerImagesController.h"

#import "UIImageView+AFNetworking.h"


#define  TimeInterval  2
#define  PageControllerBottomMargin  50
@implementation YLScrollerImagesController

#pragma mark 初始化
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        scrollerviewX = self.bounds.size.width;
        scrollerviewY = self.bounds.size.height;
        
        if (!_scrollerview) {
            _scrollerview = [[UIScrollView alloc] initWithFrame:self.bounds];
            _scrollerview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            _scrollerview.backgroundColor = [UIColor blackColor];
            _scrollerview.delegate = self;
            _scrollerview.pagingEnabled = YES;
            _scrollerview.showsHorizontalScrollIndicator = NO;
            [self addSubview:_scrollerview];
            
            NSMutableArray *ivListArr = [NSMutableArray arrayWithCapacity:3];
            for (int i = 0; i < 3; i ++) {
                UIImageView *iv = [[UIImageView alloc] initWithFrame:self.bounds];
                iv.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                iv.backgroundColor = [UIColor blackColor];
                iv.contentMode = UIViewContentModeScaleAspectFit;
                [ivListArr addObject:iv];
                [_scrollerview addSubview:iv];
            }
            
            iv1 = [ivListArr objectAtIndex:0];
            iv2 = [ivListArr objectAtIndex:1];
            iv3 = [ivListArr objectAtIndex:2];
            
            
        }
        
        pageController = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrollerviewY - 50, scrollerviewX, 50)];
        pageController.autoresizingMask =  UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

        pageController.backgroundColor = [UIColor clearColor];
        pageController.currentPageIndicatorTintColor = [UIColor redColor];
        pageController.pageIndicatorTintColor = [UIColor whiteColor];
        [pageController addTarget:self action:@selector(pageControllerSelected) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:pageController];
        pageController.hidden = YES;
        
        progessView = [[UILabel alloc] initWithFrame:CGRectMake(0, scrollerviewY - PageControllerBottomMargin, scrollerviewX, PageControllerBottomMargin)];
        progessView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;

        progessView.backgroundColor = [UIColor clearColor];
        progessView.textColor = [UIColor whiteColor];
        progessView.textAlignment = NSTextAlignmentCenter;
        progessView.font = [UIFont boldSystemFontOfSize:15];
        [self addSubview:progessView];
        progessView.hidden = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollerImageControllerClick)];
        [_scrollerview addGestureRecognizer:tap];
        
        
    }
    
    return self;
}

- (void)setFrame:(CGRect)frame
{
    
    [super setFrame:frame];
    scrollerviewX = self.bounds.size.width;
    scrollerviewY = self.bounds.size.height;

}

//点击图片回调
- (void)scrollerImageControllerClick
{
    if (self.canTouch) {
        if (self.ScrollerImageControllerClickBlock) {
            self.ScrollerImageControllerClickBlock(self, _currIndex);
        }
    }
}

#pragma mark 设置图片参数
- (void)setImageViewbackgroundColor:(UIColor *)backgroundColor
{
    iv1.backgroundColor = backgroundColor;
    iv2.backgroundColor = backgroundColor;
    iv3.backgroundColor = backgroundColor;
    
    
}
- (void)setImageViewContentMode:(UIViewContentMode)contentMode
{
    iv1.contentMode = contentMode;
    iv2.contentMode = contentMode;
    iv3.contentMode = contentMode;
}

- (void)setScrollerViewScrollEnabled:(BOOL)enable
{
    _scrollerview.scrollEnabled = enable;
}


#pragma mark 设置PageController
- (void)setPageControllerFrame:(CGRect)frame
{
    pageController.frame = frame;
}
- (void)setPageControllerHidden:(BOOL)hidden
{
    pageController.hidden = hidden;
}

- (void)setPageControllerBackgroundCorlor:(UIColor *)backgroundColor
{
    pageController.backgroundColor = backgroundColor;
}
- (void)setPageControllercurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    pageController.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}
- (void)setPageControllerpageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    pageController.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setPageControllerHidesForSinglePage:(BOOL)hidesForSinglePage
{
    pageController.hidesForSinglePage = hidesForSinglePage;

}
- (void)setPageControllercanTouch:(BOOL)canTouchpageController
{
    pageController.userInteractionEnabled = canTouchpageController;
}



#pragma mark 设置progessView
- (void)setprogessViewFrame:(CGRect)frame
{
    progessView.frame = frame;
}
- (void)setprogessViewHidden:(BOOL)hidden
{
    progessView.hidden = hidden;
}
- (void)setprogessViewBackgroundCorlor:(UIColor *)backgroundColor
{
    progessView.backgroundColor = backgroundColor;
}
- (void)setprogessViewTextCorlor:(UIColor *)textColor
{
    progessView.textColor = textColor;
}
- (void)setprogessViewTextAlignment:(NSTextAlignment )alignment
{
    progessView.textAlignment = alignment;
}

- (void)setprogessViewNumberOfLines:(NSInteger )num
{
    progessView.numberOfLines = num;

}

- (void)setprogessViewFont:(UIFont *)font
{
    progessView.font = font;
}


#pragma mark 加载/更新图片相关数据
- (void)reloadData
{
    if (!_scrollerview || !pageController || !progessView) {
        return;
    }
    if (!scrollerviewX || !_itemArray.count) {
        return;
    }
    if (_itemArray.count == 1) {
        _scrollerview.scrollEnabled = NO;
        self.isAutomaticScroller = NO;
    } else {
        _scrollerview.scrollEnabled = YES;
    }

    if (self.isAutomaticScroller) {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:TimeInterval target:self selector:@selector(AutomaticScrollerImage) userInfo:nil repeats:YES];
        
    } else {
        if (timer) {
            [timer invalidate];
            timer = nil;
        }
    }
    
    if (_itemArray.count == 1) {
        _scrollerview.scrollEnabled = NO;
    } else {
        _scrollerview.scrollEnabled = YES;
    }
    _scrollerview.contentSize = CGSizeMake(scrollerviewX * (_itemArray.count + 2), scrollerviewY);
    [self setScrollContentWithPage:_currIndex];
    [_scrollerview setContentOffset:CGPointMake((_currIndex + 1) * scrollerviewX, 0)];
    
    if (self.isShowPageController) {
        pageController.hidden = NO;
        pageController.numberOfPages = _itemArray.count;
        pageController.currentPage = _currIndex;
    } else {
        pageController.hidden = YES;
    }
    
    if (self.isShowProgress) {
        progessView.hidden = NO;
        if (self.isTitle) {
            progessView.text = [_imgTitleArray objectAtIndex:_currIndex];

        } else {
            progessView.text = [NSString stringWithFormat:@"%d/%d",(unsigned)(_currIndex + 1),(unsigned)_itemArray.count];

        }
    } else {
        progessView.hidden = YES;
    }
    
}
- (void)deleteCurrentShwoImage
{

    [_itemArray removeObjectAtIndex:_currIndex];
    if (_currIndex == _itemArray.count) {
        _currIndex = 0;
    }
    
    if (_itemArray.count == 1) {
        _scrollerview.scrollEnabled = NO;
    } else {
        _scrollerview.scrollEnabled = YES;
    }
    _scrollerview.contentSize = CGSizeMake(scrollerviewX * (_itemArray.count + 2), scrollerviewY);
    [self setScrollContentWithPage:_currIndex];
    [_scrollerview setContentOffset:CGPointMake((_currIndex + 1) * scrollerviewX, 0)];
   
    if (self.isShowPageController) {
        pageController.currentPage = _currIndex;
    }
    
    if (self.isShowProgress) {
        if (self.isTitle) {
            progessView.text = [_imgTitleArray objectAtIndex:_currIndex];
            
        } else {
            progessView.text = [NSString stringWithFormat:@"%d/%d",(unsigned)(_currIndex + 1),(unsigned)_itemArray.count];
            
        }
    }
    
    if (self.ScrollerImageControllerDidDeleteImageBlock) {
        self.ScrollerImageControllerDidDeleteImageBlock(self, _itemArray);
    }
}

//设置当前页展示
- (void)setScrollContentWithPage:(NSInteger)page
{
    if (self.isImgUrl) {
        [iv2 setImageWithURL:[NSURL URLWithString:[_itemArray objectAtIndex:_currIndex]]  placeholderImage:self.placeHolderImg]; ;
        iv2.frame = CGRectMake((_currIndex + 1)% (_itemArray.count + 2) * scrollerviewX, 0, scrollerviewX, scrollerviewY);
        
        [iv1 setImageWithURL:[NSURL URLWithString:[_itemArray objectAtIndex:(_currIndex - 1 + _itemArray.count ) % _itemArray.count]]  placeholderImage:self.placeHolderImg]; ;
        iv1.frame = CGRectMake(_currIndex % (_itemArray.count + 2) * scrollerviewX, 0, scrollerviewX, scrollerviewY);
        
        [iv3 setImageWithURL:[NSURL URLWithString:[_itemArray objectAtIndex:(_currIndex + 1) % _itemArray.count]]  placeholderImage:self.placeHolderImg]; ;
        iv3.frame = CGRectMake((_currIndex + 1 + 1) % (_itemArray.count + 2) * scrollerviewX, 0, scrollerviewX, scrollerviewY);
        
    } else {
        iv2.image = [_itemArray objectAtIndex:_currIndex];
        iv2.frame = CGRectMake((_currIndex + 1)% (_itemArray.count + 2) * scrollerviewX, 0, scrollerviewX, scrollerviewY);
        
        iv1.image = [_itemArray objectAtIndex:(_currIndex - 1 + _itemArray.count ) % _itemArray.count];
        iv1.frame = CGRectMake(_currIndex % (_itemArray.count + 2) * scrollerviewX, 0, scrollerviewX, scrollerviewY);
        
        iv3.image = [_itemArray objectAtIndex:(_currIndex + 1) % _itemArray.count];
        iv3.frame = CGRectMake((_currIndex + 1 + 1) % (_itemArray.count + 2) * scrollerviewX, 0, scrollerviewX, scrollerviewY);
    }
    if (self.isTitle) {
        progessView.text = [_imgTitleArray objectAtIndex:_currIndex];
        
    } else {
        progessView.text = [NSString stringWithFormat:@"%d/%d",(unsigned)(_currIndex + 1),(unsigned)_itemArray.count];
        
    }

}

//定时自动滚动图片
- (void)AutomaticScrollerImage
{
    _scrollerview.userInteractionEnabled = NO;
    _scrollerview.scrollEnabled = NO;
    CGFloat x = _scrollerview.contentOffset.x;
    x += scrollerviewX;
    // 1. 计算页号
    NSInteger pageNo = x / scrollerviewX;
    if (pageNo == _itemArray.count + 1) {

        [UIView animateWithDuration:0.5 animations:^{
            [_scrollerview setContentOffset:CGPointMake(pageNo * scrollerviewX, 0)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                _currIndex = 0;
                pageController.currentPage = _currIndex;
                [self setScrollContentWithPage:_currIndex];
                [_scrollerview setContentOffset:CGPointMake((_currIndex + 1) * scrollerviewX, 0)];
                _scrollerview.userInteractionEnabled = YES;
                _scrollerview.scrollEnabled = YES;
            }
        }];

        
    } else {
        
        _currIndex = pageNo % (_itemArray.count + 1) - 1;
        pageController.currentPage = _currIndex;
        [self setScrollContentWithPage:_currIndex];
        [UIView animateWithDuration:0.5 animations:^{
            [_scrollerview setContentOffset:CGPointMake((_currIndex + 1) * scrollerviewX, 0)];
            
        } completion:^(BOOL finished) {
            if (finished) {
                _currIndex = 0;
                _scrollerview.userInteractionEnabled = YES;
                _scrollerview.scrollEnabled = YES;
            }

        }];

    }

}

//点击pageController切换图片
- (void)pageControllerSelected
{
    if (_currIndex == pageController.currentPage) {
        return;
    } else {
        _currIndex = pageController.currentPage;
        [_scrollerview setContentOffset:CGPointMake((_currIndex + 1) * scrollerviewX, 0)];
        [self setScrollContentWithPage:_currIndex];
        
    }

}

#pragma mark - 滚动视图代理方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        // 1. 计算页号
        NSInteger pageNo = scrollView.contentOffset.x / scrollView.bounds.size.width;
//        NSLog(@"pageNo=%d",pageNo);

        if (pageNo == _itemArray.count + 1) {
            _currIndex = 0;
            [scrollView setContentOffset:CGPointMake(scrollerviewX, 0)];
            
        } else if (pageNo == 0) {
            _currIndex = _itemArray.count - 1;
            [scrollView setContentOffset:CGPointMake((_currIndex + 1) * scrollerviewX, 0)];
            
        } else {
            
            _currIndex = pageNo % (_itemArray.count + 1) - 1;
            
        }
        
//        NSLog(@"pageNo=%d, current = %d",pageNo,_currIndex);
        pageController.currentPage = _currIndex;
        [self setScrollContentWithPage:_currIndex];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    [self scrollViewDidEndDragging:scrollView willDecelerate:NO];
}

- (void)dealloc
{
    _scrollerview.delegate = nil;
    _scrollerview = nil;

    if (self.itemArray) {
        [self.itemArray removeAllObjects];
        self.itemArray = nil;
    }
    
    if (self.imgTitleArray) {
        [self.imgTitleArray removeAllObjects];
        self.imgTitleArray = nil;
    }

    
    if (timer) {
        [timer invalidate];
        timer = nil;
    }
}
@end
