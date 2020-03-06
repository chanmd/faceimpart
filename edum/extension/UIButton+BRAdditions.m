//
//  UIButton+YYAdditions.m
//  Qeegoo
//
//  Copyright (c) 2013年 suchangqin. All rights reserved.
//

#import "UIButton+BRAdditions.h"
#import "UIButton+YYAdditions.h"
#import "UIImage+initWithColor.h"
#import "UIColor+ColorExtension.h"

@implementation UIButton (BRAdditions)
//设置红色背景
- (void)stretchableBackgroundImage_red
{
    [self setBackgroundImage:[UIImage imageNamed:@"button_red"] forState:UIControlStateNormal];
    [self stretchableBackgroundImageAutoForState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"button_red_click"] forState:UIControlStateHighlighted];
    [self stretchableBackgroundImageAutoForState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"button_grey"] forState:UIControlStateDisabled];
    [self stretchableBackgroundImageAutoForState:UIControlStateDisabled];
}
//设置绿色背景
- (void)stretchableBackgroundImage_green
{
    [self setBackgroundImage:[UIImage imageNamed:@"button_green"] forState:UIControlStateNormal];
    [self stretchableBackgroundImageAutoForState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"button_green_click"] forState:UIControlStateHighlighted];
    [self stretchableBackgroundImageAutoForState:UIControlStateHighlighted];
}

//设置灰色背景
- (void)stretchableBackgroundImage_lightGray
{
    [self setBackgroundImage:[UIImage imageNamed:@"button_gray"] forState:UIControlStateNormal];
    [self stretchableBackgroundImageAutoForState:UIControlStateNormal];
}

//设置藏蓝色背景
- (void)stretchableBackgroundImage_blackBlue
{
    [self setBackgroundImage:[UIImage imageNamed:@"button_blackBlue"] forState:UIControlStateNormal];
    [self stretchableBackgroundImageAutoForState:UIControlStateNormal];
}


- (void)stretchableBackgroundImage_gray
{
    [self setBackgroundImage:[UIImage imageWithColor:__color_navigation] forState:UIControlStateNormal];
    [self stretchableBackgroundImageAutoForState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:__color_navigation] forState:UIControlStateHighlighted];
    [self stretchableBackgroundImageAutoForState:UIControlStateHighlighted];
}

- (void)centerVerticallyWithPadding:(float)padding
{
    if (APPSystemVersion > 7.0) {
        // the space between the image and text
        CGFloat spacing = padding;
        
        // lower the text and push it left so it appears centered
        //  below the image
        CGSize imageSize = self.imageView.image.size;
        self.titleEdgeInsets = UIEdgeInsetsMake(
                                                  0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        //  above the text
        CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
        self.imageEdgeInsets = UIEdgeInsetsMake(
                                                  - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
    } else {
        
        // the space between the image and text
        CGFloat spacing = padding;
        
        // lower the text and push it left so it appears centered
        //  below the image
        CGSize imageSize = self.imageView.frame.size;
        self.titleEdgeInsets = UIEdgeInsetsMake(
                                                  0.0, - imageSize.width, - (imageSize.height + spacing), 0.0);
        
        // raise the image and push it right so it appears centered
        //  above the text
        CGSize titleSize = self.titleLabel.frame.size;
        self.imageEdgeInsets = UIEdgeInsetsMake(
                                                  - (titleSize.height + spacing), 0.0, 0.0, - titleSize.width);
        
    }
    
}


- (void)centerVertically
{
    const CGFloat kDefaultPadding = 6.0f;
    
    [self centerVerticallyWithPadding:kDefaultPadding];
}



@end
