//
//  SYClockBottomCell.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYClockBottomCell.h"
#import "SYClockItemCell.h"
#import "SYClockModel.h"

@interface SYClockBottomCell()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *upButton;

@end

@implementation SYClockBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _upButton.selected = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    [_tableView registerNib:[UINib nibWithNibName:@"SYClockItemCell" bundle:nil] forCellReuseIdentifier:@"SYClockItemCellID"];
}

- (void)setDataSource:(NSMutableArray *)dataSource{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SYClockItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYClockItemCellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataSource[indexPath.row];
    cell.index = indexPath.row;
    return cell;
}
- (IBAction)upButtonClick:(id)sender {
    
    NSInteger index = 0;
    
    if (_upButton.selected) {
        [_upButton setImage:[UIImage imageNamed:@"shangla"] forState:0];
        _upButton.selected = NO;
        index = 1;
    }else{
        [_upButton setImage:[UIImage imageNamed:@"down"] forState:0];
         _upButton.selected = YES;
        index = 0;
    }

    if (self.upBlcok) {
        self.upBlcok(index);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
