//
//  SCBaseTableViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCBaseTableViewController.h"

@interface SCBaseTableViewController ()
@end

@implementation SCBaseTableViewController

- (void)dealloc
{
    NSLog(@"%@ dealloc",self.class);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ((floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) ) {
        
        //设置4周的都不拉伸
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
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
