//
//  YLPresentPushViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "YLPresentPushViewController.h"
#import "BaseNavigationController.h"

#define PresentPushAnimateDuration 0.25
@interface YLPresentPushViewController ()
@property (nonatomic, weak) YLPresentPushViewController *ylPresentingViewController;
@property (nonatomic, strong) YLPresentPushViewController *ylPrestenedViewController;
@property (nonatomic, strong) UINavigationController *ylNavigationController;
@property (atomic, assign) BOOL isPushingorPoping; //Yes 表示正在自定义推出（规避重复操作） 默认为NO
@property (atomic, assign) BOOL usedCustomPush;//Yes 表示使用自定义推出  NO表示系统push 默认为NO


@end

@implementation YLPresentPushViewController
- (void)dealloc
{
    NSLog(@"%@ %s",[self class],__func__);
    
}
- (void)backBarButtenClick
{
    if (self.usedCustomPush) {
        [self popDismissViewControllerAnimated:YES completion:nil];
    } else {
        if (self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
            
        } else {
            
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

- (void)pushPresentViewController:(YLPresentPushViewController *)presentvc isWithNavigationController:(BOOL)hasNC Animated:(BOOL) isAnimated completion:(void (^)(void))completion
{
    
    if (self.isPushingorPoping) {
        return;
    }
    self.isPushingorPoping = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    presentvc.ylPresentingViewController = self;
    presentvc.usedCustomPush = YES;
    self.ylPrestenedViewController = presentvc;
    
    UIViewController *vc = presentvc;
    if (hasNC) {
        BaseNavigationController *nc = [[BaseNavigationController alloc] initWithRootViewController:presentvc];
        self.ylPrestenedViewController.ylNavigationController = nc;
        vc = nc;
    }
    
    CGRect frame = vc.view.frame;
    frame.origin.x = frame.size.width;
    vc.view.frame = frame;
    [window addSubview:vc.view];
    
    //如果没有对象强引用YLNavigationController YLNavigationController的view还在 但是YLNavigationController已经释放了YLNavigationController的RootViewController并没有引用YLNavigationController。本来也应该是不强引用的 因为YLNavigationController肯定要强引用它的RootViewController。如果都强引用的话RootViewController也强引用YLNavigationController的话 就循环引用了
    
    if (isAnimated) {
        
        __unsafe_unretained typeof(window) safeWindow = window;
        __unsafe_unretained typeof(vc) safeVC = vc;
        __unsafe_unretained typeof(self) safeSelf = self;
        
        
        frame.origin.x = 0;
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView animateWithDuration:PresentPushAnimateDuration animations:^{
            
            safeVC.view.frame = frame;
        } completion:^(BOOL finished) {
            
            if (finished) {
                [safeWindow.rootViewController.view removeFromSuperview];
                safeSelf.isPushingorPoping = NO;
                if (completion) {
                    completion();
                }
            }
            
        }];
        
    } else {
        vc.view.frame = frame;
        [window.rootViewController.view removeFromSuperview];
        if (completion) {
            completion();
        }
        self.isPushingorPoping = NO;
        
    }
    
    
    
}


- (void)popDismissViewControllerAnimated:(BOOL)isAnimated completion:(void (^)(void))completion
{
    if (self.isPushingorPoping) {
        return;
    }
    self.isPushingorPoping = YES;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = self;
    if (self.ylNavigationController) {
        vc = self.ylNavigationController;
    }
    //    __unsafe_unretained typeof(window) safeWindow = window;
    __unsafe_unretained typeof(vc) safeVC = vc;
    __unsafe_unretained typeof(self) safeSelf = self;
    
    CGRect frame = vc.view.frame;
    frame.origin.x = frame.size.width;
    [window addSubview:window.rootViewController.view];
    [window sendSubviewToBack:window.rootViewController.view];
    
    if (isAnimated) {
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView animateWithDuration:PresentPushAnimateDuration animations:^{
            
            safeVC.view.frame = frame;
        } completion:^(BOOL finished) {
            
            if (finished) {
                [safeVC.view removeFromSuperview];
                if (completion) {
                    completion();
                    
                }
                safeSelf.isPushingorPoping = NO;
                [safeSelf removeFromParentViewController];
                
                if (safeSelf.ylNavigationController) {
                    //                注意这里不能用safeSelf.navigationController判断
                    safeSelf.ylNavigationController = nil;
                }
                safeSelf.ylPresentingViewController.ylPrestenedViewController = nil;
                
            }
            
        }];
        
    } else {
        
        if (completion) {
            completion();
        }
        self.view.frame = frame;
        [vc.view removeFromSuperview];
        self.isPushingorPoping = NO;
    }
}

@end
