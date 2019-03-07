//
//  CKTimePickerView.m
//  BasicFrame
//
//  Created by shenyong on 2019/1/16.
//  Copyright © 2019年 CaiKe. All rights reserved.
//

#import "CKTimePickerView.h"

@interface CKTimePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) NSMutableArray *hourArray;
@property (nonatomic,strong) NSMutableArray *minuteArray;
@property (nonatomic,copy) NSString *pickHour;
@property (nonatomic,copy) NSString *pickMinute;
@end

@implementation CKTimePickerView

- (void)awakeFromNib{
    [super awakeFromNib];
    _hourArray = [NSMutableArray array];
    _minuteArray = [NSMutableArray array];
  
    for (int i = 0; i < 24; i ++) {
        [_hourArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 0; i < 60; i ++) {
         [_minuteArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    _pickHour = @"00";
    _pickMinute = @"00";
    _timePicker.delegate = self;
    _timePicker.dataSource = self;
}

#pragma mark -- UIPickerViewDelegate


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return component==0?_hourArray.count:_minuteArray.count;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view{
    
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:15]];
    }
  
    customLabel.textColor = RGB16(0x2F3E5C);
    
    NSInteger str = component==0?[_hourArray[row] integerValue]:[_minuteArray[row] integerValue];
    
    customLabel.text = [NSString stringWithFormat:@"%02ld",(long)str];
    
    return customLabel;
    
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        NSInteger pickIn = [_hourArray[row] integerValue];
        _pickHour = [NSString stringWithFormat:@"%02ld",pickIn];
    }else if (component == 1){
        NSInteger pickIn = [_minuteArray[row] integerValue];
        _pickMinute = [NSString stringWithFormat:@"%02ld",pickIn];
    }
}

- (void)show{
    self.alpha = 0;
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 1;
    }];
    
}
- (void)hide{
    
    [UIView animateWithDuration:.35 animations:^{
        self.alpha = 0.0;
    }completion:^(BOOL finished) {
        if (finished){
            [self removeFromSuperview];
        }
    }];
}

//- (IBAction)cancelClick:(id)sender {
//
//    [self hide];
//}
//- (IBAction)sureClick:(id)sender {
//
//    if (self.timePickerSelectBlock) {
//        self.timePickerSelectBlock([NSString stringWithFormat:@"%@:%@",_pickHour,_pickMinute]);
//    }
//    [self hide];
//}
- (IBAction)sureClick:(id)sender {
    if (self.timePickerSelectBlock) {
        self.timePickerSelectBlock([NSString stringWithFormat:@"%@:%@",_pickHour,_pickMinute],_pickHour,_pickMinute);
    }
    [self hide];

}

#pragma mark --touch even
//隐藏方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"点我");
    CGPoint point=[[touches anyObject]locationInView:self];
    CALayer *layer=[self.backView.layer hitTest:point];
    if (layer == nil) {
        [self hide];
    }
}


@end
