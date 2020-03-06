//
//  UILabel+LineSpace.h
//  gwlx
//
//  Created by Chan Kevin on 23/8/2016.
//  Copyright © 2016 Kevin Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (LineSpace)

- (void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

+ (CGFloat)text:(NSString*)text font:(UIFont *)font width:(CGFloat)width lineSpacing:(CGFloat)lineSpacing;

@end
