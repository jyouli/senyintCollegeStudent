//
//  CustomView.h
//  MingyiMedicalService
//
//  Created by  haole on 15/6/4.
//  Copyright (c) 2015年 haole. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLCustomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSArray *infoArray;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIFont *textFont;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, assign) BOOL isRTLabel;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@end
