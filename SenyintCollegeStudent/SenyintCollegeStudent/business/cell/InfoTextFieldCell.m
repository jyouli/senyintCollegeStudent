//
//  InfoTextFieldCell.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "InfoTextFieldCell.h"

@interface InfoTextFieldCell ()
{
    __weak UILabel *_infoLabel;
    __weak UITextField *_infoTextField;
}

@end
@implementation InfoTextFieldCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self creatSubviews];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatSubviews];
        
    }
    
    return self;
}


#pragma mark init
- (void)creatSubviews
{
    UILabel *label = [[UILabel alloc] init];
    [self.contentView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentLeft;
    _infoLabel = label;
    
    UITextField *tf  = [[UITextField alloc] init];
    [self.contentView addSubview:tf];
    tf.borderStyle = UITextBorderStyleNone;
    tf.textAlignment = NSTextAlignmentLeft;
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    tf.delegate = self;
    _infoTextField = tf;
    
    [self setSubviews];
}


- (void)setSubviews
{
    [self setView:self.infoLabel FrameToSuperviewWithLeft:10 Width:45 Top:0 Bottom:0];
    
    [self setView:self.infoTextField FrameToSuperviewWithLeft:60 Right:10 Top:0 Bottom:0];
    self.infoLabel.textColor = TextColor;
    self.infoLabel.font = TextFont;
    self.infoLabel.textAlignment = NSTextAlignmentLeft;
    
    self.infoTextField.textColor = TextColor;
    self.infoTextField.font = TextFont;
    self.infoTextField.textAlignment = NSTextAlignmentLeft;
    
}

- (void)setModel:(InfoTextFieldCellModel *)model
{
    _model = model;
    self.accessoryType = self.model.cellAccessoryType;
    self.selectionStyle = self.model.cellSelectionStyle;

    self.infoLabel.text = self.model.infoName;
    
    self.infoTextField.placeholder = self.model.textFieldPlaceholder;
    self.infoTextField.text = self.model.textFieldinfo;
    self.infoTextField.keyboardType = self.model.textFieldKeyboardType;
    self.infoTextField.returnKeyType = self.model.textFieldReturnKeyType;
    self.infoTextField.clearButtonMode = self.model.textFieldClearBtnMode;
    self.infoTextField.secureTextEntry = self.model.textFieldSecureTextEntry;
    self.infoTextField.enabled = self.model.textFieldEnabled;
    if (model.textFieldDelegate) {
        self.infoTextField.delegate = model.textFieldDelegate;
    }
    
}



- (void)setView:(UIView *)view FrameToSuperviewWithLeft:(CGFloat)left  Width:(CGFloat)width Top:(CGFloat)top Bottom:(CGFloat )bottom
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view(==width)]" options:0 metrics:@{@"left":@(left),@"width":@(width)} views:NSDictionaryOfVariableBindings(view)];
    [view.superview addConstraints:hConstraints];
    
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[iv]-bottom-|" options:NSLayoutFormatAlignAllCenterX metrics:@{@"top":@(top),@"bottom":@(bottom)} views:@{@"iv":view}];
    
    [view.superview addConstraints:vConstraints];
    
}


- (void)setView:(UIView *)view FrameToSuperviewWithLeft:(CGFloat)left  Right:(CGFloat)right Top:(CGFloat)top Bottom:(CGFloat )bottom
{
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-left-[view]-right-|" options:0 metrics:@{@"left":@(left),@"right":@(right)} views:NSDictionaryOfVariableBindings(view)];
    [view.superview addConstraints:hConstraints];
    
    NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-top-[iv]-bottom-|" options:NSLayoutFormatAlignAllCenterX metrics:@{@"top":@(top),@"bottom":@(bottom)} views:@{@"iv":view}];
    
    [view.superview addConstraints:vConstraints];
    
}
#pragma mark end

@end
