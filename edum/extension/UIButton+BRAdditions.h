//
//  UIButton+YYAdditions.h
//  Qeegoo
//
//  Copyright (c) 2013年 suchangqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (BRAdditions)
//设置红色背景
- (void)stretchableBackgroundImage_red;
//设置绿色背景
- (void)stretchableBackgroundImage_green;
//设置灰色背景
- (void)stretchableBackgroundImage_lightGray;
//nav 的那个颜色
- (void)stretchableBackgroundImage_gray;

//设置藏蓝色背景
- (void)stretchableBackgroundImage_blackBlue;


- (void)centerVerticallyWithPadding:(float)padding;
- (void)centerVertically;

@end
