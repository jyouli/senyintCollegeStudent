//
//  BroadcastliveViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/8.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "BroadcastliveViewController.h"
#import "JusTalkManager.h"
#import "CollectionViewCell.h"
#import "URLImageView.h"
#import "YLDateTimeTool.h"
@interface BroadcastliveViewController ()<JusTalkManagerDelegate, UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray *studens;
     __weak IBOutlet UICollectionView *_rendCollection;//用来渲染小屏
    __weak IBOutlet UIView *_fullRendView;//全屏渲染view
    __weak IBOutlet UIImageView *headerIv;
     __weak IBOutlet UILabel *nameL;//全屏mode姓名
    __weak IBOutlet UILabel *identityL;//全屏mode身份

    __weak IBOutlet UILabel *liveTime;//直播进行时间

    ParticipantModel *fullModel;//正在大屏上渲染的model
    __weak ParticipantModel *selfModel;//自己（切换摄像头）
    NSMutableArray *collectionModels;//小屏上渲染的models
    
    //视频持续时间计算
    NSTimer *timer;
    CFRunLoopRef timerRunloop;
    
    //会议信息
    NSString *_mtcConfNumber;
    NSString *_mtcConfUri;
    NSString *_mtcConfId;
    
}

@end

@implementation BroadcastliveViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stoprend];
    

    self.expertModel = nil;
    NSLog(@"ViewController---dealloc");
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelectorInBackground:@selector(opentimer) withObject:nil];

}

- (void)viewWillDisappear:(BOOL)animated
{

    [self stoptimer];
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self startRend];
    
    
    //监听锁屏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    //监听app状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBecomeAction) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEnterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(142, 80);
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    _rendCollection.collectionViewLayout = layout;
    UINib *nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [_rendCollection registerNib:nib forCellWithReuseIdentifier:@"rendCell"];
    _rendCollection.dataSource = self;
    _rendCollection.delegate = self;
    _rendCollection.backgroundColor = [UIColor clearColor];
    _rendCollection.clipsToBounds = NO;
}


- (void)setExpertModel:(ParticipantModel *)expertModel
{
    _expertModel = expertModel;
    fullModel = expertModel;
    [fullModel updateRendViewSuperView:_fullRendView];
    
    [headerIv setImageWithURL:[NSURL URLWithString:expertModel.headimg]];
     identityL.text = @"专家";
    nameL.text = expertModel.nickName;
    
}

- (void)setStudentModels:(NSArray *)studentModels
{
    if (!collectionModels) {
        collectionModels = [[NSMutableArray alloc] init];
    }
    if (collectionModels.count) {
        [collectionModels removeAllObjects];
    
    }
    [collectionModels addObjectsFromArray:studentModels];
    
}

//有同学加入会议
- (void)studentAddMeeting:(ParticipantModel *)model
{
    [collectionModels addObject:model];
    [_rendCollection reloadData];

}

//专家加入会议
- (void)expertAddMeeting:(ParticipantModel *)model
{
    if (fullModel) {
        [collectionModels insertObject:fullModel atIndex:0];
        [_rendCollection reloadData];
      
    }
    
    [self setExpertModel:model];
}

//有人离开会议
- (void)otherLeaveMeeting:(ParticipantModel *)model
{
    [model.rendView stopRend];
    
    if (model == self.expertModel) {
        if (fullModel == self.expertModel) {
            self.expertModel = nil;
            fullModel = nil;
            
        } else {
            
            [collectionModels removeObject:self.expertModel];
            self.expertModel = nil;
            [_rendCollection reloadData];
            
            
        }
    } else {
        
        if (fullModel == model) {
            fullModel = nil;
            fullModel = [collectionModels objectAtIndex:0];
            [fullModel updateRendViewSuperView:_fullRendView];
            [collectionModels removeObjectAtIndex:0];
            [_rendCollection reloadData];
            
            
        } else {
            
            [collectionModels removeObject:model];
            [_rendCollection reloadData];
            
            
        }
        
        
    }
    

    [headerIv setImageWithURL:[NSURL URLWithString:fullModel.headimg]];
    nameL.text = fullModel.nickName;
    if (fullModel.isExpert) {
        identityL.text = @"专家";

    } else {
    
        identityL.text = @"学员";
    }

}

//切换摄像头
- (IBAction)changeCamera:(UIButton *)sender {
    if (!selfModel) {
        if (fullModel && fullModel.isSelf) {
            selfModel = fullModel;
        } else {
            for (ParticipantModel *model in collectionModels) {
                if (model.isSelf) {
                    selfModel = model;
                }
            }

        
        }
        
    }
    selfModel.isBack = !selfModel.isBack;
    [[JusTalkManager sharedJusTalk] changeCaptureSelfModel:selfModel];
    
}


- (IBAction)changeMuteState:(UIButton *)sender {
 
    sender.selected = !sender.selected;
    [[JusTalkManager sharedJusTalk] changeMuteState:sender.selected];
    
}
- (IBAction)exitBroadcastliveView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)finishBroadcastliveView:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark 更新视频播放时间

