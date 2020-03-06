//
//  UIViewController+TitleView.m
//  JRJNews
//
//  Created by mac on 15-8-1.
//  Copyright (c) 2015年 九州证券. All rights reserved.
//

#import "UIViewController+TitleView.h"
#import <objc/runtime.h>

static char * titleViewGloable;

@implementation UIViewController (TitleView)

- (CGRect)initItemViewRect
{
    return CGRectMake(0, 0, 40, 40);
}

- (UIImage *)titleImage
{
    return nil;
}

- (CGSize)titleImageSize
{
    return CGSizeZero;
}

@end
