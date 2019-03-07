//
//  SYClockViewController.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYClockViewController.h"
#import "SYClockTopCell.h"
#import "SYClockBottomCell.h"
#import "SYClockModel.h"
#import "CKTimePickerView.h"

@interface SYClockViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
//时间选择器
@property (nonatomic,strong) CKTimePickerView *timePickerView;
@property (nonatomic,assign) NSInteger cellNumber;
//现在时间
@property (nonatomic,assign) NSInteger year;
@property (nonatomic,assign) NSInteger month;
@property (nonatomic,assign) NSInteger day;
@property (nonatomic,assign) NSInteger hour;
@property (nonatomic,assign) NSInteger minute;

@end

@implementation SYClockViewController

- (CKTimePickerView *)timePickerView{
    if (!_timePickerView) {
        _timePickerView = [[NSBundle mainBundle]loadNibNamed:@"CKTimePickerView" owner:nil options:nil].lastObject;
        _timePickerView.frame = CGRectMake(0, 0, SCREEN_W, SCREEN_H);
        _timePickerView.backgroundColor = rgba(150, 150, 150, 0.6);
    }
    return _timePickerView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getNowDate];
    [self reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _cellNumber = 1;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 0;
    [_tableView registerNib:[UINib nibWithNibName:@"SYClockTopCell" bundle:nil] forCellReuseIdentifier:@"SYClockTopCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"SYClockBottomCell" bundle:nil] forCellReuseIdentifier:@"SYClockBottomCellID"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeStatus:) name:@"changeClockStatus" object:nil];

     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(delClock:) name:@"delClock" object:nil];
   
}
- (void)getNowDate{
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear   fromDate:[NSDate date]];
    
    _year = cmp.year;
    _month = cmp.month;
    _day = cmp.day;
    _hour = cmp.hour;
    _minute = cmp.minute;
}

- (void)reloadData{
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSArray *list = [SYClockModel mj_objectArrayWithKeyValuesArray:[defaults valueForKey:@"clock"]];
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:list];
    [self.tableView reloadData];
}
- (void)delClock:(NSNotification *)sender{
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
    NSArray *dataList = [defaults valueForKey:@"clock"];
    NSMutableArray *dataArr = [NSMutableArray array];
    [dataArr addObjectsFromArray:dataList];
    NSInteger index = [sender.object integerValue];
    if (dataArr.count > index) {
        [dataArr removeObjectAtIndex:index];
    }
     [defaults setValue:dataArr forKey:@"clock"];
    [self reloadData];
    
}
- (void)changeStatus:(NSNotification *)sender{
    NSDictionary *dic = sender.object;
    if (dic) {
        NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
        NSArray *dataList = [defaults valueForKey:@"clock"];
        NSMutableArray *dataArr = [NSMutableArray array];
        [dataArr addObjectsFromArray:dataList];
        
        NSInteger index = [[dic valueForKey:@"index"] integerValue];
       
        if (dataArr.count > index) {
            NSMutableDictionary *pramDic = [dataArr[index] mutableCopy];
            
            pramDic[@"isOpen"] =  [dic valueForKey:@"status"];
            [dataArr replaceObjectAtIndex:index withObject:pramDic];
            [defaults setValue:dataArr forKey:@"clock"];
            
        }
    }
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
    if (indexPath.section == 0) {
        return 340;
    }
    return self.dataArray.count * 63 + 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SYClockTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYClockTopCellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WeakSelf
        cell.addNewClockBlock = ^{
            [weakSelf.timePickerView show];
            weakSelf.timePickerView.timePickerSelectBlock = ^(NSString * _Nonnull time, NSString * _Nonnull hour, NSString * _Nonnull minute) {
                NSLog(@"%@",time);
                 NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                if ([hour integerValue] > weakSelf.hour) {
                    //选择小时比现在大,则当天响
                    //存储闹钟具体响应时间
                    dic[@"date"] = [NSString stringWithFormat:@"%ld-%02ld-%02ld %@:%@", weakSelf.year,weakSelf.month,weakSelf.day,hour,minute];
                }else if([hour integerValue] < weakSelf.hour){
                    //选择小时比现在小,则表示第二天响
                    NSString *nowDay = [NSString stringWithFormat:@"%ld-%ld-%ld",weakSelf.year,weakSelf.month,weakSelf.day];
                    //获取第二天日期
                    NSString *towDay = [nowDay dateToGetsecondDay:@"yyyy-MM-dd"];
                    dic[@"date"] = [NSString stringWithFormat:@"%@ %@:%@",towDay,hour,minute];
                    
                }else{
                    //选择小时等于现在小时，则判断分钟
                    if ([minute integerValue] > weakSelf.minute) {
                        //选择分钟比现在大 则等下就响
                        dic[@"date"] = [NSString stringWithFormat:@"%ld-%02ld-%02ld %@:%@", weakSelf.year,weakSelf.month,weakSelf.day,hour,minute];
                    }else{
                        //否则第二天
                        NSString *nowDay = [NSString stringWithFormat:@"%ld-%ld-%ld",weakSelf.year,weakSelf.month,weakSelf.day];
                        //获取第二天日期
                        NSString *towDay = [nowDay dateToGetsecondDay:@"yyyy-MM-dd"];
                        dic[@"date"] = [NSString stringWithFormat:@"%@ %@:%@",towDay,hour,minute];
                    }
                    
                }
                
                NSUserDefaults *defaults = [[NSUserDefaults alloc]init];
                
                NSMutableArray *mutArray = [NSMutableArray array];
                NSArray *arr = [defaults valueForKey:@"clock"];
                [mutArray addObjectsFromArray:arr];
        
                dic[@"time"] =  time;
                dic[@"isOpen"] = @1;
                
                [mutArray addObject:dic];
                [defaults setValue:mutArray forKey:@"clock"];
                
                [[NSNotificationCenter defaultCenter]postNotificationName:@"beginCountDown" object:nil];
                
                [weakSelf reloadData];
            };
        };
        return cell;
    }
    SYClockBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYClockBottomCellID"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataSource = self.dataArray;
    WeakSelf
    cell.upBlcok = ^(NSInteger type) {
        weakSelf.cellNumber = type;
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    };
    return cell;
}


@end
