//
//  SYTimeStamp.h
//  AlarmClock
//
//  Created by shenyong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYTimeStamp : NSObject


///**
// * 将某个时间转化成 时间戳
// */
+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;


//获取当前系统时间的时间戳
+ (NSInteger)getNowTimestamp;

@end

NS_ASSUME_NONNULL_END
