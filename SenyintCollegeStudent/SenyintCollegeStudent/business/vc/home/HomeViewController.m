//
//  HomeViewController.m
//  SenyintCollegeStudent
//
//  Created by    任亚丽 on 16/8/3.
//  Copyright © 2016年 YL. All rights reserved.
//

#import "HomeViewController.h"
#import "CourseCell.h"
#include "TeacherCell.h"
#import "ClassmateCell.h"
#import "JusTalkManager.h"
#import "BroadcastliveViewController.h"
#import "NSString+Attribute.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,JusTalkManagerDelegate>
{
    __weak UITableView *_theTableview;
    CourseModel *_courseModel;
    TeacherModel *_teacherModel;
    NSMutableArray *_students;
   
    //倒计时相关
    UIButton *timeBtn;
    UIButton *showBtn;
    NSTimer *timer;
    CFRunLoopRef timerRunloop;

    //菊风相关
    JusTalkManager *justManager;
    ParticipantModel *expertParticipant;//专家渲染染model
    NSMutableArray *participantModelArray;
    
    //会议信息
    NSString *_mtcConfNumber;
    NSString *_mtcConfUri;
    NSString *_mtcConfId;
    BOOL isJoinConf;
    
    __weak BroadcastliveViewController *broadcastliveVC;
    //标记当前界面是否正在显示 YES 显示的是self NO 显示broadcastliveVC
    BOOL isRootview;
    
}
@end

@implementation HomeViewController

+ (void)setWindowRootViewController
{
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = homeVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    isRootview = YES;
    [_theTableview reloadData];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear: animated];
    isRootview = NO;
}


#warning text
- (void)test
{
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    tf.placeholder = @"roomid";
    tf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    tf.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.returnKeyType = UIReturnKeyDone;
    tf.tag = 111;
    [self.view addSubview:tf];
    
    
    
    UIButton *joinBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 155, 100, 40)];
    
    joinBtn.backgroundColor = [UIColor orangeColor];
    joinBtn.titleLabel.text = @"Join";
    joinBtn.titleLabel.textColor = [UIColor whiteColor];
    [joinBtn addTarget:self action:@selector(joinBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:joinBtn];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)joinBtnClick
{
    [self.view endEditing:YES];
    UITextField *tf = (UITextField *)[self.view viewWithTag:111];
    [justManager queryMeetingWithroomid:tf.text];
}
#pragma end

- (void)loadView
{
    [super loadView];
    [self performSelectorInBackground:@selector(justalkinitialize) withObject:nil];

}
- (void)viewDidLoad {

 [super viewDidLoad];
  self.view.backgroundColor = [UIColor orangeColor];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    _theTableview = tableview;
    [self setTableview];
    _courseModel = [[CourseModel alloc] init];
    _courseModel.courseImage = [UIImage imageNamed:@"2"];
    _teacherModel = [[TeacherModel alloc] init];
    
    
    __weak typeof(self) safeSelf = self;
    
    [self setRefreshNormalHeader:_theTableview WithRefreshingBlock:^{
        [safeSelf requestCourseDataFromServer];
    }];
    
    [self setRefreshBackNormalFooter:_theTableview WithRefreshingBlock:nil];

    [self requestCourseDataFromServer];    
    [self test];
}

