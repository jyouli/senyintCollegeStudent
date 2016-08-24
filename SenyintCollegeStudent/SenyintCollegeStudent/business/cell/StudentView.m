//
//  studentView.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "StudentView.h"

@implementation StudentView
- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
   
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 60, 60)];
        [self addSubview:iv];
        self.iv = iv;
        self.iv.layer.masksToBounds = YES;
        self.iv.layer.cornerRadius = 30;
        self.iv.layer.borderColor = [[UIColor colorWithRed:214/255. green:237/255. blue:239/255. alpha:.9] CGColor];
        self.iv.layer.borderWidth = 2;
        
        
        UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(0, 65, frame.size.width, 25)];
        l.backgroundColor = [UIColor clearColor];
        [self addSubview:l];
        self.nameL = l;
        self.nameL.textColor = [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1];
        self.nameL.font = [UIFont systemFontOfSize:14];
        self.nameL.textAlignment = NSTextAlignmentCenter;
        
        iv.translatesAutoresizingMaskIntoConstraints = NO;
        l.translatesAutoresizingMaskIntoConstraints = NO;

        NSArray *hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_nameL]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_nameL)];
        [self addConstraints:hConstraints];
        
        NSArray *vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-Margin-[iv(==60)]-0-[l(==25)]" options:NSLayoutFormatAlignAllCenterX metrics:@{@"Margin":@5} views:@{@"iv":iv,@"l":_nameL}];
        
        NSArray *hConstraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[iv(==60)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(iv)];
        [self addConstraints:hConstraints2];

        [self addConstraints:vConstraints];
        
    }
    return self;
}

@end
