//
//  SelectHospitalViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/26.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "SelectHospitalViewController.h"
#import "UIImage+Rend.h"
#import "HospitalSearchCell.h"
#import "HosPitalSearchPromptCell.h"
#import "AddHospitalViewController.h"
#import "YLStringTool.h"
@interface SelectHospitalViewController ()<UISearchBarDelegate>
{
    __weak UIButton *_addHosBtn;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation SelectHospitalViewController

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.dataArray = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择医院";
    UIButton *addHosBtn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 60, 30)];
    [addHosBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"添加" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBarSonControl_Font_Color, NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [addHosBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"添加" attributes:[NSDictionary dictionaryWithObjectsAndKeys:COLOR_RGB_HEX(0xa9a9a9), NSForegroundColorAttributeName,NavBarSonControl_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateDisabled];
    [addHosBtn setBackgroundImage:[[UIImage imageNamed:@"surebtn_bg"] stretchableImageWithLeftCapWidth:25 topCapHeight:6] forState:UIControlStateNormal];
    [addHosBtn setBackgroundImage:[UIImage imageNamed:@"surebtn_bg_disable"] forState:UIControlStateDisabled];
    [addHosBtn addTarget:self action:@selector(addHosBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:addHosBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    _addHosBtn = addHosBtn;
    _addHosBtn.enabled = NO;

    
    
    self.tableView.backgroundColor = COLOR_RGB_HEX(0xf0f0f0);
    [self.tableView registerNib:[UINib nibWithNibName:@"HosPitalSearchPromptCell" bundle:nil] forCellReuseIdentifier:@"HosPitalSearchPromptCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HospitalSearchCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass([HospitalSearchCell class])];
    

    UIImageView *searchv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,70)];
    searchv.image = [[UIImage imageNamed:@"search_bg"] stretchableImageWithLeftCapWidth:50 topCapHeight:0];
    searchv.userInteractionEnabled = YES;
    
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,70)];
    searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    searchBar.backgroundImage = [[UIImage imageNamed:@"search_bg"] stretchableImageWithLeftCapWidth:50 topCapHeight:0];
    //设置SearchField背景为透明
    [searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"navBarItem_clearbg"]  forState:UIControlStateNormal];
    
    //设置标签 clearBtn位置
    [searchBar setPositionAdjustment:UIOffsetMake(-25, 0) forSearchBarIcon:UISearchBarIconClear];
    [searchBar setPositionAdjustment:UIOffsetMake(10, 0) forSearchBarIcon:UISearchBarIconSearch];
    //设置SearchBarIcon 为无(无图片 位置扔保留)
    [searchBar setImage:[UIImage new] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    //设置UISearchBarIconClear 系统颜色较深
    [searchBar setImage:[UIImage imageNamed:@"del"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
    
    //标签颜色
    searchBar.tintColor = NavBar_bg_Color;
    
    searchBar.placeholder = @"输入医院名称搜索    ";
    searchBar.delegate = self;
    
    
    self.tableView.tableHeaderView = searchBar;
    self.dataArray = [[NSMutableArray alloc] init];
}


- (void)addHosBtnClick
{
    AddHospitalViewController *vc = [[AddHospitalViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark== UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    _addHosBtn.enabled = YES;
    
    NSLog(@"searchBarSearchButtonClicked");
    [_dataArray removeAllObjects];
    for (int i = 0; i < arc4random() % 50; i ++) {
        HospitalModel *model = [[HospitalModel alloc] init];
        model.hosId = [NSString stringWithFormat:@"%d",i];
        model.hosName = [NSString stringWithFormat:@"医院%d",i];
        model.cityName = [NSString stringWithFormat:@"市%d",i];
        [_dataArray addObject:model];
    }
    [self.tableView reloadData];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([YLStringTool isEmpty:searchText]) {
        _addHosBtn.enabled = NO;
        [self.tableView reloadData];
        
    }
}




#pragma mark ==UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"HospitalSearchCell";
    HospitalSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.model = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
    
}


#pragma mark ==UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.cellModel.textFieldinfo = self.dataArray[indexPath.row];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    static NSString *identifier = @"HosPitalSearchPromptCell";
    HosPitalSearchPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    NSLog(@"%@",cell);
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSLog(@"%d",_addHosBtn.enabled);
    if (_addHosBtn.enabled) {
        return 55;
    }
    
    return 0;
}
@end
