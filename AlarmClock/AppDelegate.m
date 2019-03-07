//
//  AppDelegate.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "AppDelegate.h"
#import "BasicTabBarViewController.h"
#import "SYCloseOneView.h"
#import "SYClockModel.h"
#import "SYTimeStamp.h"


@interface AppDelegate ()

@property(nonatomic,strong) NSTimer * timer;  //定时器
@property (nonatomic,assign) NSInteger coutNumber;

@property(nonatomic,strong) UIMutableUserNotificationCategory* categorys;

@property (nonatomic,strong) SYCloseOneView *stopView;

@property (nonatomic,assign)  NSInteger minInt;

@property (nonatomic,assign)  NSInteger minIndex;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[BasicTabBarViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    [self action_beginCount];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(stopMusic) name:@"stopMusic" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(action_beginCount) name:@"beginCountDown" object:nil];
    
    return YES;
}

- (void)action_beginCount{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSArray *list = [SYClockModel mj_objectArrayWithKeyValuesArray:[defaults valueForKey:@"clock"]];
    if (list.count < 1) {
        return;
    }
    SYClockModel *model = list[0];
    NSInteger firstInt = [SYTimeStamp timeSwitchTimestamp:model.date andFormatter:@"yyyy-MM-dd HH:mm"];
    _minInt = firstInt;
    
    for (int i = 0; i < list.count; i ++) {
        //获取闹钟时间戳
        SYClockModel *model = list[i];
        if (model.isOpen == 1) {
            //只判断开启状态的
            NSInteger dateInt = [SYTimeStamp timeSwitchTimestamp:model.date andFormatter:@"yyyy-MM-dd HH:mm"];
            NSLog(@"闹钟时间戳---%ld",dateInt);
            if (_minInt > dateInt) {
                //获取最小时间戳 即最近闹钟响应时刻
                _minInt = dateInt;
                _minIndex = i;
            }
        }
    }
   
    
    NSInteger nowInt = [SYTimeStamp getNowTimestamp];
    NSLog(@"现在时间戳 === %ld",nowInt);
    NSInteger difference = _minInt - nowInt;
    _coutNumber = difference;

    [_timer invalidate];
    _timer = nil;
    
    if (_coutNumber < 0) {
        return;
    }
    
    if (_timer == nil) {
        //每隔1秒刷新一次页面
        _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runAction) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantPast]];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        NSLog(@"开始倒计时.....");
    }
    else
    {
        [_timer setFireDate:[NSDate distantPast]];
    }
    
}

