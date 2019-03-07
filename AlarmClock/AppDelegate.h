//
//  AppDelegate.h
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
// iOS10 注册 APNs 所需头文件

#define KNotificationActionIdentifileStar @"knotificationActionIdentifileStar"
#define KNotificationActionIdentifileComment @"kNotificationActionIdentifileComment"
#define KNotificationCategoryIdentifile @"KNOtificationCategoryIdentifile"

#import <UserNotifications/UserNotifications.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(nonatomic,strong) AVAudioPlayer * player;
@property (strong, nonatomic) UIWindow *window;


@end

