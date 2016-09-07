//
//  EnterViewController.m
//  SenyintCollegeStudent
//
//  Created by 任亚丽 on 16/8/25.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "EnterViewController.h"
#import "LoginViewController.h"
#import "PasswordLoginViewController.h"
#import "VerificationCodeLoginViewController.h"
#import "RegisterViewController.h"
#import "SCVisitViewController.h"

@interface EnterViewController ()<UITextFieldDelegate>

@end

@implementation EnterViewController

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = YES;
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    self.navigationItem.leftBarButtonItem = nil;
    
    UIImageView *iv = [[UIImageView alloc] initWithFrame:self.view.bounds];
    iv.contentMode = UIViewContentModeScaleAspectFill;
    iv.image = [UIImage imageNamed:@"loading"];
    if (iPhone4_4S) {
        iv.contentMode = UIViewContentModeTop;
        iv.image = [UIImage imageNamed:@"loading4"];
    }
    [self.view addSubview:iv];

    CGFloat leftspace = 30;
    CGFloat bottomspace = 30;
    CGFloat space = 15;
    CGFloat width = Screen_Width - leftspace * 2;
    CGFloat height = 45;
    CGFloat top = Screen_Height - height * 3 - bottomspace - space * 2;

    UIButton *loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftspace,top, width, height)];
    loginBtn.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIImage *image = [UIImage imageNamed:@"login"];
    [loginBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateNormal];
    [loginBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"登录" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.alpha = .8;
    [self.view addSubview:loginBtn];

    UIButton *registBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftspace,top + height + space, width, height)];
    [registBtn setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width / 2 topCapHeight:image.size.height / 2] forState:UIControlStateNormal];
    [registBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"注册" attributes:[NSDictionary dictionaryWithObjectsAndKeys: SubmitButtonText_Font_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [registBtn addTarget:self action:@selector(registBtnClick) forControlEvents:UIControlEventTouchUpInside];
    registBtn.alpha = .8;
    [self.view addSubview:registBtn];
    
    UIButton *experienceBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftspace,top + (height + space) * 2, width, height)];
    UIImage *img = [UIImage imageNamed:@"experience_bg"];
    [experienceBtn setBackgroundImage:[img stretchableImageWithLeftCapWidth:img.size.width / 2 topCapHeight:img.size.height / 2] forState:UIControlStateNormal];
    [experienceBtn setAttributedTitle: [[NSAttributedString alloc]initWithString:@"体验一下" attributes:[NSDictionary dictionaryWithObjectsAndKeys: NavBar_bg_Color, NSForegroundColorAttributeName,SubmitButtonText_Font_Size, NSFontAttributeName ,nil]] forState:UIControlStateNormal];
    [experienceBtn addTarget:self action:@selector(experienceBtnClick) forControlEvents:UIControlEventTouchUpInside];
    experienceBtn.alpha = .8;
    [self.view addSubview:experienceBtn];
    
}


- (void)loginBtnClick
{

    PasswordLoginViewController *vc = [[PasswordLoginViewController alloc] init];
    [self pushPresentViewController:vc isWithNavigationController:YES Animated:YES completion:nil];
}

- (void)registBtnClick
{
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    [self pushPresentViewController:vc isWithNavigationController:YES Animated:YES completion:nil];

}

- (void)experienceBtnClick
{
    [self pushPresentViewController:[[SCVisitViewController alloc] init] isWithNavigationController:YES Animated:YES completion:nil];

//    [self.navigationController pushViewController:[[SCVisitViewController alloc] init] animated:YES];

}

@end