- (void)runAction{
    
    _coutNumber -- ;
    NSLog(@"倒计时 --- %ld",_coutNumber);
    if (_coutNumber == 0) {
        //后台播放音频设置
        AVAudioSession *session = [AVAudioSession sharedInstance];
        
        [session setActive:YES error:nil];
        
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        //让app支持接受远程控制事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
        //提示框弹出的同时，开始响闹钟
        
        NSString * path=[[NSBundle mainBundle]pathForResource:@"Chima - urar.mp3" ofType:nil];
        
        NSURL * url = [NSURL fileURLWithPath:path];
        
        NSError * error;
        
        _player = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        
        _player.numberOfLoops=-1;    //无限循环  =0 一遍   =1 两遍    =2 三遍     =负数  单曲循环
        
        _player.volume=2;          //音量
    
        [_player prepareToPlay];    //准备工作
        
        [_timer setFireDate:[NSDate distantFuture]];
        
        [_player play];
        [self loadStopView];
        [self registerLocalNotification];
    }
    
}
- (void)registerLocalNotification{
    UIMutableUserNotificationAction* action1 = [[UIMutableUserNotificationAction alloc] init];
    
    action1.identifier = KNotificationActionIdentifileStar;
    action1.authenticationRequired = NO;
    action1.destructive = NO;
    action1.activationMode = UIUserNotificationActivationModeBackground;
    action1.title = @"Five minutes of sleep";
//    UIMutableUserNotificationAction* action2 = [[UIMutableUserNotificationAction alloc] init];
    
//    action2.identifier = KNotificationActionIdentifileComment;
//    action2.title = @"关闭闹钟";
//    action2.authenticationRequired = NO;
//    action2.destructive = NO;
//    action2.activationMode = UIUserNotificationActivationModeBackground;
    
    self.categorys = [[UIMutableUserNotificationCategory alloc] init];
    self.categorys.identifier = KNotificationCategoryIdentifile;
    [self.categorys setActions:@[action1] forContext:UIUserNotificationActionContextDefault];
    
    UIUserNotificationSettings* newSetting= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:self.categorys]];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:newSetting];
    
    if(newSetting.types==UIUserNotificationTypeNone){
       
        UIUserNotificationSettings* newSetting= [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:[NSSet setWithObject:self.categorys]];
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:newSetting];
    }else{
      
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [self addLocalNotification];
    }
}
#pragma mark 添加本地通知
- (void) addLocalNotification{
    
    [UIApplication sharedApplication].delegate = self;
    UILocalNotification * notification=[[UILocalNotification alloc] init];
    
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:0];
    
    notification.alertBody=@"The alarm clock rang！";
    
    notification.repeatInterval=NSCalendarUnitDay;
    
    notification.applicationIconBadgeNumber=1;
    notification.hasAction = YES;
    notification.category = KNotificationCategoryIdentifile;
    
    notification.userInfo=@{@"name":@"shenyong"};
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    
    
}
//在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler NS_AVAILABLE_IOS(8_0) __TVOS_PROHIBITED{
    NSLog(@"+++++++++++++++++++++++");
    if ([identifier isEqualToString:KNotificationActionIdentifileStar]) {
        [application cancelAllLocalNotifications];

        [_player stop];
        _coutNumber = 5*60;
        [_timer setFireDate:[NSDate distantPast]];


        NSLog(@"----------");
    } else if ([identifier isEqualToString:KNotificationActionIdentifileComment]) {

        [application cancelAllLocalNotifications];

        [_player stop];

        NSLog(@"++++++++++");

    }

    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"noti:%@",notification);
    // 图标上的数字设置为0
    NSLog(@"noti: %@",notification.userInfo);
    application.applicationIconBadgeNumber = 0;
}

- (void)applicationWillResignActive:(UIApplication *)application {
   
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{            if (bgTask != UIBackgroundTaskInvalid)
        {
            bgTask = UIBackgroundTaskInvalid;
        }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{            if (bgTask != UIBackgroundTaskInvalid)
        {
            bgTask = UIBackgroundTaskInvalid;
        }
        });
    });
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark --  closeView
- (void)loadStopView{
    
    if (!_stopView) {
        _stopView = [[NSBundle mainBundle]loadNibNamed:@"SYCloseOneView" owner:nil options:nil].lastObject;
        _stopView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        _stopView.backgroundColor = rgba(19, 19, 19, 0.8);
    }
    
    [[[UIApplication sharedApplication]keyWindow]addSubview:_stopView];

}
//通过任务后关闭闹钟
- (void)stopMusic{
    
    [_player stop];
    [_timer invalidate];
     _timer = nil;
    //将已经响应了的闹钟 日期往后加一天
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSArray *list = [defaults valueForKey:@"clock"];
    
    NSMutableArray *mutArray = [NSMutableArray array];
    [mutArray addObjectsFromArray:list];
    
    if (mutArray.count > _minIndex) {
        NSDictionary *dic = mutArray[_minIndex];
        //修改日期
        NSString *towDay1 = [dic[@"date"] dateToGetsecondDay:@"yyyy-MM-dd"];
        
        NSString  *towDay = [NSString stringWithFormat:@"%@ %@",towDay1,dic[@"time"]];
        
        NSMutableDictionary *mutDic = [NSMutableDictionary dictionary];
        mutDic = [dic mutableCopy];
        mutDic[@"date"] = towDay;
        
        [mutArray replaceObjectAtIndex:_minIndex withObject:mutDic];
        [defaults setObject:mutArray forKey:@"clock"];
    }
    
    [self action_beginCount];
   

}


@end
