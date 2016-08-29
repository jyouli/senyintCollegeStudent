//
//  SCVisitViewController.m
//  SenyintCollegeStudent
//
//  Created by 蒋友利 on 16/8/29.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCVisitViewController.h"
#import "SCCourseDetailViewController.h"
#import "SCCourseTableViewCell.h"
#import "MJRefresh.h"

@interface SCVisitViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    UITableView * _specialtyTabelView;
    UIView * alphaView;
}
@end

@implementation SCVisitViewController

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    
    _specialtyTabelView.delegate = nil;
    _specialtyTabelView.dataSource = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (IOS7_OR_LATER) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self putViews];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self putTopView];
}

- (void)putViews
{
    [self putTableView];
    [self putSpecialtyTableView];
}

- (void)putTopView
{
    
    UIButton * topBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    [topBtn setTitle:@"全部学科" forState:UIControlStateNormal];
    [topBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    topBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [topBtn setImage:[UIImage imageNamed:@"clock"] forState:UIControlStateNormal];
    [topBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -25, 0, 0)];
    [topBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -125)];
    [topBtn addTarget:self action:@selector(topBarAction) forControlEvents:UIControlEventTouchUpInside];
    //    topBtn.backgroundColor = [UIColor yellowColor];
    self.navigationController.navigationBar.topItem.titleView = topBtn;
}

- (void)putTableView
{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 64) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_tableView];
    
    //添加下拉刷新，上拉加载
    
    __weak UITableView * weakTable = _tableView;
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"下拉刷新");
        [NSThread sleepForTimeInterval:.5];
        [weakTable.mj_header endRefreshing];
    }];
    
    _tableView.mj_footer =  [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSLog(@"上拉加载更多");
        [NSThread sleepForTimeInterval:.5];
        [weakTable.mj_footer endRefreshing];
    }];
    
}

- (void)putSpecialtyTableView
{
    if (_specialtyTabelView) {
        _specialtyTabelView.hidden = NO;
        alphaView.hidden = NO;
    }
    else{
        
        //底部半黑色view
        alphaView = [[UIView alloc] initWithFrame:_tableView.bounds];
        alphaView.backgroundColor = [UIColor blackColor];
        alphaView.alpha = 0.5f;
        alphaView.hidden = YES;
        [self.view addSubview:alphaView];
        
        //科室表
        _specialtyTabelView = [[UITableView alloc] initWithFrame:_tableView.bounds style:UITableViewStylePlain];
        _specialtyTabelView.delegate = self;
        _specialtyTabelView.dataSource = self;
        _specialtyTabelView.backgroundColor = [UIColor clearColor];
        _specialtyTabelView.hidden = YES;
        _specialtyTabelView.scrollsToTop = NO;
        [self.view addSubview:_specialtyTabelView];
        
        //表尾，用于去除空白cell的分割线
        _specialtyTabelView.tableFooterView = [[UIView alloc] init];
        
        if ([_specialtyTabelView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_specialtyTabelView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([_specialtyTabelView respondsToSelector:@selector(setLayoutMargins:)]) {
            [_specialtyTabelView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
}

#pragma mark action

- (void)topBarAction
{
    NSLog(@"选择学科");
    _specialtyTabelView.hidden = !_specialtyTabelView.hidden;
    alphaView.hidden = !alphaView.hidden;
    _specialtyTabelView.scrollsToTop = !_specialtyTabelView.hidden;
}

#pragma mark tableView

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, tableView == _tableView ? 13 : 0, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, tableView == _tableView ? 13 : 0, 0, 0)];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return tableView == _tableView ? 115 : 44 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return tableView == _tableView ? 15 : 0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return tableView == _tableView ? 15 : 0 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableView) {
        
        //班级信息
        static NSString * identifier = @"SCCourseTableViewCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"SCCourseTableViewCell" owner:self options:nil][0];
        }
        
        return cell;
    }
    else{
        
        //科室筛选
        static NSString * identifier = @"speCell";
        UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        
        cell.textLabel.text = indexPath.row%2?@"口腔科":@"呼吸内科";
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了第%ld个cell",indexPath.row);
    if (tableView == _tableView) {
        
        NSLog(@"跳转到班级课程详细页");
        SCCourseDetailViewController * vc = [[SCCourseDetailViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        
        NSLog(@"筛选学科下的班级课程列表");
        //刷新班级课程列表
        [_tableView.mj_header beginRefreshing];
        //隐藏专科选择表
        _specialtyTabelView.hidden = YES;
        alphaView.hidden = YES;
        _specialtyTabelView.scrollsToTop = NO;

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