#pragma mark ======进入直播界面
- (void)showBroadcastliveView
{
    if (!isJoinConf) {
        
        [SCProgressHUD showInfoWithStatus:@"没有加入房间"];
        return;
    }
    
    BroadcastliveViewController *showvc = [[[UINib nibWithNibName:@"BroadcastliveViewController" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    showvc.expertModel = expertParticipant;
    showvc.studentModels = participantModelArray;
    showvc.startTime = _courseModel.course_start_time;
    broadcastliveVC = showvc;
    [self presentViewController:showvc animated:YES completion:nil];
    
    
}



#pragma mark ===tableview
- (void)setTableview
{

    _theTableview.tableHeaderView = [self createTableHeaderView];
    _theTableview.tableFooterView = [self createFooterView];
    _theTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [_theTableview registerClass:[CourseCell class] forCellReuseIdentifier:@"CourseCell"];
    [_theTableview registerClass:[TeacherCell class] forCellReuseIdentifier:@"TeacherCell"];
    [_theTableview registerClass:[ClassmateCell class] forCellReuseIdentifier:@"ClassmateCell"];
    
    
    _theTableview.dataSource = self;
    _theTableview.delegate = self;

}
- (UIView *)createTableHeaderView
{
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
    headerview.backgroundColor = RGBACOLOR(20, 92, 111, 1);
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 20, Screen_Width - 30, 100)];
    label.numberOfLines = 0;
    label.attributedText = [NSString getAttributedStringFromString:@"Hi，欢迎来到心医学院！\n" Color:RGBACOLOR(82, 155, 173, 1) Fount:[UIFont systemFontOfSize:27 weight:1] AndString:@"立即加入课堂，和专家即时互动，体验\n不一样的精品小班直播。" Color:RGBACOLOR(160, 212, 221, 1) Fount:[UIFont systemFontOfSize:14 ]];
    [headerview addSubview:label];
    
    return headerview;
}

- (UIView *)createFooterView
{
    UIView *foor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 80)];
    
    
    timeBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width - 250)/ 2, 20, 250, 40)];
    [timeBtn setBackgroundColor:[UIColor clearColor]];
    [timeBtn setImage:[UIImage imageNamed:@"endicon"] forState:UIControlStateDisabled];
    [timeBtn setAttributedTitle:[NSString getAttributedStringFromString:@"  倒计时 01:24:30" Color:[UIColor colorWithRed:183/255. green:211/255. blue:216/255. alpha:1] Fount:[UIFont systemFontOfSize:14]] forState:UIControlStateDisabled];
    timeBtn.enabled = NO;
    [foor addSubview:timeBtn];
    
    showBtn = [[UIButton alloc] initWithFrame:CGRectMake((Screen_Width - 250)/ 2, 20, 250, 40)];
    [showBtn setBackgroundColor:[UIColor orangeColor]];
    [showBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [showBtn setAttributedTitle:[NSString getAttributedStringFromString:@"  进入直播" Color:[UIColor whiteColor] Fount:[UIFont systemFontOfSize:14]] forState:UIControlStateNormal];
    [showBtn addTarget:self action:@selector(showBroadcastliveView) forControlEvents:UIControlEventTouchUpInside];
    showBtn.layer.masksToBounds = YES;
    showBtn.layer.cornerRadius = 7;
    showBtn.hidden = YES;
    [foor addSubview:showBtn];
    
    
    return foor;

}

#pragma mark - Tableview datasource and delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"cell";

    if (indexPath.section == 0) {
         cellIdentifier = @"CourseCell";
        CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.course = _courseModel;
        cell.tableview = tableView;
        
        return cell;
    } else if (indexPath.section == 1){
        cellIdentifier = @"TeacherCell";
        TeacherCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        cell.teacherInfo = _teacherModel;
        cell.tableview = tableView;
        
        return cell;
    }
    
    cellIdentifier = @"ClassmateCell";
    ClassmateCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.students = _students;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        float y = 250;
        if (_courseModel.introductionSize.height <= 40) { //不大于两行
            y += 10;
            y += _courseModel.introductionSize.height + 25;
            
        } else {
            
            y += 25;
            if (_courseModel.isShowMoreIntroduction) {
                y += _courseModel.introductionSize.height + 25;
                
            } else {
                
                y += 60;
                
            }
            
        }
        
        return y;
        
        
    } else if (indexPath.section == 1) {
        float y = 240 + _teacherModel.tapsHeight + 15;
        if (_teacherModel.introductionSize.height < 40) {
            y += _teacherModel.introductionSize.height + 5;
            
        } else {
            if (_teacherModel.isShowMoreIntroduction) {
                y += _teacherModel.introductionSize.height + 5;
                
            } else {
                
                y += 35;
            }
            
        }
        
        return y + 20;
        
    }
    
    NSInteger c = _students.count / 4;
    if (_students.count % 4) {
        c += 1;
    }
    return 50 + c * 90 + 10;
}



#pragma mark httpRequest
- (void)requestCourseDataFromServer{

    //课堂消息
    
    NSMutableDictionary *paraDic = [[NSMutableDictionary alloc] initWithDictionary:[GlobalSingle userBaseInfo]] ;
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [sessionManager GET:[[GlobalSingle baseUrl] stringByAppendingString:@"/v1/classroom/student"]  parameters:paraDic progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"totalUnitCount:%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success:%@", responseObject);        
        [self setDataRespons:responseObject];
        
        [self endRefreshingHeaderFreshView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];
    


}

