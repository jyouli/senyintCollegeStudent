//
//  TeacherCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/4.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "TeacherCell.h"
#import "URLImageView.h"
#import "GlobalSingle.h"
#import "NSString+Attribute.h"
#import "NSString+Size.h"

#define TextColor  [UIColor colorWithRed:180/255.0f green:180/255.0f blue:180/255.0f alpha:1]
@interface TeacherCell ()
{
    __weak  UIImageView *_headerIv;
    __weak  UILabel *_nameLabel;
    __weak  UILabel *_titleLabel;
    __weak  UILabel *_hosLabel;
    __weak UILabel *_summaryLabel;
    __weak UIButton *_moreBtn;
    __weak UIView *_tagView;
    
    NSArray *taps;
    
}

@end
@implementation TeacherCell
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

    UIFont *font = [UIFont systemFontOfSize:14];
    
    UIView *bg1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 160)];
    bg1.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    bg1.backgroundColor = [UIColor colorWithRed:214/255. green:237/255. blue:239/255. alpha:1];
    [self.contentView addSubview:bg1];

    UIImageView *iv1 = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 20, 20)];
    iv1.contentMode = UIViewContentModeCenter;
    iv1.image = [UIImage imageNamed:@"teachericon"];
    [self.contentView addSubview:iv1];
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 15, 100, 20)];
    l1.backgroundColor = [UIColor clearColor];
    l1.textColor = TextColor;
    l1.font = font;
    l1.text = @"我的老师";
    [self.contentView addSubview:l1];
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 90, 90)];
    [self.contentView addSubview:iv];
    _headerIv = iv;
    _headerIv.layer.masksToBounds = YES;
    _headerIv.layer.cornerRadius = 45;
    _headerIv.layer.borderColor = [[UIColor colorWithRed:214/255. green:237/255. blue:239/255. alpha:.9] CGColor];
    _headerIv.layer.borderWidth = 2;
    
    UILabel *l5 = [[UILabel alloc] init];
    l5.backgroundColor = [UIColor orangeColor];
    l5.textColor = [UIColor whiteColor];
    l5.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:l5];
    _nameLabel = l5;
    _nameLabel.layer.masksToBounds = YES;
    _nameLabel.layer.cornerRadius = 15;
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *l2 = [[UILabel alloc] init];
    l2.backgroundColor = [UIColor clearColor];
    l2.textColor = TextColor;
    l2.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:l2];
    _titleLabel = l2;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *l3 = [[UILabel alloc] init];
    l3.backgroundColor = [UIColor clearColor];
    l3.textColor = TextColor;
    l3.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:l3];
    _hosLabel = l3;
    _hosLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    
    UILabel *l4 = [[UILabel alloc] init];
    l4.backgroundColor = [UIColor clearColor];
    l4.textColor = TextColor;
    l4.font = font;
    [self.contentView addSubview:l4];
    _summaryLabel = l4;
    _summaryLabel.numberOfLines = 0;
    
    
    UIButton *more = [[UIButton alloc] init];
    [self addSubview:more];
    _moreBtn = more;
    _moreBtn.backgroundColor = [UIColor whiteColor];
    [_moreBtn setAttributedTitle:[NSString getAttributedStringFromString:@"... " Color:TextColor Fount:[UIFont systemFontOfSize:14] AndString:@"[更多简介]" Color:[UIColor colorWithRed:183/255. green:211/255. blue:216/255. alpha:1] Fount:[UIFont systemFontOfSize:14]] forState:UIControlStateNormal];
    [_moreBtn setAttributedTitle:[NSString getAttributedStringFromString:@"[收起]" Color:[UIColor colorWithRed:183/255. green:211/255. blue:216/255. alpha:1] Fount:[UIFont systemFontOfSize:14]] forState:UIControlStateSelected];
    [_moreBtn addTarget:self action:@selector(moreBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreBtn];
    
}

