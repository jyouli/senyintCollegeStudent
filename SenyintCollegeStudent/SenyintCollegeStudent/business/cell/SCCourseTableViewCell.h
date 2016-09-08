//
//  SCCourseTableViewCell.h
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCCourseTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *classTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UILabel *hospitalLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainSpeekerLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelWidth;

@end
