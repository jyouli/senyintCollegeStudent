//
//  YLShowImagesViewController.m
//  MingyiMedicalService
//
//  Created by  haole on 15/6/16.
//  Copyright (c) 2015年 haole. All rights reserved.
//

#import "YLShowImagesViewController.h"
#import "YLScrollerImagesController.h"

@interface YLShowImagesViewController ()<UIAlertViewDelegate>
{
    YLScrollerImagesController *imgsController;
}

@end

@implementation YLShowImagesViewController

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.YLShowImagesViewControllerDidFinishDeleateImageBlock) {
        self.YLShowImagesViewControllerDidFinishDeleateImageBlock(self.imgArray);
    }
}
- (void)loadView
{
    [super loadView];
    self.title = @"图片";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(deleteCurrentImg)];
    self.navigationItem.rightBarButtonItem = item;
    
    imgsController = [[YLScrollerImagesController  alloc] initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    imgsController.itemArray = self.imgArray;
    imgsController.currIndex = self.currIndex;
    imgsController.isImgUrl = YES;
    imgsController.isShowProgress = YES;
    imgsController.placeHolderImg = self.placeHolderImg;
    
    __block NSMutableArray *myArray = self.imgArray;
    imgsController.ScrollerImageControllerDidDeleteImageBlock = ^(YLScrollerImagesController *imgController, NSMutableArray *imgsArray){
        myArray = imgsArray;
    };
    [imgsController reloadData];
    [self.view addSubview: imgsController];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ((floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_7_0) ) {
        
        //设置4周的都不拉伸
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }

}
- (void)deleteCurrentImg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"你确定要删除当前图片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alter show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        if (imgsController.itemArray.count > 1) {
            [imgsController deleteCurrentShwoImage];
        } else {
            [self.imgArray removeAllObjects];
            if (self.YLShowImagesViewControllerDidFinishDeleateImageBlock) {
                self.YLShowImagesViewControllerDidFinishDeleateImageBlock(self.imgArray);
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end