#pragma mark ===更新数据
- (void)setDataRespons:(id)responseObject{
   
    _mtcConfNumber = [[responseObject objectForKey:@"content"] objectForKey:@"course_room_id"];
    if ([JusTalkManager sharedJusTalk].isLogined) {
        [justManager queryMeetingWithroomid:_mtcConfNumber];
    }
    
#warning 测试
    UITextField *tf = (UITextField *)[self.view viewWithTag:111];
    tf.text = _mtcConfNumber;
////////////////////////
    
    [self setCourseInfoFromResponseObject:responseObject];
    [self setTeacherInfoFromResponseObject:responseObject];
    [self setStudentsFromResponseObject:[[responseObject objectForKey:@"content"]objectForKey:@"students"]];
   
    [_theTableview reloadData];


}
//设置_courseModel参数
- (void)setCourseInfoFromResponseObject:(id)responseObject
{
    if (!_courseModel) {
        _courseModel = [[CourseModel alloc] init];
        
    }
    _courseModel.introductionWidth = Screen_Width - 30;
    [_courseModel setCourseDataFromResponseObject:responseObject];

    [self updateFoorterview];
    
}

//设置_teacherModel参数
- (void)setTeacherInfoFromResponseObject:(id)responseObject
{
    if (!_teacherModel) {
        _teacherModel = [[TeacherModel alloc] init];
    }
    _teacherModel.tapViewWidth = Screen_Width - 30;
    [_teacherModel setDataFromResponseObject:responseObject];
    


}

//设置_studens参数
- (void)setStudentsFromResponseObject:(NSArray *)stus
{
    if (!_students) {
        _students = [[NSMutableArray alloc] init];
    }
    for (NSDictionary *dic in stus) {
        StudentModel *model = [[StudentModel alloc] init];
        [model setDataFromResponseObject:dic];
        [_students addObject:model];
    }
    
    

}

//更新foorterview 小于指定时间差 可以进入直播  反之， 显示倒计时
- (void)updateFoorterview
{
    
    [timer invalidate];
    timer = nil;
    if (_courseModel.course_start_time - [YLDateTimeTool currentDatetimeIntervalSince1970] < JoinConfCountDownTime) {
        showBtn.hidden = NO;
        timeBtn.hidden = YES;
    } else {
        timeBtn.hidden = NO;
        showBtn.hidden = YES;

        [self performSelectorInBackground:@selector(opentimer) withObject:nil];

        
    }


}

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

//更新倒计时时间
- (void)updateCountDownTime
{
    NSLog(@"updateStartTime");
    if (_courseModel.course_start_time - [YLDateTimeTool currentDatetimeIntervalSince1970] < JoinConfCountDownTime) {
        dispatch_async(dispatch_get_main_queue(), ^{
            showBtn.hidden = NO;
            timeBtn.hidden = YES;
        });
        [timer invalidate];
        timer = nil;
        CFRunLoopStop(timerRunloop);

        
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{

            [timeBtn setAttributedTitle:[NSString getAttributedStringFromString:[NSString stringWithFormat:@"  倒计时 %@",[YLDateTimeTool getContinuedTimeWithAppointTimeIntervalTocurrentTimeInterval:_courseModel.course_start_time]] Color:[UIColor colorWithRed:183/255. green:211/255. blue:216/255. alpha:1] Fount:[UIFont systemFontOfSize:14]] forState:UIControlStateDisabled];
        });
         
    }

}

