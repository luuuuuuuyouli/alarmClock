//
//  BasicNavViewController.m
//  basisProject
//
//  Created by shenyong on 2019/2/27.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import "BasicNavViewController.h"

static NSArray *loginAuthClassArray = nil;

@interface BasicNavViewController ()<UIGestureRecognizerDelegate>

@end

@implementation BasicNavViewController

+ (void)initialize
{
    
}


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [self initWithRootViewController:rootViewController setBarBack: [UIColor colorWithWhite:1.0 alpha:1.0]];
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    __weak typeof (self) weakSelf = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (id)initWithRootViewController:(UIViewController *)rootViewController   setBarBack:(id)barBack
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        self.view.layer.masksToBounds = YES;
        self.delegate = self;
    }
    
    return self;
    
}

#pragma mark logon auth

- (BOOL)needLogonAuth:(UIViewController *)viewController{
    BOOL need = NO;
    for (id class in loginAuthClassArray) {
        if ([[viewController class] isSubclassOfClass:class]) {
            need = YES;
            break;
        }
    }
    
    return need;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 如果当前正是在pop的过程，就禁止左边缘右滑手势
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer )]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [super pushViewController:viewController animated:animated];
    
}


- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //  位于当前的navigationController的第一个（【0】viewcontroller时需要设置手势代理，不响应）.
    if ( [viewController.class  isSubclassOfClass:navigationController.childViewControllers[0].class ]) {
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else{
        if ([navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            navigationController.interactivePopGestureRecognizer.enabled = YES;
        }
    }
}


@end
