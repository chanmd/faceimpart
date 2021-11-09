//
//  UIColor+ColorExtension.h
//  MRColor
//
//  Created by Mac on 16/6/2.
//  Copyright (c) 2015年 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

//colors
#define __color_gray_background [UIColor colorWithHEX:0xf9f9f9]
#define __color_gray_separator [UIColor colorWithHEX:0xe5e5e5]
#define __color_gray_light [UIColor colorWithHEX:0xdcdcdc]
#define __color_red_main [UIColor colorWithHEX:0xeb5c4a]
#define __color_font_title [UIColor colorWithHEX:0x333333]
#define __color_font_subtitle [UIColor colorWithHEX:0x777777]
#define __color_font_placeholder [UIColor colorWithHEX:0x999999]
#define __color_white [UIColor colorWithHEX:0xffffff]
#define __color_black [UIColor colorWithHEX:0x000000]
#define __color_clear [UIColor clearColor]
#define __color_tabbar [UIColor colorWithHEX:0x2a383f]
#define __color_navigation [UIColor colorWithHEX:0xffffff Alpha:0.98]
#define __color_green [UIColor colorWithHEX:0x00a93d]
#define __color_red [UIColor colorWithHEX:0xfe9796]

#define __color_button_blue [UIColor colorWithHEX:0x1199ee]
#define __color_main [UIColor colorWithHEX:0xeb5c4a]
#define __color_main_alpha [UIColor colorWithHEX:0xeb5c4a Alpha:0.8]

#define KCSYSFONTNAMETHIN @"HelveticaNeue-Thin"
#define KCSYSFONTNAMELIGHT @"HelveticaNeue"//@"HelveticaNeue-Light"
#define KCSYSFONTNAME @"HelveticaNeue"
#define KCSYSFONTNAMEMEDIUM @"HelveticaNeue-Medium"
#define KCSYSFONTNAMEBOLD @"HelveticaNeue-Medium"
//#define KCSYSFONTNAMETHIN @"Avenir-Light"
//#define KCSYSFONTNAMELIGHT @"Avenir-Light"
//#define KCSYSFONTNAME @"Avenir-Medium"
//#define KCSYSFONTNAMEMEDIUM @"Avenir-Heavy"
//#define KCSYSFONTNAMEBOLD @"Avenir-Heavy"

//fonts
#define __fontthin(sizee) [UIFont fontWithName:KCSYSFONTNAMETHIN size:sizee]
#define __fontlight(sizee) [UIFont fontWithName:KCSYSFONTNAMELIGHT size:sizee]
#define __font(sizee) [UIFont fontWithName:KCSYSFONTNAME size:sizee]
#define __fontmedium(sizee) [UIFont fontWithName:KCSYSFONTNAMEMEDIUM size:sizee]
#define __fontbold(sizee) [UIFont fontWithName:KCSYSFONTNAMEBOLD size:sizee]


@interface UIColor (ColorExtension)

+ (UIColor *)colorWithHEX:(uint)color;
+ (UIColor *)colorWithHEX:(uint)color Alpha:(CGFloat)alpha;
+ (NSArray*)colorForHex:(NSString *)hexColor;
+ (UIColor *)randomColor;
+ (UIColor *)flashColorWithRed:(uint)red green:(uint)green blue:(uint)blue alpha:(float)alpha;
+ (UIColor *)colorWithPatternImageName:(NSString *)imageName;

//颜色:得到16#转rgb
+ (UIColor *) callColorFromHexRGB:(NSString *) inColorString;
@end
