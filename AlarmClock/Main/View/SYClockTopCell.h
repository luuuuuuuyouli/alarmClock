//
//  SYClockTopCell.h
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^addNewClockBlock)(void);

@interface SYClockTopCell : UITableViewCell

@property (nonatomic,strong) addNewClockBlock addNewClockBlock;

@end

NS_ASSUME_NONNULL_END
