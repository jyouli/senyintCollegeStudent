//
//  RendView.h
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/10.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ParticipantModel;
@interface RendView : UIView
@property (atomic, assign,readonly) BOOL isRended;
@property (nonatomic,weak) ParticipantModel *model;
- (void)stopRend;
- (void)startRend;
- (void)updateRendViewSuperView:(UIView *)superView;
@end
