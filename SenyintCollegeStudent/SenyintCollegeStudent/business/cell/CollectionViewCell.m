//
//  CollectionViewCell.m
//  CollectionViewDemo
//
//  Created by    任亚丽 on 16/7/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "CollectionViewCell.h"
@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UILabel *expertL = [[UILabel alloc] initWithFrame:CGRectMake(120, - 10, 45, 20)];
    [self addSubview:expertL];

    expertL.backgroundColor = [UIColor orangeColor];
    expertL.textColor = [UIColor whiteColor];
    expertL.font = [UIFont systemFontOfSize:15];
    expertL.text = @"专家";
    expertL.layer.masksToBounds = YES;
    expertL.layer.cornerRadius = 10;
    expertL.hidden = YES;
    expertL.tag = 100;
    
    self.contentView.layer.borderWidth = 2;
    self.clipsToBounds = NO;
}

- (void)setModel:(ParticipantModel *)model
{
    _model = model;
    rendName.text = model.nickName;
    [model updateRendViewSuperView:self.contentView];
    UIView *v = [self viewWithTag:100];

    if (self.model.isExpert) {
        v.hidden = NO;
        self.contentView.layer.borderColor = [[UIColor colorWithRed:0/255. green: 138/255. blue:255/255. alpha:.9] CGColor];
    } else {
        
        v.hidden = YES;
        self.contentView.layer.borderColor = [[UIColor colorWithRed:0/255. green: 0/255. blue:0/255. alpha:.9] CGColor];
    }

}

- (void)layoutSubviews
{
    if (self.model.isExpert) {
        [self.superview bringSubviewToFront:self];

    } else {
        
    }
    NSLog(@"%@",self.superview.subviews);
}
@end
