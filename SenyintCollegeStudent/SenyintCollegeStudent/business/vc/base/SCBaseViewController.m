//
//  SCBaseViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseViewController.h"
#import "AppSetting.h"
@interface SCBaseViewController ()

@end

@implementation SCBaseViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc",self.class);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if ((floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) ) {
        
        //设置4周的都不拉伸
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    if (!self.backImageStr) {
        self.backImageStr = @"nav_back";
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [btn setImage:[UIImage imageNamed:self.backImageStr] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navback) forControlEvents:UIControlEventTouchUpInside];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 20)];
    btn.imageView.contentMode = UIViewContentModeLeft;
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.leftBarButtonItem = back;

}

- (void)navback
{
    [self.navigationController popViewControllerAnimated:YES];
}



#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
