//
//  CourseCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "CourseCell.h"
#import "GlobalSingle.h"
@interface CourseCell ()
{
    __weak UIImageView *courseIv;
    __weak UIButton *duritionBtn;
    __weak UILabel *stateDateLabel;
    __weak UILabel *courseInfoLabel;

}
@property (nonatomic, weak) UIButton *moreBtn;

@end
@implementation CourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSubviews];
    }
    return self;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self creatSubviews];

}

- (void)creatSubviews
{
    UIView *bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor whiteColor];
    self.backgroundView = bg;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iv = [[UIImageView alloc] init];
    iv.image = [UIImage imageNamed:@"2"];
    iv.backgroundColor = [UIColor colorWithRed:135 / 255. green:185 / 255. blue:201 / 255. alpha:1];
    [self.contentView addSubview:iv];
    courseIv = iv;
    
    UIButton *btn1 = [[UIButton alloc] init];
    btn1.backgroundColor = [UIColor colorWithRed:20 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    [btn1 setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
    [btn1 setAttributedTitle:[[NSAttributedString alloc]initWithString:@" 直播时间" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:135 / 255. green:185 / 255. blue:201 / 255. alpha:1], NSForegroundColorAttributeName,[UIFont systemFontOfSize:13.5], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 7;
    [self.contentView addSubview:btn1];
    
    UIColor *fontColor = [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1];
    
    
    UILabel *l1 = [[UILabel alloc] init];
    l1.backgroundColor = [UIColor clearColor];
    l1.textColor = fontColor;
    l1.font = [UIFont systemFontOfSize:13.5];
    l1.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:l1];
    stateDateLabel = l1;
    
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setImage:[UIImage imageNamed:@"time"] forState:UIControlStateNormal];
    [btn2 setAttributedTitle:[[NSAttributedString alloc]initWithString:@"时长: 10: 25" attributes:[NSDictionary dictionaryWithObjectsAndKeys: fontColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:13.5], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [self addSubview:btn2];
    duritionBtn = btn2;
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.backgroundColor = [UIColor clearColor];
    l2.textColor = fontColor;
    l2.font = [UIFont systemFontOfSize:13.5];
    l2.textAlignment = NSTextAlignmentLeft;
    l2.numberOfLines = 0;
    [self.contentView addSubview:l2];
    courseInfoLabel = l2;
    
    UIButton *more = [[UIButton alloc] init];
    [self addSubview:more];
    _moreBtn = more;
    [_moreBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:@"更多简介" attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:11], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [_moreBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:@"收起更多" attributes:[NSDictionary dictionaryWithObjectsAndKeys:fontColor, NSForegroundColorAttributeName,[UIFont systemFontOfSize:11], NSFontAttributeName ,nil]] forState:UIControlStateSelected];
    [self.contentView addSubview:_moreBtn];
    [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];

    _moreBtn.selected = NO;
    
    btn1.tag = 100;
    btn2.tag = 200;
    
    
}

- (void)setCourse:(CourseModel *)course
{

    _course = course;
    courseIv.image = _course.courseImage;
    stateDateLabel.text = _course.courseStateDate;
    [duritionBtn setAttributedTitle:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@" 时长: %@",_course.courseDutationDate] attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1], NSForegroundColorAttributeName,[UIFont systemFontOfSize:13.5], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    courseInfoLabel.text = _course.courseIntroduction;
}

//此方法里边所有动画都 不执行
- (void)layoutSubviews
{
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float y = 0;

    courseIv.frame = CGRectMake(0, 0, width, 200);
    y += 200 + 12.5;
    UIView *v1 = [self viewWithTag:100];
    v1.frame = CGRectMake(15, y, 85, 25);
    stateDateLabel.frame = CGRectMake(110, y, 160, 25);
    duritionBtn.frame = CGRectMake(width - 100 , y, 90, 25);
    y += 30;//

    if (self.course.introductionSize.height <= 40) { //不大于两行
        _moreBtn.hidden = YES;
        y += 10;
        courseInfoLabel.frame = CGRectMake(15, y, width - 30, self.course.introductionSize.height + 5);
        y += self.course.introductionSize.height + 25;

    } else {
       
        _moreBtn.hidden = NO;
        _moreBtn.frame = CGRectMake(width - 60, y, 50, 20);
        y += 25;
        if (self.course.isShowMoreIntroduction) {
            courseInfoLabel.frame = CGRectMake(15, y, width - 30, self.course.introductionSize.height + 5);
            
        } else {
            
            courseInfoLabel.frame = CGRectMake(15, y, width - 30, 40);
            
        }
        _moreBtn.selected = self.course.isShowMoreIntroduction;
 
    }
    
}

- (void)moreBtnClick
{

    self.course.isShowMoreIntroduction = !self.course.isShowMoreIntroduction;
//    [self.tableview reloadRowsAtIndexPaths:@[[self.tableview indexPathForCell:self]] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableview reloadRowsAtIndexPaths:@[[self.tableview indexPathForCell:self]] withRowAnimation:UITableViewRowAnimationNone];



}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
