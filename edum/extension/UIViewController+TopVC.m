//
//  UIViewController+TopVC.m
//  IMaster
//
//  Created by sharon on 2022/5/21.
//  Copyright © 2022 jzsec. All rights reserved.
//

#import "UIViewController+TopVC.h"

@implementation UIViewController (TopVC)

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getTopVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [self getTopVCFrom:rootViewController];
}

- (UIViewController *)getTopVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }

    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getTopVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getTopVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    
    return currentVC;
}
@end
