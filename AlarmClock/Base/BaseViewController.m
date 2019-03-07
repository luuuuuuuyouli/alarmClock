//
//  BaseViewController.m
//  basisProject
//
//  Created by shenyong on 2019/2/27.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@property (nonatomic,strong)  UIImageView *navBarHairlineImageView;

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];

   
}


-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    [self setNeedsStatusBarAppearanceUpdate];
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"fanhui"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:nil action:nil];
    //隐藏默认的返回箭头
    self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage new];


    if (self.navigationController) {
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }
    
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:RGB16(0x333333)}];
    
    
}




@end
