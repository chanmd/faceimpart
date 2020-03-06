//
//  CalHeader.m
//  edum
//
//  Created by Kevin Chan on 27/5/2019.
//  Copyright © 2019 MD Chen. All rights reserved.
//

#import "CalHeader.h"
#import "UIImage+initWithColor.h"
#import "UIView+BFExtension.h"
#import "UIColor+ColorExtension.h"

#define LABEL_TIME 40
#define LABEL_WIDTH (APPScreenWidth - LABEL_TIME) / 7
#define LABEL_Y 0
#define LABLE_HEIGHT 40

@implementation CalHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.border_a];
        [self addSubview:self.border_b];
        [self addSubview:self.border_c];
        [self addSubview:self.border_d];
        [self addSubview:self.border_e];
        [self addSubview:self.border_f];
        [self addSubview:self.border_g];
        
        [self addSubview:self.label_a];
        [self addSubview:self.label_b];
        [self addSubview:self.label_c];
        [self addSubview:self.label_d];
        [self addSubview:self.label_e];
        [self addSubview:self.label_f];
        [self addSubview:self.label_g];
        
        [self addSubview:self.border_line];
        [self addSubview:self.border_line_up];
//        self.backgroundColor = __color_gray_background;
    }
    return self;
}

- (UILabel *)label_a
{
    if (!_label_a) {
        _label_a = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 0, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_a.font = __font(18);
        _label_a.textColor = __color_font_title;
        _label_a.text = @"一";
        _label_a.textAlignment = NSTextAlignmentCenter;
    }
    return _label_a;
}

- (UILabel *)label_b
{
    if (!_label_b) {
        _label_b = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 1, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_b.font = __font(18);
        _label_b.textColor = __color_font_title;
        _label_b.text = @"二";
        _label_b.textAlignment = NSTextAlignmentCenter;
    }
    return _label_b;
}

- (UILabel *)label_c
{
    if (!_label_c) {
        _label_c = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 2, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_c.font = __font(18);
        _label_c.textColor = __color_font_title;
        _label_c.text = @"三";
        _label_c.textAlignment = NSTextAlignmentCenter;
    }
    return _label_c;
}

- (UILabel *)label_d
{
    if (!_label_d) {
        _label_d = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 3, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_d.font = __font(18);
        _label_d.textColor = __color_font_title;
        _label_d.text = @"四";
        _label_d.textAlignment = NSTextAlignmentCenter;
    }
    return _label_d;
}

- (UILabel *)label_e
{
    if (!_label_e) {
        _label_e = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 4, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_e.font = __font(18);
        _label_e.textColor = __color_font_title;
        _label_e.text = @"五";
        _label_e.textAlignment = NSTextAlignmentCenter;
    }
    return _label_e;
}

- (UILabel *)label_f
{
    if (!_label_f) {
        _label_f = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 5, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_f.font = __font(18);
        _label_f.textColor = __color_font_title;
        _label_f.text = @"六";
        _label_f.textAlignment = NSTextAlignmentCenter;
    }
    return _label_f;
}

- (UILabel *)label_g
{
    if (!_label_g) {
        _label_g = [[UILabel alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 6, LABEL_Y, LABEL_WIDTH, LABLE_HEIGHT)];
        _label_g.font = __font(18);
        _label_g.textColor = __color_font_title;
        _label_g.text = @"日";
        _label_g.textAlignment = NSTextAlignmentCenter;
    }
    return _label_g;
}

- (UIView *)border_a
{
    if (!_border_a) {
        _border_a = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 0, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_a.backgroundColor = __color_gray_background;
    }
    return _border_a;
}

- (UIView *)border_b
{
    if (!_border_b) {
        _border_b = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 1, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_b.backgroundColor = __color_gray_background;
    }
    return _border_b;
}

- (UIView *)border_c
{
    if (!_border_c) {
        _border_c = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 2, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_c.backgroundColor = __color_gray_background;
    }
    return _border_c;
}

- (UIView *)border_d
{
    if (!_border_d) {
        _border_d = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 3, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_d.backgroundColor = __color_gray_background;
    }
    return _border_d;
}

- (UIView *)border_e
{
    if (!_border_e) {
        _border_e = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 4, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_e.backgroundColor = __color_gray_background;
    }
    return _border_e;
}

- (UIView *)border_f
{
    if (!_border_f) {
        _border_f = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 5, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_f.backgroundColor = __color_gray_background;
    }
    return _border_f;
}

- (UIView *)border_g
{
    if (!_border_g) {
        _border_g = [[UIView alloc] initWithFrame:CGRectMake(LABEL_TIME + LABEL_WIDTH * 6, LABEL_Y, 0.5, LABLE_HEIGHT)];
        _border_g.backgroundColor = __color_gray_background;
    }
    return _border_g;
}

- (UIView *)border_line
{
    if (!_border_line) {
        _border_line = [[UIView alloc] initWithFrame:CGRectMake(0, LABLE_HEIGHT - 0.5, APPScreenWidth, 0.5)];
        _border_line.backgroundColor = __color_gray_background;
    }
    return _border_line;
}

- (UIView *)border_line_up
{
    if (!_border_line_up) {
        _border_line_up = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APPScreenWidth, 0.5)];
        _border_line_up.backgroundColor = __color_gray_background;
    }
    return _border_line_up;
}

@end
