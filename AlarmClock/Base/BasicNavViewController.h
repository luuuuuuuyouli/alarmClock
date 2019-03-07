//
//  BasicNavViewController.h
//  basisProject
//
//  Created by shenyong on 2019/2/27.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicNavViewController : UINavigationController<UINavigationControllerDelegate>

- (id)initWithRootViewController:(UIViewController *)rootViewController  setBarBack:(id)barBack;

@end

NS_ASSUME_NONNULL_END
