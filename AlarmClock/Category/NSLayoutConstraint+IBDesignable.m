//
//  NSLayoutConstraint+IBDesignable.m
//  LiliaoAPP
//
//  Created by shenyong on 2018/7/14.
//  Copyright © 2018年 shenyong. All rights reserved.
//

#import "NSLayoutConstraint+IBDesignable.h"

@implementation NSLayoutConstraint (IBDesignable)

- (void)setAdapterScreen:(BOOL)adapterScreen{
    
    if ([self adapterScreen]){
        self.constant = self.constant * KsuitParam;
    }
}

- (BOOL)adapterScreen{
    return YES;
}


@end
