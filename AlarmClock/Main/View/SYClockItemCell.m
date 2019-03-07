//
//  SYClockItemCell.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYClockItemCell.h"

@interface SYClockItemCell()

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIButton *switchBtn;
@property (weak, nonatomic) IBOutlet UIButton *delButton;

@end

@implementation SYClockItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _backView.layer.cornerRadius = 6;
    _delButton.hidden = YES;
    [_backView setLayerShadowWith:RGB16(0xE3E7EB) offset:2 radius:4 shadowOpacity:0.4];
    _selectBtn.selected = NO;
}
- (void)setModel:(SYClockModel *)model{
    _model = model;
    _selectBtn.selected = NO;
    [_selectBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:0];
    
    _delButton.hidden = YES;
    _delButton.alpha = 1;
    
    _switchBtn.hidden = NO;
    _switchBtn.alpha = 1;
    
    _timeLabel.text = _model.time;
    if (_model.isOpen == 1) {
        [_switchBtn setImage:[UIImage imageNamed:@"kaiqi"] forState:0];
    }else{
        [_switchBtn setImage:[UIImage imageNamed:@"guanbi"] forState:0];
    }
}
- (IBAction)slectBtnClick:(id)sender {
    
    UIButton *btn = (UIButton *)sender;
    
    if (btn.selected) {
        [_selectBtn setImage:[UIImage imageNamed:@"weixuanzhong"] forState:0];
        btn.selected = NO;
        WeakSelf
        _delButton.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.delButton.alpha = 0;
            weakSelf.switchBtn.hidden = NO;
        }completion:^(BOOL finished) {
            weakSelf.delButton.hidden = YES;
        }];
    
    }else{
        [_selectBtn setImage:[UIImage imageNamed:@"xuanzhong"] forState:0];
        btn.selected = YES;
        WeakSelf
        _delButton.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            weakSelf.delButton.alpha = 1;
        }completion:^(BOOL finished) {
            weakSelf.switchBtn.hidden = YES;
            weakSelf.delButton.hidden = NO;
        }];
    }
    
}
- (IBAction)switchBtnClick:(UIButton *)sender {
    
    if (_model.isOpen == 1) {
         [_switchBtn setImage:[UIImage imageNamed:@"guanbi"] forState:0];
        _model.isOpen = 0;
    }else{
        [_switchBtn setImage:[UIImage imageNamed:@"kaiqi"] forState:0];
        _model.isOpen = 1;
    }
    NSDictionary *dic = @{@"index":@(_index),@"status":@(_model.isOpen)};
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"changeClockStatus" object:dic];
    
}
- (IBAction)delButtonClick:(id)sender {
    
     [[NSNotificationCenter defaultCenter]postNotificationName:@"delClock" object:@(_index)];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
