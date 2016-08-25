//
//  InfoTextFieldCellModel.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "InfoTextFieldCellModel.h"

@implementation InfoTextFieldCellModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textFieldEnabled = YES;
        self.textFieldSecureTextEntry = NO;
        self.textFieldClearBtnMode = UITextFieldViewModeWhileEditing;
        self.textFieldRightviewMode = UITextFieldViewModeUnlessEditing;
        self.textFieldSetSecureRightView = NO;
    }
    
    return self;
}
@end
