//
//  YLPresentPushViewController.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/7.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLPresentPushViewController : UIViewController
@property (nonatomic, strong, readonly) UINavigationController *ylNavigationController;

- (void)backBarButtenClick;
- (void)pushPresentViewController:(YLPresentPushViewController *)presentvc isWithNavigationController:(BOOL)hasNC Animated:(BOOL) isAnimated completion:(void (^)(void))completion;
- (void)popDismissViewControllerAnimated:(BOOL)isAnimated completion:(void (^)(void))completion;

@end
