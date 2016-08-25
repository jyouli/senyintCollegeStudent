//
//  InfoTextFieldCell.h
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoTextFieldCellModel.h"
@interface InfoTextFieldCell : UITableViewCell<UITextFieldDelegate>

@property (weak, nonatomic,readonly)  UILabel *infoLabel;
@property (weak, nonatomic,readonly)  UITextField *infoTextField;

@property (nonatomic, strong) InfoTextFieldCellModel *model;
- (void)setView:(UIView *)view FrameToSuperviewWithLeft:(CGFloat)left  Width:(CGFloat)width Top:(CGFloat)top Bottom:(CGFloat )bottom;

- (void)setView:(UIView *)view FrameToSuperviewWithLeft:(CGFloat)left  Right:(CGFloat)right Top:(CGFloat)top Bottom:(CGFloat )bottom;



@end
