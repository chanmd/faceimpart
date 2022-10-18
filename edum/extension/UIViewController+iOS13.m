//
//  UIViewController+iOS13.m
//  Broker
//
//  Created by 于建祥 on 2020/3/31.
//  Copyright © 2020 九州证券. All rights reserved.
//

#import "UIViewController+iOS13.h"
#import <objc/runtime.h>


@implementation UIViewController (iOS13)

+ (void)load
{
    Method carshMethod = class_getInstanceMethod([self class], @selector(presentViewController: animated: completion:));
    Method newMethod = class_getInstanceMethod([self class], @selector(jz_presentViewController: animated: completion:));
    method_exchangeImplementations(carshMethod, newMethod);
}

- (void)jz_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    if (@available(iOS 13.0, *)) {
        // iOS13以后style默认UIModalPresentationAutomatic，以前版本xcode没有这个枚举，所以只能写-2
        if (viewControllerToPresent.modalPresentationStyle == -2 || viewControllerToPresent.modalPresentationStyle == UIModalPresentationPageSheet) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
    }
    [self jz_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

@end
