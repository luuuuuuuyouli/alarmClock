//
//  BasicTabBarViewController.m
//  basisProject
//
//  Created by shenyong on 2019/2/27.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import "BasicTabBarViewController.h"
#import "BasicNavViewController.h"
#import "SYHomeViewController.h"
#import "SYClockViewController.h"
#import "SYAboutViewController.h"


@interface BasicTabBarViewController ()

@end

@implementation BasicTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置未选中颜色
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:RGB16(0x939BAF)} forState:UIControlStateNormal];
    ////2.设置tabbar的背景
    self.tabBar.tintColor = RGB16(0x745BEE);

    [self addChild];
    
    [UITabBar appearance].translucent = NO;
}
- (void)addChild{
    
    SYHomeViewController *homeVC = [[SYHomeViewController alloc]init];
    [self addChildViewController:homeVC withNormalImage:@"icon_time" selectedImage:@"icon_time_have" title:@"Time"];

    SYClockViewController *clockVC = [[SYClockViewController alloc]init];
    [self addChildViewController:clockVC withNormalImage:@"icon_clock" selectedImage:@"icon_clock_have" title:@"Clock"];

    SYAboutViewController *perosnVC = [[SYAboutViewController alloc]init];
    [self addChildViewController:perosnVC withNormalImage:@"icon_ren" selectedImage:@"icon_ren_have" title:@"About us"];
    
}

-(void)addChildViewController:(UIViewController *)childController withNormalImage:(NSString *)normalImage selectedImage:(NSString *)selectedImage title:(NSString *)title{
    
    //1.设置顶部导航栏标题和底部导航栏标题
    if (title) {
        childController.title = title;
    }
//    self.tabBar.tintColor = rgba(70, 165, 59, 1);
    //2.设置普通状态 和 选中状态图片
    if (normalImage) {
        UIImage * img = [[UIImage imageNamed:normalImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        childController.tabBarItem.image = img;
    }
    if (selectedImage) {
        childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    //3.创建自定义导航控制器
    BasicNavViewController  *navigationController = [[BasicNavViewController alloc] initWithRootViewController:childController];
    //4.将导航控制器作为子控制器添加到tabbarController上
    [self addChildViewController:navigationController];
    
}



@end
