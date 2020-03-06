//
//  UIButton+YYAdditions.m
//  Qeegoo
//
//  Created by suchangqin on 13-9-11.
//  Copyright (c) 2013年 suchangqin. All rights reserved.
//

#import "UIButton+YYAdditions.h"

@implementation UIButton (YYAdditions)

/*
-(void) autoWidthWithTitleAndPaddingHorizontal:(float) h{
    UIButton *button = self;
    NSString *title = [button titleForState:UIControlStateNormal];
    
    // 计算宽度
    CGRect frame = button.frame;
    CGSize size = [title appSizeWithFont:button.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, frame.size.height) lineBreakMode:NSLineBreakByWordWrapping];
    float calWidth = size.width + h*2;
    
    frame.size.width = calWidth;
    button.frame = frame;
}
*/
-(void) stretchableBackgroundImageAutoForState:(UIControlState) state{
    UIImage *image = [self backgroundImageForState:state];
    if (image) {
        [self setBackgroundImage:[image stretchableImageWithLeftCapWidth:image.size.width/2.0 topCapHeight:image.size.height/2.0] forState:state];
    }
}
-(void)addCorner
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 2.0;
}
@end