#pragma mark 菊风初始化及业务回调
//初始化
- (void)justalkinitialize
{
    justManager  = [JusTalkManager sharedJusTalk];
    justManager.delegate = self;
    [justManager jusTalkinitialize];

}
#pragma mark =JusTalkManagerDelegate
- (void)justalkinitializeOk
{
    [justManager loginJustalkToRSAWithUserName:[GlobalSingle userMobile] PassWord:[GlobalSingle userPassword]];
    
}
- (void)justalkinitializeFail:(ZINT)reason
{
    [self showPromptInformation:@"菊风初始化失败"];
}
//登录回调
- (void)justalkSendLoginFile:(ZINT)reason//登录发出失败
{
    [self showPromptInformation:@"菊风登录发出失败"];
}
- (void)justalkLoginOk
{
    if ([_courseModel.roomid length]) {
        [justManager queryMeetingWithroomid:_courseModel.roomid];
    }

}
- (void)justalkLoginFail:(ZINT)reason
{

    /*
     AccountExist = 0,
     AccountNotExist = 1,
     AuthCodeError = 2,
     AuthCodeExpired = 3,
     AuthBlocked = 4,
     UnknownReason = 5,
     */
    NSLog(@"%@菊风登录失败==%d",[GlobalSingle userMobile],reason);
    [self showPromptInformation:[NSString stringWithFormat:@"%@菊风登录失败==%d",[GlobalSingle userMobile],reason]];
    
}
- (void)justalkLogoutOk//注销完成回调
{
    NSLog(@"JusTalkManagerDelegate*****%@",[NSThread currentThread]);

    NSLog(@"%@ 账号已注销",[GlobalSingle userMobile]);
}
- (void)justalkLogouted//被异地登录回调
{
    NSLog(@"JusTalkManagerDelegate*****%@",[NSThread currentThread]);

    NSLog(@"%@ 账号在其他地方登录过",[GlobalSingle userMobile]);
    [self showPromptInformation:[NSString stringWithFormat:@"%@账号在其他地方登录过",[GlobalSingle userMobile]]];
    
}

