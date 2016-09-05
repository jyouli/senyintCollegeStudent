//
//  LoginCellModel.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/9/5.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "LoginCellModel.h"

@implementation LoginCellModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.textFieldSecureTextEntry = NO;
        self.textFieldClearBtnMode = UITextFieldViewModeNever;
    }
    
    return self;
}
@end
