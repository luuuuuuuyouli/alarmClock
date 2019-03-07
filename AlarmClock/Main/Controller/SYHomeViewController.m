//
//  SYHomeViewController.m
//  AlarmClock
//
//  Created by syong on 2019/3/7.
//  Copyright © 2019年 syong. All rights reserved.
//

#import "SYHomeViewController.h"
#define kClockW _clockView.bounds.size.width

#define angle2radion(angle) ((angle) / 180.0 * M_PI)

// 1秒6度(秒针)
#define perSecondA 6

// 1分钟6度(分针)

#define perMintueA 6

// 1小时30度（时针）

#define perHourA 30

// 每分钟时针转(30 / 60 °)

#define perMinHourA 0.5

@interface SYHomeViewController ()

@property (nonatomic,strong) UIImageView *clockView;

@property (nonatomic,weak) CALayer * secondLayer;

@property (nonatomic,weak) CALayer * mintueLayer;

@property (nonatomic,weak) CALayer * hourLayer;

@property (weak, nonatomic) IBOutlet UILabel *amLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic,copy) NSArray *monthArray;
@property (nonatomic,copy) NSArray *weekArray;

@end

@implementation SYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加时钟背景图片
    
    _clockView = [[UIImageView alloc]initWithFrame:CGRectMake(81, kNavBarAndStatusBarHeight+80, 216, 214)];
    
    _clockView.image = [UIImage imageNamed:@"clock_back"];
    
    [self.view addSubview:_clockView];
    
    // 添加时针
    [self setUpHourLayer];
    // 添加分针
    [self setUpMinuteLayer];
    // 添加秒针
    [self setUpSecondLayer];
    //添加定时器
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
    
    //初始数据
    _monthArray = @[@"JANUARY",@"FEBRUARY",@"MARCH",@"APRIL",@"MAY",@"JUNE",@"JULY",@"AUGUST",@"SEPTEMBER",@"OCTOBER",@"NOVEMBER",@"DECEMBER"];
    _weekArray = @[@"SUNDAY",@"MONDAY",@"TUESDAY",@"WEDNESDAY",@"THURSDAY",@"FRIDAY",@"SATURDAY"];
    [self timeChange];
    
}

- (void)timeChange{
    
    // 获取当前系统时间
    
    NSCalendar * calender = [NSCalendar currentCalendar];
    
    NSDateComponents * cmp = [calender components:NSCalendarUnitSecond | NSCalendarUnitMinute | NSCalendarUnitHour | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitMonth | NSCalendarUnitYear   fromDate:[NSDate date]];
    
    CGFloat second = cmp.second;
    
    CGFloat secondA = (second * perSecondA) ;
    
    NSInteger minute = cmp.minute;
    
    CGFloat mintuteA = minute * perMintueA ;
    
    NSInteger hour = cmp.hour;
    //年
    NSInteger year = cmp.year;
    //月
    NSInteger month = cmp.month;
    //日
    NSInteger day = cmp.day;
    //星期
    NSInteger week = cmp.weekday;
    
   // NSLog(@"%ld - %ld -%ld - %ld",year,month,day,week);
   
    _dateLabel.text = [NSString stringWithFormat:@"%@    %02ld    %@    %ld",_weekArray[week],day,_monthArray[month],year];
    
    CGFloat hourA = hour * perHourA  + minute * perMinHourA;
    
    _timeLabel.text = [NSString stringWithFormat:@"%02ld : %02ld",hour,minute];
    
    _secondLayer.transform = CATransform3DMakeRotation(angle2radion(secondA), 0, 0, 1);
    
    _mintueLayer.transform = CATransform3DMakeRotation(angle2radion(mintuteA), 0, 0, 1);
    
    _hourLayer.transform = CATransform3DMakeRotation(angle2radion(hourA), 0, 0, 1);
}

#pragma mark - 添加秒针

- (void)setUpSecondLayer{
    
    CALayer * secondL = [CALayer layer];
    
    secondL.backgroundColor = RGB16(0x2F3E5C).CGColor ;
    
    // 设置锚点
    
    secondL.anchorPoint = CGPointMake(0.5, 1);
    
    secondL.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    secondL.bounds = CGRectMake(0, 0, 1, kClockW * 0.5 - 20);
    
    
    [_clockView.layer addSublayer:secondL];
    
    _secondLayer = secondL;
}

#pragma mark - 添加分针

- (void)setUpMinuteLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = RGB16(0x2F3E5C).CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 20);
    
  //  layer.cornerRadius = 4;
    
    [_clockView.layer addSublayer:layer];
    
    _mintueLayer = layer;
}

#pragma mark - 添加时针

- (void)setUpHourLayer{
    
    CALayer * layer = [CALayer layer];
    
    layer.backgroundColor = RGB16(0x2F3E5C).CGColor ;
    
    // 设置锚点
    
    layer.anchorPoint = CGPointMake(0.5, 1);
    
    layer.position = CGPointMake(kClockW * 0.5, kClockW * 0.5);
    
    layer.bounds = CGRectMake(0, 0, 4, kClockW * 0.5 - 40);
    
   // layer.cornerRadius = 4;
    
    [_clockView.layer addSublayer:layer];
    
    _hourLayer = layer;
}


@end
