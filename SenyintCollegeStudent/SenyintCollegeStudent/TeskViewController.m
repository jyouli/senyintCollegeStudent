//
//  TeskViewController.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/18.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "TeskViewController.h"
#import "SCProgressHUD.h"
#import "YLBaseTableView.h"
#import "YLBaseView.h"
#import "LoginCell.h"
#import "YLScrollerImagesController.h"

#import "SCTextTableViewController.h"

#import "NetWorkManager.h"
@interface TeskViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TeskViewController
////////////
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    

    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    v.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:v];
    
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 600, 100, 100)];
    tf.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:tf];
    
    NSLog(@"%@",self.view.class);
    
    
    SCTextTableViewController *tc = [[SCTextTableViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tc];
    
    [self.navigationController presentViewController:nc animated:YES completion:nil];
    
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    SCTextTableViewController *tc = [[SCTextTableViewController alloc] init];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:tc];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:tc animated:YES completion:nil];
}

- (void)testscrollerImagecontroller
{
//    ivArray = [[NSMutableArray alloc] initWithCapacity:4];
//    imgArray = [[NSMutableArray alloc] initWithCapacity:4];
//    
//    for (int i = 0; i < 4; i ++) {
//        UIButton *iv1 = [[UIButton alloc] initWithFrame:CGRectMake(10 + (65 + 10)*i ,50 + h + 15, 65, 65)];
//        [iv1 setBackgroundImage:[UIImage imageNamed:@"imageAdd"] forState:UIControlStateNormal];
//        [iv1 addTarget:self action:@selector(selectImage:) forControlEvents:UIControlEventTouchUpInside];
//        [iv1 setContentMode:UIViewContentModeScaleAspectFill];
//        iv1.adjustsImageWhenHighlighted = NO;
//        iv1.tag = 1001 + i;
//        [ivArray addObject:iv1];
//        [view addSubview:iv1];
//        if (i == 0) {
//            iv1.hidden = NO;
//        } else {
//            iv1.hidden = YES;
//        }
//    }
//     

}


- (void)testURLSession
{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    //设置只允许WIFI操作网络请求
    sessionConfig.allowsCellularAccess = NO;
    //设置只允许接受json数据
    [sessionConfig setHTTPAdditionalHeaders:@{@"Accept":@"application/json"}];
    sessionConfig.timeoutIntervalForRequest = 30.0;
    sessionConfig.timeoutIntervalForResource = 60;
    sessionConfig.HTTPMaximumConnectionsPerHost = 1;
    
    

}

- (void)testScrollerview
{
    YLBaseView *view = [[YLBaseView alloc] initWithFrame:self.view.frame ];
    view.backgroundColor = [UIColor whiteColor];
    view.contentSize = CGSizeMake(self.view.bounds.size.width, 100 * 15);
    self.view = view;
    for (int i = 0; i < 15; i ++) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(30, 100 * i, 400, 50)];
        tf.backgroundColor = [UIColor lightGrayColor];
        tf.placeholder = @"请输入手机号码";
        [self.view addSubview:tf];
    }

    
    
}

- (void)testTableview
{
//    YLBaseTableView *tableview = [[YLBaseTableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];

    tableview.delegate = self;
    tableview.dataSource = self;
    self.view = tableview;
    
    UISearchBar *bar = [[UISearchBar alloc] init];

    [tableview registerClass:[LoginCell class] forCellReuseIdentifier:@"LoginCell"];
//    tableview.tableHeaderView = [self createHeaderView];
    tableview.tableFooterView = [self createFooterView];
    tableview.tableHeaderView = bar;
    
    UISearchDisplayController *displayc = [[UISearchDisplayController alloc] initWithSearchBar:bar contentsController:self];
    
    displayc.searchResultsDelegate = self;
    displayc.searchResultsDataSource = self;


}