//初始化定时器
- (void)opentimer
{
    if (!timer) {
        timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateCountDownTime) userInfo:nil repeats:YES];
        
    }
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    timerRunloop = CFRunLoopGetCurrent();
    CFRunLoopRun();
    
}

- (void)stoptimer
{
    CFRunLoopStop(timerRunloop);
    [timer invalidate];
    timer = nil;
}

//更新倒计时时间
- (void)updateCountDownTime
{
    liveTime.text = [YLDateTimeTool getContinuedTimeWithCurrentTimeIntervalToAppointTimeInterval:self.startTime];
    
}


#pragma mark 渲染相关
- (void)startRend{
        if (TARGET_IPHONE_SIMULATOR) {//真机下准备硬件
        [self showPromptInformation:@"不支持模拟器渲染"];
        return;
    }
    
    [self preparetoRend];
    
    
}

- (void)stoprend {
    
    [[JusTalkManager sharedJusTalk] stopSendvideoandAudioData];
    [fullModel.rendView stopRend];
    for (ParticipantModel *model in collectionModels) {
        [model.rendView stopRend];
    }
    self.expertModel = nil;
    fullModel = nil;
    [collectionModels removeAllObjects];    

    
}

- (void)preparetoRend
{
    //开启音频
    BOOL audiosuccess = [[JusTalkManager sharedJusTalk] prepareAudioandopenResult:^(NSString *promptInformation) {
    }];
    if (audiosuccess) {
        //打开关联摄像头
        BOOL videosuccess = [[JusTalkManager sharedJusTalk] prepareVideoWith:YES withmtcConfId:nil openResult:^(NSString *promptInformation) {
        }];
        if (!videosuccess) {
            [self showPromptInformation:@"打开或关联摄像头失败"];
        }
        
    } else {
        
        [self showPromptInformation:@"开启音频采集或播放失败"];

    }

}

#pragma mark  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return collectionModels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"rendCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ParticipantModel *model = [collectionModels objectAtIndex:indexPath.row];
    cell.model = model;
    
    return cell;
}

#pragma mark  UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ParticipantModel *model = [collectionModels objectAtIndex:indexPath.row];
    if (fullModel && fullModel == self.expertModel) {
        [collectionModels insertObject:fullModel atIndex:0];
   
    } else if (model == self.expertModel) {
    
        if (fullModel) {
            [collectionModels insertObject:fullModel atIndex:0];

        }
    }
    else {
        if (fullModel) {
            [collectionModels insertObject:fullModel atIndex:1];

        }
        
    }
    
    fullModel = model;
    [collectionModels removeObject:model];
    [_rendCollection reloadData];

    
    [fullModel updateRendViewSuperView:_fullRendView];
    
    [headerIv setImageWithURL:[NSURL URLWithString:fullModel.headimg]];
    nameL.text = fullModel.nickName;
    if (fullModel.isExpert) {
        identityL.text = @"专家";
        
    } else {
        
        identityL.text = @"学员";
    }
    

    
}


#pragma mark 通知回调
- (void)deviceOrientChange:(NSNotification *)noti
{
    if (!selfModel) {
        if (fullModel && fullModel.isSelf) {
            selfModel = fullModel;
        } else {
            for (ParticipantModel *model in collectionModels) {
                if (model.isSelf) {
                    selfModel = model;
                }
            }
            
            
        }
        
    }

    NSLog(@"%ld",[UIDevice currentDevice].orientation);
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft) {
        selfModel.angle = 270;

    } else if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        selfModel.angle = 90;
    
    } else {
//        //因为self.view没有机会转成向上或向下 所以不必要设
//        selfModel.angle = 0;
    }
    
    [[JusTalkManager sharedJusTalk] videoRenderRotateWithParticipantModel:selfModel];
//    
//    [selfModel.rendView stopRend];
//    [selfModel.rendView startRend];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didEnterBackground{
    //阻止屏幕变暗，慎重使用
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
}

- (void)didBecomeAction{
    if ([UIApplication sharedApplication].isIdleTimerDisabled) {
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        
    }
    NSLog(@"didBecomeAction");
    
}
- (void)WillTerminate{
    //阻止屏幕变暗，慎重使用
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
}

#pragma mark - 横屏设置
///**
//只此页面支持横屏 其他页面竖屏 
//在AppDelegate方法中设置 只支持竖屏
//用此中方法设置 此界面不支持旋转
//*/
////此方法默认反回yes
//- (BOOL)shouldAutorotate
//{
//    return NO;
//}
//- (UIInterfaceOrientationMask)supportedInterfaceOrientations
//{
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
//{
//
//    return UIInterfaceOrientationLandscapeLeft;
//}
//
//- (BOOL)prefersStatusBarHidden
//{
//    return NO;
//}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    
    return UIInterfaceOrientationLandscapeRight;
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}


#warning 提示
- (void)showPromptInformation:(NSString *)prompt
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:prompt delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [view show];
}


@end
