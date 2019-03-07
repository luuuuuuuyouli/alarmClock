//
//  SYAboutBottomCell.h
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^upBlcok)(NSInteger type);

@interface SYAboutBottomCell : UITableViewCell
@property (nonatomic,strong) upBlcok upBlcok;
@end

NS_ASSUME_NONNULL_END
