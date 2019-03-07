//
//  SYFamusItemCell.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYFamusItemCell.h"

@interface SYFamusItemCell ()

@property (weak, nonatomic) IBOutlet UIView *backView;



@end

@implementation SYFamusItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
     [_backView setLayerShadowWith:RGB16(0xE3E7EB) offset:2 radius:4 shadowOpacity:0.4];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
