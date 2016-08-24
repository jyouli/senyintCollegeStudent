//
//  CollectionViewCell.h
//  CollectionViewDemo
//
//  Created by    任亚丽 on 16/7/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParticipantModel.h"
@interface CollectionViewCell : UICollectionViewCell
{
  
    __weak IBOutlet UILabel *rendName;
}

@property (nonatomic, strong) ParticipantModel *model;
@end
