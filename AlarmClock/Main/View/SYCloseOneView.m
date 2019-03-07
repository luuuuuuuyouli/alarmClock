//
//  SYCloseOneView.m
//  AlarmClock
//
//  Created by shenyong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYCloseOneView.h"

@interface SYCloseOneView()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textView;

@end

@implementation SYCloseOneView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    _textView.delegate = self;
}

- (IBAction)sureClick:(id)sender {
    
    if ([_textView.text isEqualToString:@"I'm awake now"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"stopMusic" object:nil];
        [self removeFromSuperview];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([_textView.text isEqualToString:@"I'm awake now"]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:@"stopMusic" object:nil];
        [self removeFromSuperview];
    }
    return YES;
}



@end