- (void)setTeacherInfo:(TeacherModel *)teacherInfo
{
    _teacherInfo = teacherInfo;
    [_headerIv setImageWithURL:[NSURL URLWithString:teacherInfo.teacher_head_image]  placeholderImage:[UIImage imageNamed:@"expertHead"]];
    _nameLabel.text = teacherInfo.teacher_user_name;
    _titleLabel.text = teacherInfo.teacher_title;
    _hosLabel.text = teacherInfo.teacher_hos;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:self.teacherInfo.introductionAttributes];
    [attributes setObject:TextColor forKey:NSForegroundColorAttributeName];
    
    if ([self.teacherInfo.teacher_summary length]) {
        NSAttributedString *attstr = [[NSAttributedString alloc] initWithString:self.teacherInfo.teacher_summary attributes:attributes];
        _summaryLabel.attributedText = attstr;
    }
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    float width = self.bounds.size.width;
    float spaceleft = 15;
    
    _headerIv.frame = CGRectMake(0, 0, 90, 90);
    _headerIv.center = CGPointMake(self.center.x, 95);
    
    CGSize size1 = [_teacherInfo.teacher_user_name stringSizeWithFont:[UIFont systemFontOfSize:16] andConstrainedToSize:CGSizeMake(width - 20, CGFLOAT_MAX)];
    size1.width += 30;
    _nameLabel.frame = CGRectMake(width / 2 - size1.width /2 , 145, size1.width, 30);
    _titleLabel.frame = CGRectMake(spaceleft, 180, width - spaceleft * 2, 20);
    _hosLabel.frame = CGRectMake(spaceleft, 200, width - spaceleft * 2, 20);
    float y = 240 + [self creatTapsView:spaceleft] + 15;
    if (self.teacherInfo.introductionSize.height < 14 * 1.2 * 2 + 5) {
        _moreBtn.hidden = YES;
        _summaryLabel.frame = CGRectMake(spaceleft, y, width - spaceleft * 2, self.teacherInfo.introductionSize.height);
        y += self.teacherInfo.introductionSize.height + 5;
        

        
    } else {
        _moreBtn.hidden = NO;
        _moreBtn.selected = self.teacherInfo.isShowMoreIntroduction;
        NSDictionary *attrDic = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        if (self.teacherInfo.isShowMoreIntroduction) {
            _summaryLabel.frame = CGRectMake(spaceleft, y, width - spaceleft * 2, self.teacherInfo.introductionSize.height);
            y += self.teacherInfo.introductionSize.height + 5;
            CGSize size = [NSString attributesStringSizeWith:@"[收起]" andAttributes:attrDic andConstrainedToSize:CGSizeMake(width - 30, CGFLOAT_MAX)];
            _moreBtn.frame = CGRectMake(width - spaceleft * 2 - size.width, y - 5 - 14 * 1.12 - (31 - 14 * 1.12)/2, size.width + 10, 30);

        } else {
        
            _summaryLabel.frame = CGRectMake(spaceleft, y, width - spaceleft * 2, 14 * 1.2 * 2 + 5);
            CGSize size = [NSString attributesStringSizeWith:@"... [更多介绍]" andAttributes:attrDic andConstrainedToSize:CGSizeMake(width - 30, CGFLOAT_MAX)];
            _moreBtn.frame = CGRectMake(width - spaceleft * 2 - size.width, y + (14 * 1.2 * 2 + 5 - 30)/2 + 10, size.width + 10, 30);
        }
        
    }
    
}

- (float)creatTapsView:(float)spaceleft {

    [_tagView removeFromSuperview];
    if (!self.teacherInfo.tags) {
        return 0;
    }
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(spaceleft, 240, self.bounds.size.width - spaceleft * 2, 20)];
    v.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:v];
    _tagView = v;
    float spaceH = 10;
    float spaceV = 5;
    float wmin = 60;
    float wmax = _tagView.bounds.size.width;
    float h = 25;
    float x = 0;
    float y = 0;
    UIFont *font = [UIFont systemFontOfSize:13];
    BOOL isNeedAdd25 = NO;
    for (NSString *str in self.teacherInfo.tags) {
        if (!str || ![str length] || [str isEqual:[NSNull null]]) {
            continue;
        } else {
            UILabel *l = [[UILabel alloc] init];
            [_tagView addSubview:l];
            l.backgroundColor = [UIColor clearColor];
            l.textColor = [UIColor colorWithRed:183/255. green:211/255. blue:216/255. alpha:1];
            l.font = font;
            l.textAlignment = NSTextAlignmentCenter;
            l.layer.masksToBounds = YES;
            l.layer.cornerRadius = 7;
            l.layer.borderColor = [[UIColor colorWithRed:183/255. green:211/255. blue:216/255. alpha:1] CGColor];
            l.layer.borderWidth = 1;
            l.text = str;
            CGSize size = [str stringSizeWithFont:font andConstrainedToSize:CGSizeMake(wmax, h)];
            if (wmax - x < 20) {
                x = 0;
                y += h + spaceH;
            }
            if (size.width + 30 <= wmax - x) {
                if (size.width < wmin) {
                    if (60 < wmax - x) {
                        l.frame = CGRectMake(x, y, 60, h);
                        x += 60 + spaceH;
                    }
                } else {
                    l.frame = CGRectMake(x, y, size.width + 30, h);
                    x +=  size.width + 30 + spaceH;
                    
                }
                
                isNeedAdd25 = YES;
            } else if (size.width + 30 > wmax - x && (size.width + 15 <= wmax - x)) {
                
                l.frame = CGRectMake(x, y, size.width + 27, h);
                x = 0;
                y += h + spaceV;
                isNeedAdd25 = NO;
                
            } else {
                if (size.width + 15 < wmax - x) {
                    l.frame = CGRectMake(x, y, size.width + 15, h);
                    x = 0;
                    y += h + spaceV;
                    isNeedAdd25 = NO;
                } else {
                    x = 0;
                    y += h + spaceV;
                    
                    if (size.width + 30 < wmax - x) {
                        l.frame = CGRectMake(x, y, size.width + 30, h);
                        x += size.width + 30 + spaceH;
                        isNeedAdd25 = YES;
                    } else {
                        l.frame = CGRectMake(x, y, size.width + 15, h);
                        x = 0;
                        y += h + spaceV;
                        isNeedAdd25 = NO;
                        
                    }
                    
                }
                
                
            }
        }
        
    }
    if (isNeedAdd25) {
        y += h;
        
    } else {
        y -= spaceH;
    }

    return y;
}
- (void)moreBtnClick
{
    self.teacherInfo.isShowMoreIntroduction = !self.teacherInfo.isShowMoreIntroduction;
    _moreBtn.selected = self.teacherInfo.isShowMoreIntroduction;
    
    if (self.tableview) {
        [self.tableview reloadRowsAtIndexPaths:@[[self.tableview indexPathForCell:self]] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
