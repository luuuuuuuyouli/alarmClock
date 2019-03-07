//
//  UIView+shadow.m
//  basisProject
//
//  Created by syong on 2019/2/28.
//  Copyright © 2019年 shenyong. All rights reserved.
//

#import "UIView+shadow.h"

@implementation UIView (shadow)

- (void)setLayerShadowWith:(UIColor *)color offset:(NSInteger)offset radius:(CGFloat)radius shadowOpacity:(CGFloat)shadowOpacity{
    // 设置阴影颜色
    self.layer.shadowColor = color.CGColor;
    // 设置阴影的偏移量，默认是（0， -3）
    self.layer.shadowOffset = CGSizeMake(0, offset);
    // 设置阴影不透明度，默认是0
    self.layer.shadowOpacity = shadowOpacity;
    // 设置阴影的半径，默认是3
    self.layer.shadowRadius = radius;
}

@end
