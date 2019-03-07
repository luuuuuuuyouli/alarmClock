//
//  CKTimePickerView.h
//  BasicFrame
//
//  Created by shenyong on 2019/1/16.
//  Copyright © 2019年 CaiKe. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^timePickerSelectBlock)(NSString *time,NSString *hour,NSString *minute);

@interface CKTimePickerView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@property (nonatomic,strong) timePickerSelectBlock timePickerSelectBlock;
//显示
- (void)show;
//消失
- (void)hide;

@end

NS_ASSUME_NONNULL_END
