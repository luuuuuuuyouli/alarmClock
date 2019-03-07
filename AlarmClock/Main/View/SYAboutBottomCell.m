//
//  SYAboutBottomCell.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYAboutBottomCell.h"
#import "SYFamusItemCell.h"

@interface SYAboutBottomCell ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *upButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSArray *dataSource;
@end

@implementation SYAboutBottomCell

- (void)awakeFromNib {
    [super awakeFromNib];
     _upButton.selected = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 100;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    [_tableView registerNib:[UINib nibWithNibName:@"SYFamusItemCell" bundle:nil] forCellReuseIdentifier:@"SYFamusItemCellID"];
    [self reloadData];
    
}
- (void)reloadData{
    _dataSource = @[@"None is of freedom or of life deserving unless he daily conquers it anew. -Erasmus",
                    @"Our destiny offers not the cup of despair, but the chalice of opportunity. So let us seize it, not in fear, but in gladness. -- R.M. Nixon",
                    @"There is no such thing as a great talent without great will - power. -- Balzac",
                    @"I might say that success is won by three things:first, effort; second, more effort; third, still more effort.",
                    @"Only those who have the patience to do simple things perfectly ever acquire the skill to do difficult things easily.",
                    @"Few things are impossible in themselves; and it is often for want of will ,rather than of means, that man fails to succeed.",
                    @"Ideal is the beacon. Without ideal,there is no secure direction; without direction ,there is no life."
                    ];
    [self.tableView reloadData];
}
#pragma mark -- UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SYFamusItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYFamusItemCellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentLabel.text = _dataSource[indexPath.row];
    return cell;
}
- (IBAction)upClick:(id)sender {
    
    
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