- (UIView *)createHeaderView
{
    //表头
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 300)];
    header.backgroundColor = [UIColor clearColor];
    
    UILabel *l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, Screen_Width, 50)];
    l1.font = [UIFont systemFontOfSize:30];
    l1.textColor = [UIColor colorWithRed:20 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    l1.text = @"心医学院";
    l1.textAlignment = NSTextAlignmentCenter;
    [header addSubview:l1];
    
    UILabel *l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, Screen_Width, 15)];
    l2.font = [UIFont systemFontOfSize:14];
    l2.textColor = [UIColor colorWithRed: 252/ 255. green: 204/ 255. blue: 104/ 255. alpha:1];
    l2.text = @"学员端 beta";
    l2.textAlignment = NSTextAlignmentCenter;
    [header addSubview:l2];
    return header;
}

- (UIView *)createFooterView
{
    
    //表尾
    UIView * footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    footer.backgroundColor = [UIColor clearColor];

    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 30, Screen_Width - 50 * 2, 45)];
    loginBtn.backgroundColor = [UIColor colorWithRed:22 / 255. green:92 / 255. blue:111 / 255. alpha:1];
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    
    [loginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName,[UIFont systemFontOfSize:15], NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    
    [footer addSubview:loginBtn];

    return footer;
}
#pragma mark - Tableview data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * cellIdentifier = @"LoginCell";
    LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.tf.font = [UIFont systemFontOfSize:13];
    cell.tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!(indexPath.row % 2)) {
        cell.icon.image = [UIImage imageNamed:@"phoneIcon"];
        cell.tf.placeholder = @"请输入手机号码";
        //        cell.tf.keyboardType = UIKeyboardTypeNumberPad;
        cell.tf.secureTextEntry = NO;
        
    } else {
        
        cell.icon.image = [UIImage imageNamed:@"lockIcon"];
        cell.tf.placeholder = @"请输入密码";
        
        //        cell.tf.keyboardType = UIKeyboardTypeASCIICapable;
        cell.tf.secureTextEntry = YES;
        cell.tf.text = cell.tf.text;
    }
    
    //    cell.textLabel.text = [NSString stringWithFormat:@"cell-%ld",indexPath.row];
    //    cell.textLabel.textColor = [UIColor redColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 55, 0, 55);
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 55, 0, 55)];
    }
    
}


- (void)testProgressHUD
{
    UITextView *text = [[UITextView alloc] initWithFrame:CGRectMake(100, 100, 300, 300)];
    [self.view addSubview:text];
    text.text = @"viewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadiewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadiewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoadviewDidLoad";
 
}
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//    static int i = 1;
//
//    if (i == 11) {
//        i = 1;
//    }
//    NSLog(@"%d",i);
//    switch (i) {
//        case 1:
//            [SCProgressHUD setStatus:@"正在加载正在加载正在加载正在加载正在加载"];
//            break;
//        case 2:
//            [SCProgressHUD showSuccessWithStatus:@"hhhhhhhhhhhh" duration:6 maskType:SVProgressHUDMaskTypeNone ];
//            break;
//        case 3:
//            [SCProgressHUD showErrorWithStatus:@"eeeee" duration:2 maskType:SVProgressHUDMaskTypeNone];
//            break;
//        case 4:
//            [SCProgressHUD showProgress:.5 status:@"下载进度" maskType:SVProgressHUDMaskTypeNone];
//            break;
//        case 5:
//            [SCProgressHUD setStatus:@"正在加载正在加载正在加载正在加载正在加载"];
//            break;
//        case 6:
//            [SCProgressHUD showInfoWithStatus:@"hellolllllllllllll"];
//            break;
//        case 7:
//            [SCProgressHUD showImage:[UIImage imageNamed:@"clock"] status:@"正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载正在加载"];
//            break;
//        case 8:
//            [SCProgressHUD showSuccessWithStatus:@"yeyeyeyeyeyeyeyey"];
//            break;
//        case 9:
//            [SCProgressHUD showImage:[UIImage imageNamed:@"clock"] status:@"正在加载正在加载正在加载正在加载正在加载" maskType:SVProgressHUDMaskTypeNone];
//            break;
//        case 10:
//            [SCProgressHUD showImage:[UIImage imageNamed:@"clock"] status:@"正在加载正在加载正在加载正在加载正在加载" duration:3 maskType:SVProgressHUDMaskTypeNone];
//            break;
//            
//        default:
//            break;
//    }
//    
//    i ++;
//    
//    
//}
//



@end
