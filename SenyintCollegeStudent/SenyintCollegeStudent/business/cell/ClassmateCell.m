//
//  ClassmateCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "ClassmateCell.h"
#import "URLImageView.h"
#import "StudentView.h"
#import "GlobalSingle.h"
#import "NSString+Attribute.h"
#define TextColor  [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1]
@interface ClassmateCell ()
{
    __weak  UILabel *_countLabel;
    __weak  UIView *_studentView;


}
@end
@implementation ClassmateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubviews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self creatSubviews];
    
}

- (void)setStudents:(NSArray *)students
{
    _students = students;
    
    _countLabel.attributedText = [NSString getAttributedStringFromString:@"我的同学" Color:TextColor Fount:[UIFont systemFontOfSize:14] AndString:[NSString stringWithFormat:@"(%ld)人",students.count] Color:[UIColor colorWithRed:149/255.0f green:158/255.0f blue:159/255.0f alpha:1] Fount:[UIFont systemFontOfSize:14]];
    
}

#pragma mark view
- (void)creatSubviews
{
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor colorWithRed:214/255. green:237/255. blue:239/255. alpha:1];
    self.backgroundView = bg;
    
    UIImageView *iv1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    iv1.image = [UIImage imageNamed:@"home_myStudents"];
    iv1.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:iv1];

    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 200, 20)];
    l1.backgroundColor = [UIColor clearColor];
    l1.textColor = TextColor;
    l1.font = font;
    [self.contentView addSubview:l1];
    _countLabel = l1;
    _countLabel.text = @"我的同学";
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.bounds.size.width, 20)];
    v.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:v];
    _studentView = v;

}

- (void)updateStudent{
    if (!self.students || ![self.subviews count]) {
        for (UIView *v in _studentView.subviews) {
            [v removeFromSuperview];
        }
    } else {
        if (self.students.count >= _studentView.subviews.count) {
            for (int i = 0; i < self.students.count; i ++) {
                
                NSLog(@"%@",[NSString stringWithFormat:@"头像%d",(i + 1) % 8]);
                
                StudentView *sv;
                CGRect frame = CGRectMake(i % 4 * (self.bounds.size.width / 4), i / 4 * 90, self.bounds.size.width / 4, 90);
                if (i < _studentView.subviews.count) {
                    sv = [_studentView.subviews objectAtIndex:i];
                    sv.frame = frame;

                } else {
                    sv = [[StudentView alloc] initWithFrame:frame];
                    [_studentView addSubview:sv];
                }
                StudentModel *model = [self.students objectAtIndex:i];
                if (model.state) {
                    [sv.iv setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"头像%d",(i + 1) % 9 ? ((i + 1)  % 9 ): 4]]];
 
                } else {
                    sv.iv.image = [UIImage imageNamed:@"stu_offline"];
                }
                sv.nameL.text = model.user_name;
                sv.iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"头像%d",(i + 1) % 9 ? ((i + 1)  % 9 ): 4]] ;


            }
        } else {
            for (int i = 0; i < _studentView.subviews.count; i ++) {
                StudentView *sv = [_studentView.subviews objectAtIndex:i];
                if (i < self.students.count) {
                    StudentModel *model = [self.students objectAtIndex:i];
                    if (model.state) {
                        [sv.iv setImageWithURL:[NSURL URLWithString:model.head_image] placeholderImage:[UIImage imageNamed:[NSString stringWithFormat:@"头像%d",(i + 1) % 9 ? ((i + 1)  % 9 ): 4]]];
                        
                    } else {
                        sv.iv.image = [UIImage imageNamed:@"stu_offline"];
                    }
                    sv.nameL.text = model.user_name;
                    sv.frame = CGRectMake(i % 4 * (self.bounds.size.width / 4), i / 4 * 90, self.bounds.size.width / 4, 90);

                } else {
                   
                    [sv removeFromSuperview];
                }
                
                sv.iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"头像%d",(i + 1) % 9 ? ((i + 1)  % 9 ): 4]] ;
                
            }

        
        }
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateStudent];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
