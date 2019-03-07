//
//  SYAboutViewController.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYAboutViewController.h"
#import "SYAboutTopCell.h"
#import "SYAboutBottomCell.h"

@interface SYAboutViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,assign) NSInteger cellNumber;

@end

@implementation SYAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     _cellNumber = 1;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    [_tableView registerNib:[UINib nibWithNibName:@"SYAboutTopCell" bundle:nil] forCellReuseIdentifier:@"SYAboutTopCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"SYAboutBottomCell" bundle:nil] forCellReuseIdentifier:@"SYAboutBottomCellID"];
}

#pragma mark -- UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return _cellNumber;
    }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CGFloat navH = kNavAndTabHeight;
        CGFloat SCH = SCREEN_H;
        return _cellNumber==1?320:SCH-navH;
    }
    return 320;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SYAboutTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYAboutTopCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    SYAboutBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYAboutBottomCellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    WeakSelf
    cell.upBlcok = ^(NSInteger type) {
        weakSelf.cellNumber = type;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}



@end
