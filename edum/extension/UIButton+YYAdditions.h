//
//  UIButton+YYAdditions.h
//  Qeegoo
//
//  Created by suchangqin on 13-9-11.
//  Copyright (c) 2013年 suchangqin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YYAdditions)
//根据文字自适应宽度
/*
-(void) autoWidthWithTitleAndPaddingHorizontal:(float) h; // h better set to 8
 */
// 自动将背景图片的中心像素进行拉伸
-(void) stretchableBackgroundImageAutoForState:(UIControlState) state;
-(void)addCorner;
@end
