//
//  YLBaseView.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/2.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLBaseView.h"
#define Device_Heihgt   [UIScreen mainScreen].bounds.size.height
#define Device_Width  [UIScreen mainScreen].bounds.size.width
#define SpaceWithkeyboard 50
@interface YLBaseView ()
{
    BOOL _priorInsetSaved; //标记是否有保存自己的初始Inset
    UIEdgeInsets  _priorInset;//保存自己的初始Inset
    
    BOOL _priorOffsetSaved; //标记是否有保存自己的初始Inset
    CGPoint  _priorOffset;//保存自己的初始Inset

    BOOL _keyboardVisible;//标记当前键盘的显示状态
    CGRect _keyboardRect;//保存键盘的Rect
    __weak UIView *_firstResponder;//保存键盘的Rect


}
@end

@implementation YLBaseView
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//默认第一次显示出来的时候调用（比较迟调用） 测试不主动的调的话就调一次
- (void)drawRect:(CGRect)rect 
{
    [super drawRect:rect];
    if (CGSizeEqualToSize(self.contentSize, CGSizeZero)) {
        self.contentSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height + 1);
    }
}

- (void)setup
{
    if ( CGSizeEqualToSize(self.contentSize, CGSizeZero) ) {
        [super setContentSize:self.bounds.size];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
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
    if ( _keyboardVisible ) {
        self.contentInset = [self contentInsetForKeyboard];
    }
}


- (void)setContentSize:(CGSize)contentSize
{
    NSLog(@"setContentSize");
    contentSize.width = MAX(contentSize.width, self.frame.size.width);
    contentSize.height = MAX(contentSize.height, self.frame.size.height);
    [super setContentSize:contentSize];
    
    if ( _keyboardVisible ) {
        self.contentInset = [self contentInsetForKeyboard];
    }
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
    

    
    //firstResponder最下边的点在窗口中的位置
    CGPoint point = [_firstResponder.superview convertPoint:CGPointMake(0, CGRectGetMaxY(_firstResponder.frame)) toView:[UIApplication sharedApplication].keyWindow];
    if ( Device_Heihgt - point.y - _keyboardRect.size.height > SpaceWithkeyboard) {
        _priorOffsetSaved = YES;
        _priorOffset = self.contentOffset;
        return;
    } else {
      
        if (!_priorInsetSaved) {
            _priorInset = self.contentInset;
            _priorInsetSaved = YES;
        }

        
        _priorOffsetSaved = YES;
        _priorOffset = self.contentOffset;
        CGPoint offset = self.contentOffset;
        offset.y += SpaceWithkeyboard - (Device_Heihgt - point.y - _keyboardRect.size.height);
        
        self.contentInset = [self contentInsetForKeyboard];

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

    __weak typeof(self) safeSelf = self;
    [UIView animateWithDuration:[[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        [UIView setAnimationCurve:[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
        if (_priorOffsetSaved) {
            safeSelf.contentOffset = _priorOffset;

        }
        if (_priorInsetSaved) {
            safeSelf.contentInset = _priorInset;

        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            _keyboardRect = CGRectZero;
            _keyboardVisible = NO;
            _priorInsetSaved = NO;
            _priorInset = UIEdgeInsetsZero;
            _priorOffset = CGPointZero;
            _priorOffsetSaved = NO;

            
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

//获取新的EdgeInsets
- (UIEdgeInsets)contentInsetForKeyboard
{
    
    UIEdgeInsets newInset = _priorInset;
    if (!_priorOffsetSaved) {
        newInset = self.contentInset;
    }
    newInset.bottom += _keyboardRect.size.height;
    return newInset;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (_firstResponder) {
        [_firstResponder resignFirstResponder];
        _firstResponder = nil;
    }
}

@end
