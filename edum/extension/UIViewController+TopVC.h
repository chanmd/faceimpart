//
//  UIViewController+TopVC.h
//  IMaster
//
//  Created by sharon on 2022/5/21.
//  Copyright © 2022 jzsec. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (TopVC)

- (UIViewController *)getTopVC;
- (UIViewController *)getTopVCFrom:(UIViewController *)rootVC;

@end

NS_ASSUME_NONNULL_END
