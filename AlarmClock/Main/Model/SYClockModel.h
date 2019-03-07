//
//  SYClockModel.h
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYClockModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,assign) NSInteger isOpen;
@property (nonatomic,copy) NSString *date;

@end

NS_ASSUME_NONNULL_END
