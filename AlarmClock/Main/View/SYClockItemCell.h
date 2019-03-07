//
//  SYClockItemCell.h
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SYClockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SYClockItemCell : UITableViewCell

@property (nonatomic,strong) SYClockModel *model;
@property (nonatomic,assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
