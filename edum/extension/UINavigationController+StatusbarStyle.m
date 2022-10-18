//
//  UINavigationController+StatusbarStyle.m
//  IMaster
//
//  Created by sharon on 2022/5/21.
//  Copyright © 2022 jzsec. All rights reserved.
//

#import "UINavigationController+StatusbarStyle.h"
#import "NSObject+Swizzling.h"
#import "UIViewController+TopVC.h"

@implementation UINavigationController (StatusbarStyle)
+ (void)load {
    //替换 objectAtIndex:
    NSString *oriSelStr = @"childViewControllerForStatusBarStyle";
    NSString *newSelStr = @"safeMutable_objectAtIndex:";
    [NSObject exchangeInstanceMethodWithSelfClass:[UINavigationController class]
                                 originalSelector:NSSelectorFromString(oriSelStr)
                                 swizzledSelector:NSSelectorFromString(newSelStr)];
}

- (UIViewController *)jzs_childViewControllerForStatusBarStyle {
    return [self getTopVC];
}


@end
