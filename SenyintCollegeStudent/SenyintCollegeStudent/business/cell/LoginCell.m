//
//  LoginCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LoginCell.h"

@interface LoginCell ()

@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, weak) UIImageView *icon;
@end
@implementation LoginCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 50, 45)];
//        iv.backgroundColor = [UIColor colorWithRed:224/255. green:224/255. blue:224/255. alpha:1];
        iv.contentMode = UIViewContentModeCenter;
        iv.image = [UIImage imageNamed:@"phoneIcon"];
        UITextField *tf = [[UITextField alloc] init];
        tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        tf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.leftView = iv;
        tf.borderStyle = UITextBorderStyleNone;
        tf.layer.masksToBounds = YES;
        tf.layer.cornerRadius = 5;
        tf.layer.borderWidth = 1;
        tf.layer.borderColor = [[UIColor colorWithRed:236/255. green:236/255. blue:236/255. alpha:1] CGColor];
        tf.returnKeyType = UIReturnKeyDone;
//        [self.contentView addSubview:iv];
        [self.contentView addSubview:tf];
        self.tf = tf;
        self.icon = iv;
                
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.tf.frame = CGRectMake(50, 15, self.bounds.size.width - 100 , self.bounds.size.height - 30);
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
