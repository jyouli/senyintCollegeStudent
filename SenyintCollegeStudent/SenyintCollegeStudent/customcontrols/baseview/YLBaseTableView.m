//
//  YLBaseTableView.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLBaseTableView.h"
#define Device_Heihgt   [UIScreen mainScreen].bounds.size.height
#define Device_Width  [UIScreen mainScreen].bounds.size.width
#define SpaceWithkeyboard 50
@interface YLBaseTableView ()
{
//    BOOL _priorInsetSaved; //标记是否有保存自己的初始Inset
    UIEdgeInsets  _priorInset;//保存自己的初始Inset
    
    BOOL _priorOffsetSaved; //标记是否有保存自己的初始Inset
    CGPoint  _priorOffset;//保存自己的初始Inset
    
    BOOL _keyboardVisible;//标记当前键盘的显示状态
    CGRect _keyboardRect;//保存键盘的Rect
    __weak UIView *_firstResponder;//保存键盘的Rect
    
    __weak UIView *_bgTapView; //bgview上的点击事件
    __weak UITapGestureRecognizer *_selfTap; //self上的点击事件
    
}
@end

@implementation YLBaseTableView
- (void)dealloc
{
    NSLog(@"%@--%s",self,__func__);

    [self subViewsResignFirstResponder];

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeFromSuperview
{
//    NSLog(@"%@--%s",self.class,__func__);
    
    [self subViewsResignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [super removeFromSuperview];


}

- (void)willMoveToWindow:(UIWindow *)newWindow
{
//    NSLog(@"%@--%s---newWindow＝%@",self.class,__func__,newWindow);

    if ([newWindow isEqual:[NSNull null]] || newWindow == nil) {//从窗口上移除，没有在显示
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self subViewsResignFirstResponder];

        
    } else {  //添加到一个新窗口上显示
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        
        if (!self.canSelectedCell) {
            UITapGestureRecognizer *selfTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfTapClick)];
            [self addGestureRecognizer:selfTap];
            _selfTap = selfTap;
        } else {
            
            if (_selfTap) {
                [self removeGestureRecognizer:_selfTap];
                
            }
        }

    }
    
    [super willMoveToWindow:newWindow];
    
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    _priorInset = self.contentInset;
    if (CGSizeEqualToSize(self.contentSize, CGSizeZero)) {
        self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 1);
    }

}


- (void)setup
{
    if ( CGSizeEqualToSize(self.contentSize, CGSizeZero) ) {
        [super setContentSize:self.bounds.size];
    }
    
    //点击键盘消失 会触发不了cell的点击事件  把点击事件加在tableview的backgroundView上,但是可能被tableview上的其他控件截取 主要在self.canselectedCell＝yes 的情况下起作用
    UIView *v = [[UIView alloc] init];
    self.backgroundView = v;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(subViewsResignFirstResponder)];
    [v addGestureRecognizer:tap];
    _bgTapView = v;
    
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
 
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if ( !(self = [super initWithFrame:frame]) )
        return nil;
    [self setup];
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setup];
}


//调自已的[super initWithFrame:frame]的时候会调自已的setFrame:方法
//调viewController的self.view = view的时候默认会调view的setFrame:方法
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if ( CGSizeEqualToSize(self.contentSize, CGSizeZero) ) {
        [super setContentSize:frame.size];
    }
    [self contentInsetForKeyboard];
   
}

- (UIView *)backgroundView
{
    return _bgTapView;
}
- (void) setBaseTableViewContentInset:(UIEdgeInsets)contentInset
{
    
    self.contentInset = contentInset;
    _priorInset = self.contentInset;
}

//注意 此方法中更新self.contentInset与MJRefresh的框架冲突  MJRefresh会认为结束了更新
////tableview中此方法调的频率特别高 键盘出现或消失都会调
- (void)setContentSize:(CGSize)contentSize
{
    contentSize.width = MAX(contentSize.width, self.frame.size.width);
    contentSize.height = MAX(contentSize.height, self.frame.size.height);
    [super setContentSize:contentSize];
    
    [self contentInsetForKeyboard];
}


//键盘出现（测试键盘高度发生变化 切换textfide这两种情况也会调）
- (void)keyboardWillShow:(NSNotification*)notification
{
    
    _keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (CGRectEqualToRect(_keyboardRect, CGRectZero)) {
        _keyboardRect = [[notification.userInfo objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    }
    _keyboardVisible = YES;
    
    _firstResponder = [self findFirstResponderBeneathView:self];
    if ( !_firstResponder ) {//没有child view是first responder
        return;
    }
    
    //设置contentInset
    [self contentInsetForKeyboard];//不设contentInset话，一部分cell可能会被键盘挡着拉不上来

    //设置contentOffset
    //firstResponder最下边的点在窗口中的位置
    CGPoint point = [_firstResponder.superview convertPoint:CGPointMake(0, CGRectGetMaxY(_firstResponder.frame)) toView:[UIApplication sharedApplication].keyWindow];

    if ( Device_Heihgt - point.y - _keyboardRect.size.height > SpaceWithkeyboard) {

        return;
    
    } else {
        _priorOffsetSaved = YES;
        _priorOffset = self.contentOffset;
        CGPoint offset = self.contentOffset;
        offset.y += SpaceWithkeyboard - (Device_Heihgt - point.y - _keyboardRect.size.height);
        __weak typeof(self) safeSelf = self;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
        [UIView setAnimationDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
        safeSelf.contentOffset = offset;
        [UIView commitAnimations];
        
        
    }
    
    
}

- (void)keyboardWillHide:(NSNotification*)notification
{
    
    _keyboardVisible = NO;

    __weak typeof(self) safeSelf = self;
    [UIView animateWithDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
         if (_priorOffsetSaved) {
            safeSelf.contentOffset = _priorOffset;
        
         }
        
        if (!UIEdgeInsetsEqualToEdgeInsets(safeSelf.contentInset, _priorInset)) {
            safeSelf.contentInset = _priorInset;
        }
    } completion:^(BOOL finished) {
        if (finished) {
            _keyboardRect = CGRectZero;
            _priorOffsetSaved = NO;
            _priorOffset = CGPointZero;
            
        }
    }];
    
    
}


//返回view（自己）上面当前作为第一响应者的view
- (UIView*)findFirstResponderBeneathView:(UIView*)view
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
            return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result )
            return result;
    }
    return nil;
}

//获取并设置新的EdgeInsets
- (void)contentInsetForKeyboard
{
    
    UIEdgeInsets newInset = _priorInset;
    if (_keyboardVisible) {
        newInset.bottom += _keyboardRect.size.height;
    }
    
    if (!UIEdgeInsetsEqualToEdgeInsets(self.contentInset, newInset)) {
        self.contentInset = newInset;

    }
}


///*
//  注意直接在此处做点击键盘消失 会触发不了cell的点击事件
// **/
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self subViewsResignFirstResponder];
//}


- (void)selfTapClick
{
    [self subViewsResignFirstResponder];
}

//键盘消失
- (void)subViewsResignFirstResponder
{
    if (_firstResponder) {
        [_firstResponder resignFirstResponder];
        _firstResponder = nil;
    } else {
        if (_keyboardVisible) {
            [self endEditing:YES];
        }
        
    }

}
@end
