//
//  HosPitalSearchPromptCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HosPitalSearchPromptCell.h"

@interface HosPitalSearchPromptCell (){

    __weak IBOutlet UIImageView *promptIcon;
    __weak IBOutlet UILabel *promptTextLabel;

}

@end
@implementation HosPitalSearchPromptCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSubviews];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSubviews];
    
}

- (void)setSubviews
{
//    UIView *l = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 1)];
//    [self addSubview:l];
//    l.backgroundColor = SeparationLine_Color;
    promptTextLabel.textColor = COLOR_RGB(188, 186, 193);
}

@end