//创建会议回调
- (void)justalkCreateConferenceOk:(NSString *)roomid{
   
    _mtcConfNumber = roomid;
    UITextField *tf = (UITextField *)[self.view viewWithTag:111];
    tf.text = _mtcConfNumber;
    NSLog(@"roomid$$$$$$$$$$$$$%@",_mtcConfNumber);

}
- (void)justalkCreateConferenceFail:(NSString *)reason
{
   
}
//查询会议回调
- (void)justalkQueryConferenceOk:(NSDictionary *)dic
{
    [justManager joinMeetingWithConfUri:[dic objectForKey:@"MtcConfUriKey"]];
}
- (void)justalkQueryConferenceFail:(NSString *)reason
{

    [self showPromptInformation:[NSString stringWithFormat:@"因为 %@ 查询会议失败",reason]];
    
}
//自己加入会议回调
- (void)justalkJoinConferenceOk:(NSDictionary *)userInfo
{
    NSLog(@"justalkJoinConferenceOk");
    if (!participantModelArray) {
        participantModelArray = [[NSMutableArray alloc] init];
        
    }
    
    //会议信息
    _mtcConfNumber = userInfo[@"MtcConfNumberKey"];
    _mtcConfUri = userInfo[@"MtcConfUriKey"];
    _mtcConfId = userInfo[@"MtcConfIdKey"];
    for (NSDictionary *dic in [userInfo objectForKey:@"MtcConfPartpLstKey"]) {
        ParticipantModel *model = [[ParticipantModel alloc] init];
        model.meetingUri = userInfo[@"MtcConfUriKey"];
        model.meetingid = userInfo[@"MtcConfIdKey"];
        model.meetingRoomid = userInfo[@"MtcConfNumberKey"];
        model.userUri = dic[@"MtcConfUserUriKey"];
        model.username = dic[@"MtcConfDisplayNameKey"];
        model.confState = [dic[@"MtcConfStateKey"] integerValue];
        model.roleId = [dic[@"MtcConfRoleKey"] integerValue];
        model.nickName = @"";
        model.picSize = MTC_CONF_PS_LARGE; //清晰度 自己的设置无效

        model.frameRate = 15;//每秒帧数
        model.sended = NO;
        model.volume = 30;
        model.nickName = model.username;
        
        if ([model.username isEqualToString:_teacherModel.teacher_mobile]) {
            model.isExpert = YES;
            expertParticipant = model;
            expertParticipant.nickName = _teacherModel.teacher_user_name;

        } else {
            
            model.isExpert = NO;
            if ([model.username isEqualToString:[GlobalSingle userMobile]]) {
                model.isSelf = YES;
                model.angle = 270;
                
                
            } else {
                model.isSelf = NO;
                
            }
            
            [participantModelArray addObject:model];
            
        }
        
        
        
    }

    //对应昵称
    if (_students.count) {
        
        [self uptadeNickName];
    }
    
    isJoinConf = YES;
    
}
- (void)justalkJoinConferenceFail:(NSString *)reason
{
    NSLog(@"JusTalkManagerDelegate*****%@",[NSThread currentThread]);

    [self showPromptInformation:[NSString stringWithFormat:@"因为 %@ 加入会议失败",reason]];
}
- (void)justalkDidLeaveConference:(EN_MTC_CONF_REASON_TYPE)reason
{
    NSLog(@"JusTalkManagerDelegate*****%@",[NSThread currentThread]);

    switch (reason) {
        case EN_MTC_CONF_REASON_LEAVED:
            [self showPromptInformation:@"主动离开房间"];
            break;
        case EN_MTC_CONF_REASON_KICKED:
            [self showPromptInformation:@"被请出房间"];
            break;
        case EN_MTC_CONF_REASON_OFFLINE:
            [self showPromptInformation:@"因为离线离开房间"];
            break;
        case EN_MTC_CONF_REASON_OVER:
            [self showPromptInformation:@"因为会议结束离开房间"];
            break;
            
        default:
            [self showPromptInformation:@"不明原因离开房间"];
            
            break;
    }
    
}
//有成员加入或离开会议回调
- (void)justalkOtherJoinConference:(NSDictionary *)user
{
    NSLog(@"有成员加入会议");
    ParticipantModel *model = [[ParticipantModel alloc] init];
    model.userUri = user[@"MtcConfUserUriKey"];
    model.username = user[@"MtcConfDisplayNameKey"];
    model.confState = [user[@"MtcConfStateKey"] integerValue];
    model.roleId = [user[@"MtcConfRoleKey"] integerValue];
    model.nickName = @"";
    if ([model.username isEqualToString:[GlobalSingle userMobile]]) {
        model.isSelf = YES;
    } else {
        model.isSelf = NO;
    }
    
    model.picSize = MTC_CONF_PS_LARGE;
    model.frameRate = 15;
    model.sended = NO;
    model.volume = 30;
    if ([model.username isEqualToString:_teacherModel.teacher_mobile]) {
        model.isExpert = YES;
        expertParticipant = model;
        expertParticipant.nickName = _teacherModel.teacher_user_name;
        if (!isRootview) {
            [broadcastliveVC expertAddMeeting:model];
        }
   
    } else {
        model.isExpert = NO;
        if ([model.username isEqualToString:[GlobalSingle userMobile]]) {
            model.isSelf = YES;
            model.angle = 270;
                    
        } else {
            model.isSelf = NO;
            
        }
        
        [self uptadeNickNameWith:model];
        [participantModelArray addObject:model];
       
        if (isRootview) {
            [_theTableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]]withRowAnimation:UITableViewRowAnimationAutomatic];
            
        } else {
        
            [broadcastliveVC studentAddMeeting:model];
        }

        
    }
    
    
}
- (void)justalkOtherLeaveConference:(NSDictionary *)user
{
    NSLog(@"有成员离开会议");
    for (ParticipantModel *model in participantModelArray) {
        if ([user[@"MtcConfDisplayNameKey"] isEqualToString:model.username]) {
            if (!isRootview) {
                [broadcastliveVC otherLeaveMeeting:model];
            }
            
            [participantModelArray removeObject:model];

            return;
        }
    }
    
}
#pragma mark end

#pragma mark ====对应妮称
- (void)uptadeNickName
{
    for (int i = 0 ; i < participantModelArray.count; i ++) {
        ParticipantModel *model = [participantModelArray objectAtIndex:i];
        [self uptadeNickNameWith:model];
        for (StudentModel *stu in _students) {
            if ([stu.mobile isEqualToString:model.username]) {
                stu.juskOnlineState = YES;
                model.nickName = stu.user_name;
            }
        }
    }
    
    
    if (isRootview) {
        [_theTableview reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]]withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}

- (void)uptadeNickNameWith:(ParticipantModel *)model
{
    for (StudentModel *stu in _students) {
        if ([stu.mobile isEqualToString:model.username]) {
            stu.juskOnlineState = YES;
            model.nickName = stu.user_name;
        }
    }
        
}



#warning 提示
- (void)showPromptInformation:(NSString *)prompt
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"提示" message:prompt delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    [view show];
}





@end
