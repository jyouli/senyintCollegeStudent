//
//  HospitalSearchCell.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/6.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HospitalSearchCell.h"

@interface HospitalSearchCell (){

    __weak IBOutlet UILabel *hosLabel;
    __weak IBOutlet UILabel *cityLabel;
}

@end
@implementation HospitalSearchCell

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
    cityLabel.textColor = BodyContentAuxiliaryText_Font_Color;
}

- (void)setModel:(HospitalModel *)model
{
    _model = model;
    hosLabel.text = model.hosName;
    cityLabel.text = model.cityName;
}
@end
