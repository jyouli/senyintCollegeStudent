//
//  SCTextTableViewController.m
//  SenyintCollegeStudent
//
//  Created by fafangshuai on 16/8/19.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SCTextTableViewController.h"
@interface SCTextTableViewController ()
@property (nonatomic, weak)YLBaseTableView *tableView;

@end


@implementation SCTextTableViewController
- (instancetype)init
{
    return [self initWithStyle:UITableViewStylePlain CanSelectedCell:NO];
}
- (instancetype)initWithStyle:(UITableViewStyle)style
{

    return [self initWithStyle:self.style CanSelectedCell:NO];

}
- (instancetype)initWithStyle:(UITableViewStyle)style CanSelectedCell:(BOOL)canSelectedCell
{
    self = [super init];
    self.style = style;
    self.canSelectedCell = canSelectedCell;
    
    return self;
    
}

- (void)setCanSelectedCell:(BOOL)canSelectedCell
{
    _canSelectedCell = canSelectedCell;
    if (![self.tableView isEqual:[NSNull null]]) {
        self.tableView.canSelectedCell = canSelectedCell;

    }
}

- (void)loadView {
    [super loadView];
    
    YLBaseTableView *baseTableView = [[YLBaseTableView alloc] initWithFrame:self.view.frame style:self.style];
    baseTableView.delegate = self;
    baseTableView.dataSource = self;
    self.view = baseTableView;
    self.tableView = baseTableView;
    self.tableView.canSelectedCell = self.canSelectedCell;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)
         ];
    }
    
    UIView *v = [[UIView alloc] init];
    self.tableView.tableFooterView = v;
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

#pragma mark ==UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
    }
    
}

@end
