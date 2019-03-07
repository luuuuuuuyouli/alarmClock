//
//  UIView+shadow.h
//  basisProject
//
//  Created by syong on 2019/2/28.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (shadow)

//设置阴影效果
- (void)setLayerShadowWith:(UIColor *)color offset:(NSInteger)offset radius:(CGFloat)radius shadowOpacity:(CGFloat)shadowOpacity;

@end

NS_ASSUME_NONNULL_END
