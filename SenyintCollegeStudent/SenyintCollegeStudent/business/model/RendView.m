//
//  RendView.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/10.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "RendView.h"
#import "JusTalkManager.h"

@implementation RendView

- (void)dealloc
{
    NSLog(@"RendView==dealloc");
    [self stopRend];
    if (self.superview) {
        [self removeFromSuperview];
    }

}
- (void)startRend
{
    if (!self.isRended) {
        [[JusTalkManager sharedJusTalk] renderinginView:self withParticipantModel:self.model resultBlock:nil];
        _isRended = YES;
    }
}
- (void)stopRend
{
    if (self.isRended) {
        [[JusTalkManager sharedJusTalk] stopRander:self];
        
    }
     _isRended = NO;
}

- (void)updateRendViewSuperView:(UIView *)superView
{
    if (superView == self.superview) {
        return;
    } else {
        if (self.superview) {
            [self removeFromSuperview];
        }
        
        for (UIView *v in superView.subviews ) {
            if ([v isKindOfClass:[RendView class]]) {
                [v removeFromSuperview];
                
            }
        }
        [superView addSubview:self];
        self.frame = superView.bounds;
        [superView sendSubviewToBack:self];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self startRend];
        
    }
    
}

@end
