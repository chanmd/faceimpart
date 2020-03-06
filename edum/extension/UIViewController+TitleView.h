//
//  UIViewController+TitleView.h
//  JRJNews
//
//  Created by mac on 15-8-1.
//  Copyright (c) 2015年 九州证券. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TitleView)

//标题栏 图片
- (UIImage *)titleImage;
//标题栏 图片大小
- (CGSize)titleImageSize;
//重新加载标题
- (void)setVCTitle:(NSString *)title;

@end
